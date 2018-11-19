<template>
  <form v-if="isForm" v-on:submit.prevent>
    <input type="text" name="first_name" v-bind:placeholder="contactInfo.first_name" v-model="contactInfo.first_name">
    <input type="text" name="last_name" v-bind:placeholder="contactInfo.last_name" v-model="contactInfo.last_name">
    <input type="text" name="email" v-bind:placeholder="contactInfo.email" v-model="contactInfo.email">
    <input type="text" name="phone_number" v-bind:placeholder="contactInfo.phone_number" v-model="contactInfo.phone_number">
    <input type="checkbox" name="emergency" v-model="contactInfo.emergency">
    <button type='submit' @click='updateContact'>Save</button>
  </form>
  <li v-else class="card">
    <div class="card-header">
      {{ fullName }}
    </div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">{{ contactInfo.phone_number }}</li>
      <li class="list-group-item">{{ contactInfo.email }}</li>
      <li class="list-group-item" v-if="contact.emergency">Set as Emergency Contact</li>
      <li class="list-group-item" v-else>Not an Emergency Contact</li>
    </ul>
     <br>
    <p v-if=" contact.emergency">Set as Emergency Contact</p>
    <p v-else>Not an Emergency Contact</p>
    <button class="btn btn-outline-primary" @click='setForm'>Update</button>
    <button class="btn btn-outline-danger" @click='deleteContact'>Remove</button></li>
</template>

<script>
var axios = require('axios')

export default {
  name: 'Contact',
  props: {
    contact: Object,
    triggerRerender: Function
  },
  data () {
    return {
      isForm: false,
      contactInfo: this.contact
    }
  },
  computed: {
    fullName: function () {
      return this.contactInfo.first_name + ' ' + this.contactInfo.last_name
    }
  },
  methods: {
    setForm: function () {
      this.isForm = !this.isForm
    },
    setState: function () {
      this.contactInfo = this.contact
    },
    updateContact: function () {
      var url = this.buildUrl()
      axios.put(url, { contact: this.contactInfo })
        .then((response) => console.log(response))
        .catch((error) => console.log(error))
        .then(() => this.setForm())
    },
    deleteContact: function () {
      var url = this.buildUrl()
      axios.delete(url)
        .then((response) => console.log(response))
        .catch((error) => console.log(error))
        .then(() => this.triggerRerender())
    },
    buildUrl: function () {
      return 'http://localhost:3000/api/v2/users/' + this.contactInfo.user_id + '/contacts/' + this.contactInfo.id
    }
  }
}

</script>
