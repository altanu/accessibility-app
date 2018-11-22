<template>
  <div class='w-100' style='height: 100%; overflow: scroll;'>
    <h1>Create your trip here!</h1>
    <button class='btn' @click=''>Create Trip</button>


  </div>

</template>
<script type="text/javascript">
var axios = require('axios')

export default {
  name: 'CreateTrip',
  data () {
    return {
      baseUrl: 'http://localhost:3000/api/v2/',
      contacts: []

    }
  },
  methods: {
    fetchContacts () {
      axios.get(baseUrl + 'users/1/contacts')
        .then(response => console.log(response.data))
    },
    createTrip () {

    }
  },
  created () {
    this.fetchContacts()
  }
};

</script>


// click create trip
// -> make db call: post trip (give access url)
// -> afterwards: loop through contacts
// -> create companion for each
