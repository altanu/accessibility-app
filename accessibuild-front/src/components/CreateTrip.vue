<template>
  <div class='w-100 p-3' style='height: 100%; overflow: scroll;'>
    <h4>Create your trip to {{location.formatted_address}} here!</h4>
    <h5>Who would you like to meet you at the destination?</h5>
    <ul>
      <li v-for="contact in contacts" v-bind:key="contact.id">
        <p>Name: {{contact.first_name}} 
          <button @click="addContactToTrip(contact)" class="btn round-button">Add</button>
          <button @click="removeContactFromTrip(contact)" class="btn round-button">Remove</button>
        </p>
        <p>Email: {{contact.email}}</p>
        <p>Emergency contact? {{contact.emergency}}</p>
      </li>
    </ul>
    <div>
      <h5>What time do you plan on arriving?</h5>
      <input v-model='trip_time' type='datetime-local'></input>
      <button class='btn round-button' @click='createTrip'>Create Trip</button>
    </div>
  </div>
</template>
<script type="text/javascript">
var axios = require('axios')

export default {
  name: 'CreateTrip',
  data () {
    return {
      baseUrl: 'http://localhost:3000/api/v2/',
      userId: store.state.currentUserId,
      contacts: [],
      companions: [],
      trip_time: null,
      location: store.state.currentLocation
    }
  },
  methods: {
    fetchContacts () {
      axios.get(this.baseUrl + 'users/1/contacts')
        .then(response => (this.contacts = response.data))
    },
    addContactToTrip (contact) {
      if (this.companions.indexOf(contact) < 0) {
        this.companions.push(contact)
      }
    },
    removeContactFromTrip (contact) {
      this.companions = this.companions.filter(companion => {
        return companion.id !== contact.id
      })
    },
    createTrip () {
      axios.post(`${this.baseUrl}users/${this.userId}/trips`, {
        location_id: this.location.id,
        user_id: this.userId,
        trip_time: this.trip_time,
        address: this.location.formatted_address
      }).then(response => {
        const tripId = response.data.id
        this.companions.forEach(companion => {
          axios.post(`${this.baseUrl}companions`, {
            trip_id: tripId,
            contact_id: companion.id
          }).then(response => {
            console.log(response.data)
          })
        })
      })
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
