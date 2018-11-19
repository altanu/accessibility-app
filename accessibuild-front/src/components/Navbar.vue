<template>
  <nav class='navbar fixed-top navbar-light bg-light'>
    <div style="display:flex; width: 100%; flex-direction: row; justify-content: space-between">
      <div style="flex-grow: 1">
        <button style="width: 7.5rem" @click='onClick("RightHome")' class='btn btn-outline-primary'>Home</button>
        <button style="width: 7.5rem" @click='onClick("Profile")' class='btn btn-outline-primary' ref='profile' type='submit'>Profile</button>
      </div>
      <div style="flex-grow: 2">
        <input id="pac-input" class="form-control" type="text" placeholder="🔍 Search keywords or addresses">
      </div>
      <div style="flex-grow: 1; display:flex; justify-content: flex-end">
        <button style="width: 5rem" @click='onClick("Register")' class='btn btn-outline-primary' ref='register' type='submit'>Register</button>

        <button style="width: 5rem" @click='onClick("Login")' class='btn btn-outline-primary' ref='login' type='submit'>Login</button>

        <button style="width: 5rem" @click='signOut' class='btn btn-outline-primary' type='submit'>Log Out</button>
       <button style="width: 5rem" @click='signOut' class='btn btn-outline-primary' type='submit'>Log Out</button>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  props: {
    onClick: Function
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
