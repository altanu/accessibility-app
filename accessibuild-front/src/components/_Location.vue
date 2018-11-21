<template>
  <section v-bind:id="this.place.place_id" class="card" style="border: 1px solid grey">
    <div class="card-header">Address: {{location.formatted_address}}</div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">Wheelchair Access: {{ location.wheelchair }}</li>
      <li class="list-group-item">Accessible Bathrooms: {{ location.bathroom }}</li>
      <li class="list-group-item">Parking: {{ location.parking }}</li>
    </ul>
    <button class="btn" @click="renderLocation(location)">Review this location</button>
  </section>
</template>

<script>
var axios = require('axios')

export default {
  name: 'Location',
  props: {
    place: Object,
    onClick: Function
  },
  data () {
    return {
      location: {
        formatted_address: this.place.formatted_address,
        wheelchair: 0,
        bathroom: false,
        parking: false,
        id: null
      }
    }
  },
  methods: {
    fetchLocationInfo () {
      axios.get('http://localhost:3000/api/v2/places/' + this.place.place_id)
        .then(response => {
          const location = response.data[0]
          if (location) {
            this.location.wheelchair = location.wheelchair
            this.location.bathroom = location.bathroom
            this.location.parking = location.parking
            this.location.id = location.id
          }
        })
    },
    renderLocation (location) {
      var self = this

      var geocoder = new google.maps.Geocoder()
      geocoder.geocode({ 'placeId': this.place.place_id, 'language': 'en' }, function (results, status) {
        console.log('did we get something from the geocoder', results)
        var lat = results[0].geometry.location.lat()
        var lng = results[0].geometry.location.lng()

        console.log("do we have coordinates", lat, lng)
        const saveLocation = {
          place_id: self.place.place_id,
          wheelchair: self.wheelchair,
          bathroom: self.bathroom,
          parking: self.parking,
          lat: lat,
          lng: lng
        }
        if (!self.location.id) {
          axios.post('http://localhost:3000/api/v2/locations', saveLocation)
            .then(response => {
              store.setCurrentLocation(location)
              store.setCurrentLocationId(response.data.id)
              self.onClick('SubmitReview')
            })
        } else {
          store.setCurrentLocation(location)
        }
      })
    }
  },
  computed: {
    wheelchairParsed () {

    },
    bathroomParsed () {

    },
    parkingParsed () {
      
    }

  }
  created () {
    this.fetchLocationInfo()
  }
}

</script>
