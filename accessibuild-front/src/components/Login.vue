<template>

  <div id= "login" style="margin: auto;">
  <h1>Login</h1>

  <form v-on:submit.prevent='setLogin'>
    <div class="form-group">
      <input type="text" name="email" placeholder="Email" class="form-control" v-model="email">
    </div>
    <div class="form-group">
      <input type="password" name="password" placeholder="Password" class="form-control" v-model="password">
    </div>
    <button type="submit" class="btn btn-success btn-block" @click="signin">Login</button>
  </form>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'Login',
  props: ['setLogin'],
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
      axios.post('http://localhost:3000/login', {
        user: {
          email: this.email,
          password: this.password
        }
      }).then(response => {
        console.log(response)
        if (response.status === 200) {
          store.state.loggedIn = true
          store.state.token = response.data.token
          store.setRightPane('Profile')
        } else {
          alert('Not Authorized')
        }
        console.log(response.data)
      })
    },
    signinSuccessful (response) {
    },
    signinFailed (error) {
      console.log(error)
    },
    checkSignedIn () {
    }
  }
}

</script>
