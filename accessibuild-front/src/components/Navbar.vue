<template>
  <nav class='navbar fixed-top navbar-light bg-light'>
    <div style="display:flex; flex-direction: column; width: 100%">
      <div style="display: flex; align-content: center; width: 100%">
      </div>

      <div style="display:flex; width: 100%; flex-direction: row; justify-content: space-between">
        <div style="flex-grow: 1;">
        <h3 style="width:100%; text-align: center">
          <button id="accessibuild" style="width: 7.5rem" @click='onClick("RightHome")'>Accessibuild</button>
        </h3>
        </div>
        <div style="flex-grow: 1" id="search-container">
          <input id="pac-input" class="form-control" type="text" placeholder="🔍 Search keywords or addresses">
        </div>
        <div style="flex-grow: 1; display:flex; justify-content: flex-end">
          <button v-show="!isLoggedIn" style="width: 7.5rem; padding: 2px;" @click='onClick("Register")' class='btn btn-outline-primary' ref='register' type='submit'>Register</button>
          <button v-show="isLoggedIn" style="width: 7.5rem" @click='onClick("Profile")' class='btn btn-outline-primary' ref='profile' type='submit'>Profile</button>
          <button v-show="!isLoggedIn" style="width: 7.5rem" @click='onClick("Login")' class='btn btn-outline-primary' ref='login' type='submit'>Login</button>

          <button v-show="isLoggedIn" style="width: 7.5rem" @click='signOut' class='btn btn-outline-primary' type='submit'>Log Out</button>
        </div>

      </div>
    </div>
  </nav>
</template>

<script>
export default {
  props: {
    onClick: Function,
    isLoggedIn: Boolean
  },
  data () {
    return {
      currentPlace: null
    }
  },
  methods: {
    signOut () {
      this.$http.secured.delete('/sessions')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
