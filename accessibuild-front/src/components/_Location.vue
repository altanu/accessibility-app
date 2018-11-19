<template>
  <section class="card">

  </section>
</template>

<script>
var axios = require('axios')

export default {
  name: 'Location',
  props: {
    placeID
  },
  data () {
    return {
      isForm: false,
      contactInfo: this.contact
    }
  },

  methods: {
    fetchLocationInfo () {
      axios.get('http://localhost:3000/api/v2/places/ChIJJ9FRSXoPyUwRaJxKHz_K-qo')
        .then(response => console.log(response.data))
    }
  }
}

</script>
