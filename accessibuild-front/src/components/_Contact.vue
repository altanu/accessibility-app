<template>
  <div class="contact-holder">
  <li v-if="isForm" class="card">
  <form class="form-group" v-on:submit.prevent>
    <ul class="list-group list-group-flush">
      <li class="list-group-item">
        <label>First Name</label>
        <input class="form-control" type="text" name="first_name" v-bind:placeholder="contactInfo.first_name" v-model="contactInfo.first_name">
      </li>
      <li class="list-group-item">
        <label>Last Name</label>
        <input class="form-control" type="text" name="last_name" v-bind:placeholder="contactInfo.last_name" v-model="contactInfo.last_name">
      </li>
      <li class="list-group-item">
        <label>Email Address</label>
        <input class="form-control" type="text" name="email" v-bind:placeholder="contactInfo.email" v-model="contactInfo.email">
      </li>
      <li class="list-group-item">
        <label>Phone Number</label>
        <input class="form-control" type="tel" name="phone_number" v-bind:placeholder="contactInfo.phone_number" v-model="contactInfo.phone_number">
      </li>
      <li class="list-group-item form-check">
        <input type="checkbox" name="emergency" v-model="contactInfo.emergency">  Emergency Contact
      </li>
      <li class="list-group-item">
        <button class="btn btn-success btn-block" type='submit' @click='updateContact'>Save</button>
      </li>
    </ul>
  </form>
  </li>
  <div v-else id="accordion">
    <li class="card">
      <div class="card-header">
        <button class="btn btn-link" data-toggle="collapse" v-bind:data-target="'#contact-' + contactInfo.id" aria-expanded="true" aria-controls="collapseOne">
          {{ fullName }}
        </button>
      </div>
      <div v-bind:id="'contact-' + contactInfo.id" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
        <ul class="list-group list-group-flush">
          <li class="list-group-item">{{ contactInfo.phone_number }}</li>
          <li class="list-group-item">{{ contactInfo.email }}</li>
          <li class="list-group-item" v-if="contact.emergency">Set as Emergency Contact</li>
          <li class="list-group-item" v-else>Not an Emergency Contact</li>
        </ul>
        <button class="btn btn-outline-primary" @click='setForm'>Update</button>
        <button class="btn btn-outline-danger" @click='deleteContact'>Remove</button>
      </div>
    </li>
  </div>
  </div>
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
