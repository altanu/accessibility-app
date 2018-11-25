<template>
  <div class='w-100 p-3' style=' text-align: center; height: 100%; overflow: scroll;'>
    <h4>Creating your trip to {{location.formatted_address}}</h4>
    <h5 style="text-align: center;">Choose contacts to keep informed of your trip!</h5>
    <section id="user-contacts" class="container">
      <div style v-for="contact in contacts" v-bind:key="contact.id">
        <TripContact :contact="contact"
                     :add-contact-to-trip="addContactToTrip"
                     :remove-contact-from-trip="removeContactFromTrip"
                     class="row">
        </TripContact>
      </div>
    </section>
    <div>
      <h5>What time do you plan on arriving?</h5>
      <input v-model='trip_time' type='datetime-local'></input>
      <button class='btn round-button' @click='createTrip'>Create Trip</button>
    </div>
  </div>
</template>
<script>
import router from '../router.js'
import TripContact from './_TripContact.vue'
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

        store.state.currentTrip.address = this.location.formatted_address
        store.state.currentTrip.trip_time = this.trip_time
        store.state.currentTrip.trip_id = tripId

        Promise.all(this.companions.map(companion => {
          return axios.post(`${this.baseUrl}companions`, {
            trip_id: tripId,
            contact_id: companion.id
          }).then(response => {
            console.log(response.data)
            console.log('one promise resolved')
          })
        })).then(() => {
          console.log('promises resolved')
          router.push('/')
          store.setRightPane('Trip')
          axios.put(`${this.baseUrl}trips/${tripId}/created_mail`)

        })
      })
    }
  },
  created () {
    this.fetchContacts()
  },
  components: {
    TripContact
  }
};

</script>


// click create trip
// -> make db call: post trip (give access url)
// -> afterwards: loop through contacts
// -> create companion for each
