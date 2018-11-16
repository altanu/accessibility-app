<template>

  <div class="w-75 p-5">
  <h1>Login</h1>

  <form v-on:submit.prevent='signin'>
    <div class="form-group">
      <input type="text" name="email" placeholder="Email" class="form-control" v-model="email">
    </div>
    <div class="form-group">
      <input type="password" name="password" placeholder="Password" class="form-control" v-model="password">
    </div>
    <button type="submit" class="btn btn-success btn-block">Login</button>
  </form>
</div>
</template>

<script>
var axios = require('axios')
export default {
  name: 'Login',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      axios({
        method: 'post',
        url: 'http://localhost:3000/sessions',
        data: {
          email: this.email,
          password: this.password
        }
      }).then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {

      }
    }
  }
}

</script>
