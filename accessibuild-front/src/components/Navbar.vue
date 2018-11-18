<template>
  <nav class='navbar fixed-top navbar-light bg-light'>
    <div style="display:flex; width: 100%; flex-direction: row; justify-content: space-between">
      <div style="flex-grow: 2"> 
        <button @click='onClick("RightHome")' class='btn btn-outline-primary'>Home</button>
      </div>
      <div style="flex-grow: 6">
        <input id="pac-input" class="form-control" type="text" placeholder="🔍 Search keywords or addresses">
      </div>
      <div style="flex-grow: 2; display:flex; justify-content: flex-end">
        <button @click='onClick("Register")' class='btn btn-outline-primary' ref='register' type='submit'>Register</button>

        <button @click='onClick("Login")' class='btn btn-outline-primary' ref='login' type='submit'>Login</button>

        <button @click='onClick("Profile")' class='btn btn-outline-primary' ref='profile' type='submit'>Profile</button>

        <button @click='signOut' class='btn btn-outline-primary' type='submit'>Log Out</button>
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
    setPlace (place) {
      this.currentPlace = place
    },
    setQuery () {
      if (this.currentPlace) {
        console.log("what the search bar is sending",this.currentPlace)
        const marker = {
          lat: this.currentPlace.geometry.location.lat(),
          lng: this.currentPlace.geometry.location.lng()
        }
        this.currentPlace = marker
        this.$emit('place_update', this.currentPlace)
      }
    },
    signOut () {
      this.$http.secured.delete('/sessions')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    },
  },

}
</script>
