<template>
  <div id="app" style="height: 100%">
    <Navbar v-bind:onClick='setState'></Navbar>
    <div style="height: 100%">
    <div style="height: 100%">
      <div class='d-flex align-self-center' style="padding-top: 3.4em; height: 100%">
        <div style="min-width:60%; height: 100%;">
          <Map v-bind:current-place="this.currentLocation" v-bind:places-list="this.placesList"></Map>
        </div>
        <div style="min-width:40%; padding-top: 2em; height: 100%; overflow: scroll;">
          <transition name='fade'>
            <component v-bind:is='state.right' v-bind:current-place="this.currentLocation" v-bind:places-list="this.placesList" v-bind:onClick='setState' :user-id="this.userId"></component>
          </transition>
        </div>
      </div>
    </div>
  </div>
    <router-view/>
  </div>
</template>

<script>
import SubmitReview from './components/SubmitReview.vue'
import Navbar from './components/Navbar.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Map from './components/Map.vue'
import Login from './components/Login.vue'
import Contacts from './components/Contacts.vue'
import Profile from './components/Profile.vue'

const store = {
  state: {
    right: 'RightHome'
  }
}

export default {
  name: 'App',
  props: {
    msg: String
  },
  mounted () {
    this.geolocate()
  },
  data: () => {
    return {
      state: store.state,
      // default to montreal
      currentLocation: { lat: 45.508, lng: -73.587 },
      userId: 1,
      placesList: []
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    updateLocation (place) {
      this.currentLocation = place
    },
    geolocate: function () {
      navigator.geolocation.getCurrentPosition(position => {
        this.updateLocation({
          lat: position.coords.latitude,
          lng: position.coords.longitude
        })
      })
    },
  },
  components: {
    // Footer,
    Navbar,
    RightHome,
    Register,
    Login,
    Map,
    Contacts,
    Profile,
    SubmitReview
  }
}
</script>

<style lang="scss">
  @import './assets/scss/main.scss'
</style>

<style scoped>
.fade-enter-active {
  transition: opacity 1.5s;
}
.fade-leave-active {
  opacity: 0;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
