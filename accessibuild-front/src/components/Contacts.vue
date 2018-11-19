<template>
  <div class="w-75 p-5">
    <h1>Contacts</h1>
    <ul>
      <li class='card' v-for="contact in contacts" v-bind:key="contact.id">
      {{ contact }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Contacts',
  data () {
    return {
      contacts: []
    }
  },
  created () {
    if (!localStorage.signedIn) {
      // this.$router.replace('/home')
    } else {
      this.$http.secured.get('/api/v2/users/1/contacts')
        .then(response => { this.contacts = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}

</script>
