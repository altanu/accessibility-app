<template>
  <section class="card">
    <div class="card-header">Location: {{houseNumber}}, {{street}}</div>
      <ul class="list-group list-group-flush">
        <li class="list-group-item">Wheelchair: {{ wheelchair }}</li>
        <li class="list-group-item">bathroom: {{ bathroom }}</li>
        <li class="list-group-item">Parking: {{ parking }}</li>
      </ul>
  </section>
</template>

<script>
var axios = require('axios')

export default {
  name: 'Location',
  props: {
    placeID: String
  },
  data () {
    return {
      houseNumber: '',
      street: '',
      wheelchair: '',
      bathroom: '',
      parking: ''
    }
  },

  methods: {
    fetchLocationInfo () {
      axios.get('http://localhost:3000/api/v2/places/' + placeID)
        .then(response => {
          const location = response.data[0]
          this.house_number = location.house_number
          this.street = location.street
          this.wheelchair = location.wheelchair
          this.bathroom = location.bathroom
          this.parking = location.parking
        })
    }
  }
}

</script>
