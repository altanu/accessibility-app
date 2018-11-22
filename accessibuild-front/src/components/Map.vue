<template>
  <div style="height: 100%">
    <gmap-map ref="mapRef"
      :center="center"
      :zoom="12"
      v-bind:options="mapStyle"
      style="min-width:50%; height: 100%">

        <!-- <GmapMarker v-if="placesList.length < 1"
          :position="center"
          :clickable="false"
          :draggable="false"
        /> -->

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
var axios = require('axios')

export default {
  name: 'GoogleMap',
  props: {
    placesList: Array
  },
  data () {
    return {
      center: {lat: 45.5035, lng: -73.5685},
      userPlace: {},
      markers: [],
      newPlaceList: [],
      mapStyle: { styles: [ { 'featureType': 'poi', 'stylers': [ { 'visibility': 'off' } ] } ] },
      pinStyles: ['/redPin.png', '/yellowPin.png', '/greenPin.png', '/greyPin.png']
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
      var self = this
      var selectedCard = document.getElementById(marker.place_id)
      if (selectedCard) {
        selectedCard.scrollIntoView({behavior: "smooth"})
        selectedCard.style.border = '3px solid black'
        setTimeout(() => {
          selectedCard.style.border = '1px solid grey'
        }, 2000)
      }
      if (selectedCard === null) {
        var geocoder = new google.maps.Geocoder()
        geocoder.geocode({'location': marker.position}, function(results,status) {
          self.$emit('new-list', [results[0]])
        })
      }
    },
    geolocate() {
      var self = this
      var geocoder = new google.maps.Geocoder()
      navigator.geolocation.getCurrentPosition(position => {
        geocoder.geocode({ 'location': {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        } }, function (results, status) {
          self.userPlace = results[0]
          self.center.lat = self.userPlace.geometry.location.lat()
          self.center.lng = self.userPlace.geometry.location.lng()
          self.$emit('user-detected-place', results[0])
        })
      })
    },
    populateMapFromDB () {
      var self = this
      axios
        .get('http://localhost:3000/api/v2/locations')
        .then(response => {
          response.data.forEach(location => {
            self.drawWithAccessibility(location)
          })
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
    drawWithAccessibility(location) {
      var self = this
      this.$refs.mapRef.$mapPromise.then((map) => {
        self.markers.push(new google.maps.Marker({
          map: map,
          icon: self.pinStyles[location['wheelchair']],
          position: { lat: Number(location.lat), lng: Number(location.lng) },
          place_id: location.place_id
        }))
      })
    },
  },
  mounted () {
    var self = this
    this.populateMapFromDB()

    this.$refs.mapRef.$mapPromise.then((map) => {
      self.geolocate()
      var input = document.getElementById('pac-input')
      var searchBox = new google.maps.places.SearchBox(input)
      var geocoder = new google.maps.Geocoder()

      // Bias the SearchBox results towards current map's viewport.
      map.addListener('bounds_changed', function () {
        searchBox.setBounds(map.getBounds())
      })

      // Listen for the event fired when the user selects a prediction and retrieve
      // more details for that place.
      searchBox.addListener('places_changed', function () {
        self.newPlaceList = []
        var searchPlaces = searchBox.getPlaces()

        if (searchPlaces.length == 0) {
          return
        }

        // Clear out the old markers.
        self.markers.forEach(function (marker) {
          marker.setMap(null)
        })
        self.markers = []

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds()

        searchPlaces.forEach(function (place) {
          geocoder.geocode({ 'address': place.formatted_address }, function (results, status) {
            place = results[0]
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
    })
  },
}
</script>
