<template>
  <section>
    <Location
      v-for="location in locations"
      v-bind:placeID="location"
      v-bind:key="location"
    ></Location>
  </section>
</template>

<script>
import Location from './_Location.vue'
var axios = require('axios')
export default {
  name: 'Locations',
  data () {
    return {
      locations: ['ChIJJ9FRSXoPyUwRaJxKHz_K-qo', 'ChIJxQR86EMayUwR6_heLyPEzUM', 'ChIJJ_qBVksayUwRycDOKZnpDNc'],
      msg: String
    }
  },
  mounted: function () {
    axios.get('http://localhost:3000/api/v2/locations.json')
      .then(response => (this.msg = response.data))
      .catch(error => console.log(error))
  },
  components: {
    Location
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
