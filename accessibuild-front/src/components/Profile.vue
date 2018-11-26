<template>
  <div id="profile">
    <button id="pointer" class="btn btn-outline-primary btn-block" @click="backToList">Back to Search Results</button>
    <h3>Profile</h3>
    <h5 class="subtitle">Hello, {{user.first_name}}!</h5>
    <div class="d-flex">
      <div class="card" style="flex-grow: 1;">
        <div class="card-body">
          {{user.email}}
        </div>
      </div>
      <div class="card" style="flex-grow: 1;">
        <div class="card-body">
          {{user.phone_number}}
        </div>
      </div>
    </div>

    <div id="contacts-block" style="margin-top: 20px;" v-if="hasContacts">
      <hr>
      <h4 style="width: 100%; text-align: center;">Contacts</h4>
      <div id="accordion" v-for="contact in contacts" v-bind:key="contact.id">
        <Contact :contact='contact' :trigger-rerender="refreshContacts"></Contact>
      </div>
    </div>
    <h4 v-else>Loading...</h4>
    <button class='btn btn-success btn-block' v-if="!makingNewContact" @click="toggleForm">Create New Contact</button>
    <transition name="fade">
      <form class="form-group jumbotron new-contact" v-if="makingNewContact" v-on:submit.prevent>
        <h4>Create a New Contact</h4>
        <input class="form-control" type="text" name="first_name" placeholder="First Name" v-model="newContact.first_name">
        <input class="form-control" type="text" name="last_name" placeholder="Last Name" v-model="newContact.last_name">
        <input class="form-control" type="text" name="email" placeholder="Email" v-model="newContact.email">
        <input class="form-control" type="tel" name="phone_number" placeholder="Phone Number" v-model="newContact.phone_number">
        <div class="form-check form-check-inline">
          <label class="form-check-label" style="padding: 1em">Set As Emergency Contact
          <input class="form-check-input" type="checkbox" name="emergency" v-model="newContact.emergency">
          </label>
        </div><br>
        <div class="d-flex btn-group" role="group">
          <button style="flex-grow: 1;" class="btn btn-success" type='submit' @click="pushNewContact">Save</button>
          <button style="flex-grow: 1;" class="btn btn-warning" type='submit' @click="toggleForm">Cancel</button>
        </div>
      </form>
    </transition>
    <div v-if="trips[0]" class="container-fluid w-100" style="margin-top: 20px">
      <hr>
      <h4 style="width: 100%; text-align: center;">Trips</h4>
      
      <div class="d-flex flex-column" v-for="trip in trips" v-bind:key="trip.id" @click="renderTrip(trip)">
        <div class="trip card">
          <div class="card-title">
            Destination: {{trip.address}}
          </div>
          <div class="card-body">
            Trip time: {{trip.trip_time_moment}}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
import Contact from './_Contact.vue'
var axios = require('axios')

export default {
  name: 'Profile',
  props: {
    userId: Number
  },
  data () {
    return {
      msg: 'Component loaded!',
      user: {},
      contacts: {},
      userID: 1,
      makingNewContact: false,
      newContact: {
        user_id: this.userId,
        first_name: '',
        last_name: '',
        email: '',
        phone_number: '',
        emergency: false
      },
      trips: []
    }
  },
  mounted: function () {
    this.fetchUserData()
    this.fetchTrips()
  },
  methods: {
    fetchUserData: function () {
      axios.get('http://localhost:3000/api/v2/users/' + this.userID)
        .then(response => (this.user = response.data))
        .catch(error => console.log(error))
        .then(() => axios.get('http://localhost:3000/api/v2/users/' + this.userID + '/contacts')
          .then(response => (this.contacts = response.data))
          .catch(error => console.log(error)))
    },
    fetchTrips: function () {
      axios.get(`http://localhost:3000/api/v2/users/${store.state.currentUserId}/trips`)
        .then(response => {
          this.trips = response.data
          this.trips.forEach(trip => {
            trip.trip_time_moment = moment(trip.trip_time).format('MMMM Do YYYY, h:mm:ss a')
          })
        })
    },
    refreshContacts: function () {
      this.contacts = {}
      this.fetchUserData()
    },
    toggleForm: function () {
      this.makingNewContact = !this.makingNewContact
    },
    renderTrip: function(trip) {
      store.state.currentTrip.trip_id = trip.id
      store.state.currentTrip.address = trip.address
      store.state.currentTrip.trip_time = trip.trip_time
      store.setRightPane('Trip')
    },
    pushNewContact: function () {
      var url = this.buildUrl()
      axios.post(url, { contact: this.newContact })
        .then((response) => console.log(response))
        .catch((error) => console.log(error))
        .then(() => {
          this.toggleForm()
          this.emptyFields()
          this.reRender()
        })
    },
    buildUrl: function () {
      return 'http://localhost:3000/api/v2/users/' + this.newContact.user_id + '/contacts'
    },
    emptyFields: function () {
      this.newContact.first_name = ''
      this.newContact.last_name = ''
      this.newContact.email = ''
      this.newContact.phone_number = ''
      this.newContact.emergency = false
    },
    reRender: function () {
      this.contacts = {}
      this.fetchUserData()
    },
    backToList () {
      this.$parent.setState('RightHome')
    }
  },
  components: {
    Contact
  },
  computed: {
    hasContacts: function () {
      return Object.keys(this.contacts).length !== 0
    }
  }
}

</script>

<style scoped>
  .card {
    margin: 0;
  }
  .card-title {
    padding-left: 20px;
    padding-top: 10px;
  }
  .trip {
    margin-bottom: 10px;
    border-color: grey;
    box-shadow: 5px 5px 3px grey;
    transition: all 0.05s ease-in-out;
  }
  .trip:hover {
    transform: scale(1.05);
  }
  .new-contact {
    transition: all .2s ease;
  }
  .fade-enter-active {
    transition: opacity .5s;
  }
  .fade-leave-active {
    transition: 0s;
  }
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }
</style>
