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
    <button type="submit" class="btn btn-success btn-block" @click="signup">Register</button>
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
        password_confirmation: '',
        error: ''
      }
    }
  },
  template: {
  },
  methods: {
    signup () {
      this.$http.plain.post('/api/v2/users', { user: this.form })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      // this.$router.replace('/home')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        // this.$router.replace('/home')
      }
    }
  }
}

</script>
