<template>
  <nav class='navbar fixed-top navbar-expand-lg navbar-light bg-light'>
      <form class='form-inline' v-on:submit.prevent>
        <button @click='onClick("RightHome")' class='btn btn-outline-primary'>Home</button>

        <form class='form-inline' v-on:submit.prevent>
          <gmap-autocomplete class='form-control' @place_changed="setPlace"></gmap-autocomplete>
          <button class='btn btn-outline-success' @click="addMarker">🔍 Search</button>
        </form>

        <button @click='onClick("Register")' class='btn btn-outline-primary' ref='register' type='submit'>Register</button>
        <button @click='onClick("Login")' class='btn btn-outline-primary' ref='login' type='submit'>Login</button>
        <button @click='onClick("Contacts")' class='btn btn-outline-primary' type='submit'>Contacts</button>

      </form>
  </nav>
</template>

<script>
export default {
  props: {
    onClick: Function
  },
  data () {
    return { currentPlace: null }
  },
  methods: {
    setPlace (place) {
      this.currentPlace = place
    },
    addMarker () {
      if (this.currentPlace) {
        const marker = {
          lat: this.currentPlace.geometry.location.lat(),
          lng: this.currentPlace.geometry.location.lng()
        }
        this.currentPlace = marker
        this.$emit('place_update', this.currentPlace)
      }
    }
  }
}
</script>
