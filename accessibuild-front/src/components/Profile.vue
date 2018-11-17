<template>
  <div id="profile">
    <h3>Profile</h3>
    <p> {{ msg }} </p>
    <p> My parent says: {{ userId }}</p>

    <dl>
      <dt>First Name</dt>
      <dd>{{ user.first_name || 'No first name'}}</dd>
      <dt>Last Name</dt>
      <dd>{{ user.last_name || 'No last name'}}</dd>
      <dt>Email</dt>
      <dd>{{ user.email || 'No email'}}</dd>
    </dl>
    <div id="contacts-block" v-if="hasContacts">
      <h4>Contacts</h4>
      <div v-for="contact in contacts">
        <Contact :contact='contact' :trigger-rerender="refreshContacts"></Contact>
      </div>
    </div>
    <h4 v-else>No contacts here... Let's add some!</h4>
    <button v-if="!makingNewContact" @click="toggleForm">Create New Contact</button>
    <form v-else v-on:submit.prevent>
      <input type="text" name="first_name" placeholder="First Name" v-model="newContact.first_name">
      <input type="text" name="last_name" placeholder="Last Name" v-model="newContact.last_name">
      <input type="text" name="email" placeholder="Email" v-model="newContact.email">
      <input type="text" name="phone_number" placeholder="Phone Number" v-model="newContact.phone_number">
      <input type="checkbox" name="emergency" v-model="newContact.emergency">
      <button type='submit' @click="pushNewContact">Save</button>
  </form>
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
      makingNewContact: false,
      newContact: {
        user_id: this.userId,
        first_name: '',
        last_name: '',
        email: '',
        phone_number: '',
        emergency: false
      }
    }
  },
  mounted: function () {
    this.fetchUserData()
  },
  methods: {
    fetchUserData: function () {
      axios.get('http://localhost:3000/api/v2/users/' + this.userId)
        .then(response => (this.user = response.data))
        .catch(error => console.log(error))
        .then(() => axios.get('http://localhost:3000/api/v2/users/' + this.userId + '/contacts')
          .then(response => (this.contacts = response.data))
          .catch(error => console.log(error)))
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
