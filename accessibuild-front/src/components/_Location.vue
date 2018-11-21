<template>
  <section v-bind:id="this.place.place_id" class="card">
    <div class="card-header">Address: {{location.formatted_address}}</div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">Wheelchair: {{ location.wheelchair }}</li>
      <li class="list-group-item">bathroom: {{ location.bathroom }}</li>
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
      const saveLocation = {
        place_id: this.place.place_id,
        wheelchair: this.wheelchair,
        bathroom: this.bathroom,
        parking: this.parking
      }
      if (!this.location.id) {
        axios.post('http://localhost:3000/api/v2/locations', saveLocation)
          .then(response => {
            store.setCurrentLocation(location)
            store.setCurrentLocationId(response.data.id)
            this.onClick('SubmitReview')
          })
      } else {
        console.log('location: ', location)
        store.setCurrentLocation(location)
      }
    }
  },
  created () {
    this.fetchLocationInfo()
    console.log('this.location:', this.location)
  }
}

</script>
