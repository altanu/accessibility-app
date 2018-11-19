<template>
  <section class="card">
    <div class="card-header">{{name}}</div>
    <div class="card-header">Address: {{formatted_address}}</div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">Wheelchair: {{ wheelchair }}</li>
      <li class="list-group-item">bathroom: {{ bathroom }}</li>
      <li class="list-group-item">Parking: {{ parking }}</li>
    </ul>
    <button v-if="not_exists" class="btn">Review this location</button>
  </section>
</template>

<script>
var axios = require('axios')

export default {
  name: 'Location',
  props: {
    place: Object
  },
  data () {
    return {
      name: this.place.name,
      formatted_address: this.place.formatted_address,
      house_number: this.place.house_number,
      street: this.place.street,
      wheelchair: 'No information',
      bathroom: 'No information',
      parking: 'No information',
      not_exists: true
    }
  },
  methods: {
    fetchLocationInfo () {
      axios.get('http://localhost:3000/api/v2/places/' + this.place.place_id)
        .then(response => {
          const location = response.data[0]
          this.house_number = location.house_number
          this.street = location.street
          this.wheelchair = location.wheelchair
          this.bathroom = location.bathroom
          this.parking = location.parking
          if (location.id) this.not_exists = false
        })
    }
  },
  created () {
    this.fetchLocationInfo()
  }
}

</script>
