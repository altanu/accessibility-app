<template>
  <section class="card">
    <div class="card-header">{{location.name}}</div>
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
        name: this.place.name,
        formatted_address: this.place.formatted_address,
        house_number: this.place.house_number,
        street: this.place.street,
        wheelchair: 'No information',
        bathroom: 'No information',
        parking: 'No information',
        not_exists: true,
        id: null
      }
    }
  },
  methods: {
    fetchLocationInfo () {
      axios.get('http://localhost:3000/api/v2/places/' + this.place.place_id)
        .then(response => {
          const location = response.data[0]
          this.location.house_number = location.house_number
          this.location.street = location.street
          this.location.wheelchair = location.wheelchair
          this.location.bathroom = location.bathroom
          this.location.parking = location.parking
          console.log(location)
          if (location.id) {
            this.location.not_exists = false
            this.location.id = location.id
          }
        })
    },
    renderLocation (location) {
      this.onClick('SubmitReview')
      store.setCurrentLocation(location)
    }
  },
  created () {
    this.fetchLocationInfo()
  }
}

</script>
