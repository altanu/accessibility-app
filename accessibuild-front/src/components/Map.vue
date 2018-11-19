<template>
  <div style="height: 100%">
    <gmap-map ref="mapRef"
      :center="currentPlace"
      :zoom="zoom"
      style="min-width:50%; height: 100%">
    </gmap-map>
  </div>
</template>

<script>

export default {
  name: 'GoogleMap',
  props: {
    currentPlace: Object,
    placesList: Array,
    addressString: Array
  },
  data () {
    return {
      center: this.currentPlace,
      zoom: 16,
    }
  },
  methods: {
    updatePlacesList(newPlace, index) {
      this.placesList[index] = newPlace
    },
  },
  mounted () {
    var self = this
    
    this.$refs.mapRef.$mapPromise.then((map) => {
      var input = document.getElementById('pac-input');
      var searchBox = new google.maps.places.SearchBox(input);
      
      // Bias the SearchBox results towards current map's viewport.
      map.addListener('bounds_changed', function() {
        searchBox.setBounds(map.getBounds());
      });
      var markers = [];
      // Listen for the event fired when the user selects a prediction and retrieve
      // more details for that place.
      searchBox.addListener('places_changed', function() {
        console.log("called places_changed event")
        self.newPlaceList = [];
        var searchPlaces = searchBox.getPlaces()

        if (searchPlaces.length == 0) {
          return
        }

        // Clear out the old markers.
        markers.forEach(function(marker) {
          marker.setMap(null)
        });
        markers = []

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds()

        var i = 0;
        searchPlaces.forEach(function(place) {
          if (!place.geometry) {
            console.log("Returned place contains no geometry")
            return
          }

          console.log("writing", place, "at index", i)
          self.updatePlacesList(place, i)
          var icon = {
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(25, 25)
          }

          // Create a marker for each place.
          markers.push(new google.maps.Marker({
            map: map,
            icon: icon,
            title: place.name,
            position: place.geometry.location
          }))

          if (place.geometry.viewport) {
            // Only geocodes have viewport.
            bounds.union(place.geometry.viewport)
          } else {
            bounds.extend(place.geometry.location)
          }
          i++
        })
        map.fitBounds(bounds)
      })
    }).then(function() {
      var geocoder = new google.maps.Geocoder
      navigator.geolocation.getCurrentPosition(position => {
        geocoder.geocode({'location': {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          }}, function(results, status) {
            self.$emit('address-change', results)
          })
        })
    })
  }
}
</script>