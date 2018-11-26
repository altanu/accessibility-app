<template>
  <div style="height: 100%; border-right: 2px solid #4343EA; display:flex; align-items: center; justify-content: center">
    <div style="display: flex">
    <pulse-loader :loading="loading" :color="brandBlue" style="margin:auto; height:100%"></pulse-loader>
    </div>
    <gmap-map ref="mapRef"
      :center="center"
      :zoom="12"
      :options="mapStyle"
      style="min-width:100%; height: 100%; display: none">

        <!-- user location -->
        <GmapMarker
          :position="userCoordinates"
          :clickable="true"
          :draggable="false"
          @click="selectCard(userPlace)"
        />

        <GmapMarker
          v-for="marker in markers"
          :id="marker.place_id"
          :key="marker.place_id"
          :position="marker.position"
          :clickable="true"
          :draggable="false"
          :icon="marker.icon"
          @click="selectCard(marker)"
        />
    </gmap-map>
  </div>
</template>

<script>
import PulseLoader from 'vue-spinner/src/PulseLoader.vue'

var axios = require('axios')

export default {
  name: 'GoogleMap',
  props: {
    placesList: Array
  },
  data () {
    return {
      center: { lat: 45.5035, lng: -73.5685 },
      userPlace: {},
      userCoordinates: { lat: 0, lng: 0 },
      markers: [],
      newPlaceList: [],
      mapStyle: { styles: [ { 'featureType': 'poi', 'stylers': [ { 'visibility': 'off' } ] } ],
        streetViewControl: false,
        fullscreenControl: false,
        mapTypeControl: false },
      pinStyles: ['/redPin.png', '/yellowPin.png', '/greenPin.png', '/greyPin.png'],
      loading: true,
      brandBlue: "#4343EA"
    }
  },
  methods: {
    updatePlacesList (newPlace) {
      this.newPlaceList.push(newPlace)
    },
    publishNewList () {
      this.$emit('new-list', this.newPlaceList)
    },
    selectCard (marker) {
      this.$refs.mapRef.$mapPromise.then((map) => {
        map.panTo(marker.position)
      })
      var self = this
      var selectedCard = document.getElementById(marker.place_id)
      if (selectedCard) {
        selectedCard.scrollIntoView({ behavior: 'smooth' })
        selectedCard.style.border = '3px solid black'
        setTimeout(() => {
          selectedCard.style.border = '1px solid grey'
        }, 2000)
      }
      if (selectedCard === null) {
        var geocoder = new google.maps.Geocoder()
        geocoder.geocode({ 'placeId': marker.place_id }, function (results, status) {
          self.$emit('new-list', [results[0]])
        })
      }
    },
    geolocate () {
      var self = this
      var geocoder = new google.maps.Geocoder()
      navigator.geolocation.getCurrentPosition(position => {
        geocoder.geocode({ 'location': {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        } }, function (results, status) {
          self.userPlace = results[0]
          self.userCoordinates.lat = self.userPlace.geometry.location.lat()
          self.userCoordinates.lng = self.userPlace.geometry.location.lng()
          self.$emit('user-detected-place', results[0])
        })
      })
    },
    populateMapFromDB () {
      this.markers = []
      var self = this
      axios
        .get('http://localhost:3000/api/v2/locations')
        .then(response => {
          response.data.forEach(location => {
            self.drawWithAccessibility(location)
          })
        }).finally(function () {
          self.loading = false
          document.getElementsByClassName("vue-map-container")[0].style = 'min-width:100%; height: 100%'
        })
    },
    fetchLocationInfo (place, callback) {
      axios.get('http://localhost:3000/api/v2/places/' + place.place_id)
        .then(response => {
          const location = response.data[0]
          if (location) {
            place.wheelchair = location.wheelchair
          } else {
            place.wheelchair = 3
          }
          place.lat = place.geometry.location.lat()
          place.lng = place.geometry.location.lng()
          return place
        }).then((place) => {
          callback(place)
        })
    },
    drawWithAccessibility (location) {
      if (typeof location.lat === 'string') {
        location.lat = Number(location.lat)
        location.lng = Number(location.lng)
      }
      var self = this
      this.$refs.mapRef.$mapPromise.then((map) => {
        self.markers.push(new google.maps.Marker({
          icon: location['wheelchair'] === null ? self.pinStyles[3] : self.pinStyles[location['wheelchair']],
          position: { lat: location.lat, lng: location.lng },
          place_id: location.place_id
        }))
      })
    },
    refreshMap () {
      var self = this
      self.markers = []
      self.newPlaceList.forEach(location => {
        self.fetchLocationInfo(location, self.drawWithAccessibility)
      })
    }
  },
  mounted () {
    this.$parent.$on('app-refresh', this.refreshMap)
    var self = this

    this.$refs.mapRef.$mapPromise.then((map) => {
      self.geolocate()
      var input = document.getElementById('pac-input')
      var searchBox = new google.maps.places.SearchBox(input)
      var geocoder = new google.maps.Geocoder()

      map.addListener('bounds_changed', function () {
        searchBox.setBounds(map.getBounds())
      })

      // Listen for the event fired when the user selects a prediction and retrieve
      // more details for that place.
      searchBox.addListener('places_changed', function () {
        self.newPlaceList = []
        var searchPlaces = searchBox.getPlaces()

        // Clear out the old markers.
        self.markers.forEach(function (marker) {
          marker.setMap(null)
        })
        self.markers = []
        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds()
        searchPlaces.forEach(function (place) {
          var establishmentName = place.name
          geocoder.geocode({ 'address': place.formatted_address }, function (results, status) {
            place = results[0]
            place.name = establishmentName
            self.updatePlacesList(place)
            self.fetchLocationInfo(place, self.drawWithAccessibility)
          })
          if (place.geometry.viewport) {
            // Only geocodes have viewport.
            bounds.union(place.geometry.viewport)
          } else {
            bounds.extend(place.geometry.location)
          }
        })
        self.publishNewList()
        map.fitBounds(bounds)
      })
    }).then(() => {
      self.populateMapFromDB()
    })
  },
  components: {
    PulseLoader
  }
}
</script>
