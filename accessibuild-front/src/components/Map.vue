<template>
  <div style="height: 100%">
    <gmap-map ref="mapRef"
      :center="currentPlace"
      :zoom="zoom"
      v-bind:options="mapStyle"
      style="min-width:50%; height: 100%">

        <GmapMarker v-if="placesList.length <= 1"
          :position="currentPlace"
          :clickable="false"
          :draggable="false"
        />

        <GmapMarker v-if="placesList.length <= 1"
          v-for="marker in defaultMarkers"
          :id="marker.place_id"
          :key="marker.place_id"
          :position="marker.position"
          :clickable="false"
          :draggable="false"
          :icon="marker.icon"
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
var axios = require('axios')

export default {
  name: 'GoogleMap',
  props: {
    currentPlace: Object,
    placesList: Array,
    addressString: String
  },
  data () {
    return {
      center: this.currentPlace,
      zoom: 16,
      markers: [],
      defaultMarkers: [],
      newPlaceList: [],
      mapStyle: { styles: [ { 'featureType': 'poi', 'stylers': [ { 'visibility': 'off' } ] } ] },
      pinStyles: ['/redPin.png','/yellowPin.png','/greenPin.png']
    }
  },
  methods: {
    updatePlacesList (newPlace) {
      this.newPlaceList.push(newPlace)
    },
    publishNewList () {
      this.$emit('new-list', this.newPlaceList)
    },
    clickPin (marker) {
      let self = this
      console.log("clickedPin", marker)
      var geocoder = new google.maps.Geocoder()
      geocoder.geocode({ 'placeId': marker.place_id, 'language': 'en' }, function (results, status) {
        console.log("geocoder returned", results, "will emit message now")
        self.$emit('new-list', [results[0]])
      })
    },
    selectCard (marker) {
      console.log("selectCard was called with", marker)
      this.$emit('pin-select', marker.place_id)
    },
    populateMapFromDB () {
      var self = this
      this.$refs.mapRef.$mapPromise.then((map) => {
        axios.get('http://localhost:3000/api/v2/locations')
        .then(response => {
          response.data.forEach(location => {
            // Create a marker for every tenth place
            self.defaultMarkers.push(new google.maps.Marker({
              map: map,
              icon: function () {
                return self.pinStyles[location["wheelchair"]]
              }(),
              position: {lat: Number(location.lat), lng: Number(location.lng)},
              place_id: location.place_id
            }))
          })
        })
      })
    }
  },
  mounted () {
    this.populateMapFromDB()
    var self = this

    this.$refs.mapRef.$mapPromise.then((map) => {
      var input = document.getElementById('pac-input')
      var searchBox = new google.maps.places.SearchBox(input)
      var geocoder = new google.maps.Geocoder()
      var service = new google.maps.places.PlacesService(map)

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
          geocoder.geocode({ placeId: place.place_id }, function (results, status) {
            place = results[0]
          })

          self.updatePlacesList(place)

          if (!place.geometry) {
            // Returned place contains no geometry
            return
          }

          var icon = {
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(25, 25)
          }

          // Create a marker for each place.
          self.markers.push(new google.maps.Marker({
            map: map,
            icon: icon,
            title: place.name,
            position: place.geometry.location,
            place_id: place.place_id
          }))

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
    }).then(function () {
      var geocoder = new google.maps.Geocoder()
      navigator.geolocation.getCurrentPosition(position => {
        geocoder.geocode({ 'location': {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        } }, function (results, status) {
          self.$emit('address-change', results[0].formatted_address)
        })
      })
    })
  }
}
</script>
