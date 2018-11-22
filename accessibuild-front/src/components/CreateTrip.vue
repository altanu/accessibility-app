<template>
  <div class='w-100' style='height: 100%; overflow: scroll;'>
    <h1>Create your trip here!</h1>
    <h2>Here are all your contacts:</h2>
    <ul>
      <li v-for="contact in contacts" v-bind:key="contact.id">
        <p>Name: {{contact.first_name}}</p>
        <p>Email: {{contact.email}}</p>
        <p>Emergency contact? {{contact.emergency}}</p>
      </li>
    </ul>
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
      contacts: [],
      companions: []
    }
  },
  methods: {
    fetchContacts () {
      axios.get(this.baseUrl + 'users/1/contacts')
        .then(response => (this.contacts = response.data))
    },
    addContactToTrip () {
      this.companions.push()
    },
    removeContactFromTrip () {

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
