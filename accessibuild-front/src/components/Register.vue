<template>

  <div class="w-75 p-5">
  <h1>Register for a new account</h1>

  <form v-on:submit.prevent>
    <div class="form-group">
      <input type="text" name="first_name" placeholder="First Name" class="form-control" v-model="form.first_name">
    </div>
    <div class="form-group">
      <input type="text" name="last_name" placeholder="Last Name" class="form-control" v-model="form.last_name">
    </div>
    <div class="form-group">
      <input type="text" name="email" placeholder="Email" class="form-control" v-model="form.email">
    </div>
    <div class="form-group">
      <input type="text" name="phone_number" placeholder="Phone Number" class="form-control" v-model="form.phone_number">
    </div>
    <div class="form-group">
      <input type="password" name="password" placeholder="Password" class="form-control" v-model="form.password">
    </div>
    <div class="form-group">
      <input type="password" name="password_confirmation" placeholder="Confirm Password" class="form-control" v-model="form.password_confirmation">
    </div>
    <button type="submit" class="btn btn-success btn-block" @click="postUser">Register</button>
  </form>
</div>
</template>

<script>
var axios = require('axios')
export default {
  name: 'Register',
  data () {
    return {
      form: {
        first_name: '',
        last_name: '',
        email: '',
        phone_number: '',
        password: '',
        password_confirmation: ''
      }
    }
  },
  template: {
  },
  methods: {
    postUser: function () {
      axios({
      method: 'post',
      url: 'http://localhost:3000/api/v2/users',
      data: {user: this.form }
      })
      .then(function (response) {
          // Handle success
          console.log(response);
      })
      .catch(function (response) {
          // Handle error
          console.log(response);
      })
    }
  }
}

</script>
