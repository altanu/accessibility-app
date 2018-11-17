<template>
  <div id="app" style="height: 100%">
    <Navbar v-bind:onClick='setState' v-on:place_update='updateLocation'></Navbar>
    <div style="height: 100%">
    <div style="height: 100%">
      <div class='d-flex align-self-center' style="padding-top: 3.4em; height: 100%">
        <div style="min-width:60%; height: 100%;">
          <Map v-bind:current-place="this.currentLocation"></Map>
        </div>
        <div style="min-width:40%; padding-top: 2em; height: 100%; overflow: scroll;">
          <transition name='fade'>
            <component v-bind:is='state.right' v-bind:current-place="this.currentLocation" v-bind:onClick='setState' :user-id="this.userId"></component>
          </transition>
        </div>
      </div>
    </div>
  </div>
    <router-view/>
    <!-- <Footer></Footer> -->
  </div>
</template>

<script>
import SubmitReview from './components/SubmitReview.vue'
import Navbar from './components/Navbar.vue'
// import Footer from './components/Footer.vue'
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
  data: () => {
    return {
      state: store.state,
      // default to montreal
      currentLocation: { lat: 45.508, lng: -73.587 },
      userId: 1
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    updateLocation (place) {
      this.currentLocation = place
    },
    sendMessage (message) {
      this.messageForChildren = message
    }
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
    SubmitReview,
  }
}
</script>

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
