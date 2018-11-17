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
    <div v-if='contacts.length !== 0'>
      <p>Found some contacts!</p>
    </div>
  </div>
</template>

<script>
var axios = require('axios')

export default {
  name: 'Profile',
  props: {
    userId: Number,
  },
  data () {
    return {
      msg: 'Component loaded!',
      user: {},
      contacts: {}
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
    }
  }
}

</script>
