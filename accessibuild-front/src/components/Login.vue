<template>

  <div id= "login" style="margin: auto;">
  <h1>Login</h1>

  <form v-on:submit.prevent>
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
export default {
  name: 'Login',
  props: ['setLogin'],
  data () {
    return {
      email: 'mtrembaly@gmail.com',
      password: 'averycomplexpassword',
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
      store.state.loggedIn = true
      store.setRightPane('Profile')
      // this.$http.plain.post('/sessions', { email: this.email, password: this.password })
      //   .then(response => this.signinSuccessful(response))
      //   .catch(error => this.signinFailed(error))
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
