<template>
  <div style="height: 100%">
    <gmap-map ref="mapRef"
      :center="{lat: 45.5, lng: -73.5}"
      :zoom="16"
      v-bind:options="mapStyle"
      style="min-width:50%; height: 100%">

        <!-- <GmapMarker
          :position="userPlace.geometry.location"
          :clickable="false"
          :draggable="false"
        /> -->

        <!-- <GmapMarker
          v-for="marker in markers"
          :id="marker.place_id"
          :key="marker.place_id"
          :position="marker.position"
          :clickable="true"
          :draggable="false"
          :icon="marker.icon"
          @click="selectCard(marker)"
        /> -->

    </gmap-map>
  </div>
</template>

<script>
var axios = require('axios')

export default {
  name: 'GoogleMap',
  props: {
    placesList: Array,
  },
  data () {
    return {
      userPlace: {},
      markers: [],
      newPlaceList: [],
      mapStyle: { styles: [ { 'featureType': 'poi', 'stylers': [ { 'visibility': 'off' } ] } ] },
      pinStyles: ['/redPin.png', '/yellowPin.png', '/greenPin.png']
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
      var geocoder = new google.maps.Geocoder()
      geocoder.geocode({ 'placeId': marker.place_id, 'language': 'en' }, function (results, status) {
        self.$emit('new-list', [results[0]])
      })
    },
    selectCard (marker) {
      this.$emit('pin-select', marker.place_id)
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
          self.$emit('user-detected-place', results[0])
        })
      })
    },
    populateMapFromDB () {
      this.$refs.mapRef.$mapPromise.then((map) => {
        axios.get('http://localhost:3000/api/v2/locations')
          .then(response => {
            response.data.forEach(location => {
            // Create a marker for every tenth place
              self.markers.push(new google.maps.Marker({
                map: map,
                icon: (function () {
                  return self.pinStyles[location['wheelchair']]
                }()),
                position: { lat: Number(location.lat), lng: Number(location.lng) },
                place_id: location.place_id
              }))
            })
          })
      })
    }
  },
  mounted () {
    var self = this
    // this.populateMapFromDB()

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
    })
  },
}
</script>
