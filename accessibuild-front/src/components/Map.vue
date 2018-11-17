<template>
  <div style="height: 100%">
    <gmap-map ref="mapRef"
      :center="currentPlace"
      :zoom="zoom"
      style="min-width:50%; height: 100%"
    >        

      <gmap-marker></gmap-marker>
    </gmap-map>
  </div>
</template>

<script>

export default {
  
  name: 'GoogleMap',
  props: {
    currentPlace: Object
  },
  data () {
    return {
      center: this.currentPlace,
      zoom: 16,
      markers: [],
      places: [],
    }
  },

  mounted () {    
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
        var places = searchBox.getPlaces();

        if (places.length == 0) {
          return;
        }

        // Clear out the old markers.
        markers.forEach(function(marker) {
          marker.setMap(null);
        });
        markers = [];

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds();
        places.forEach(function(place) {
          if (!place.geometry) {
            console.log("Returned place contains no geometry");
            return;
          }
          var icon = {
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(25, 25)
          };

          // Create a marker for each place.
          markers.push(new google.maps.Marker({
            map: map,
            icon: icon,
            title: place.name,
            position: place.geometry.location
          }));

          if (place.geometry.viewport) {
            // Only geocodes have viewport.
            bounds.union(place.geometry.viewport);
          } else {
            bounds.extend(place.geometry.location);
          }
        });
        map.fitBounds(bounds);
      });
      
      var placesArray = [];
      var service = new google.maps.places.PlacesService(map);
      var searchLocation = new google.maps.LatLng(this.currentPlace.lat, this.currentPlace.lng)
      var request = {
        location: searchLocation,
        radius: '5000',
        query: 'Starbucks'
      };

      service.textSearch(request, callback);

      function callback(results, status) {
        for (var i = 0; i < results.length; i++) {
          placesArray.push(results[i]);
        }
      }

      return placesArray;
    }).then(data => {
      this.places = data
      console.log("places", this.places)
    })
  },

  methods: {
    
  },
}
</script>
