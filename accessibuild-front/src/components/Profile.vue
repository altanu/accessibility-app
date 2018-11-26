<template>
  <div id="profile">
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

    <div id="contacts-block" v-if="hasContacts">
      <h4 style="width: 100%; text-align: center;">Contacts</h4><hr>
      <div id="accordion" v-for="contact in contacts" v-bind:key="contact.id">
        <Contact :contact='contact' :trigger-rerender="refreshContacts"></Contact>
      </div>
    </div>
    <h4 v-else>Loading...</h4>
    <button class='btn btn-success btn-block' v-if="!makingNewContact" @click="toggleForm">Create New Contact</button>
    <form class="form-group jumbotron" v-else v-on:submit.prevent>
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
      <div class="d-flex flex-column btn-group" role="group">
        <button style="flex-grow: 1;" class="btn btn-success" type='submit' @click="pushNewContact">Save</button>
        <button style="flex-grow: 1;" class="btn btn-warning" type='submit' @click="toggleForm">Cancel</button>
      </div>
    </form>
    <div v-if="trips[0]" class="container-fluid w-100" style="margin-top: 20px">
      <h4 style="width: 100%; text-align: center;">Trips</h4><hr>
      
      <div class="d-flex" v-for="trip in trips" v-bind:key="trip.id">
        <div class="card">
          <div class="card-body">
            {{trip.address}}
          </div>
        </div>
        <div class="card">
          <div class="card-body">
            {{trip.trip_time}}
          </div>
        </div>
      </div>
      <table v-for="trip in trips" v-bind:key="trip.id">
        <tr>{{trip.address}}</tr>
        <tr>{{trip.trip_time}}</tr>
      </table>
    </div>
  </div>
</template>

<script>

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
        })
    },
    refreshContacts: function () {
      this.contacts = {}
      this.fetchUserData()
    },
    toggleForm: function () {
      this.makingNewContact = !this.makingNewContact
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
  table, tr {
    border: solid black 1px;
  }
  table {
    width: 100%;
    margin: 1rem;
  }
</style>
