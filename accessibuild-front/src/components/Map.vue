<template>
  <div style="height: 100%">
    <gmap-map ref="mapRef"
      :center="currentPlace"
      :zoom="zoom"
      v-bind:options="mapStyle"
      style="min-width:50%; height: 100%">

        <GmapMarker v-if="placesList.length <= 1"
          :position="currentPlace"
          @click="clickPin"
          @mouseover="hoverPin"
        />

        <GmapMarker
          v-for="marker in markers"
          :key="marker.place_id"
          :position="marker.position"
          :clickable="true"
          :draggable="false"
          :icon="marker.icon"
          @click="clickPin"
          @mouseover="hoverPin"
        />

    </gmap-map>
  </div>
</template>

<script>
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
      newPlaceList: [],
      mapStyle: { styles: [ { 'featureType': 'poi', 'stylers': [ { 'visibility': 'off' } ] } ] }
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
      var geocoder = new google.maps.Geocoder
      geocoder.geocode({'location': marker.latLng}, function(results, status) {
        self.$emit('new-list', [results[0]])
      })
    },
    hoverPin (marker) {
      let self = this
      var geocoder = new google.maps.Geocoder
      geocoder.geocode({'location': marker.latLng}, function(results, status) {
        self.$emit('pin-hover', results[0].place_id)
      })
    }
  },
  mounted () {
    var self = this

    this.$refs.mapRef.$mapPromise.then((map) => {
      var input = document.getElementById('pac-input')
      var searchBox = new google.maps.places.SearchBox(input)
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

          service.textSearch({'location': place.geometry.location, 'query': place.formatted_address}, function(results, status) {
            place = results[0]
          })

          self.updatePlacesList(place)

          if (!place.geometry) {
            console.log('Returned place contains no geometry')
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
            placeID: place.place_id
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
