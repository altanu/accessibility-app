<template>
  <div id="app" style="height: 100%">
    <Navbar v-bind:onClick='setState' v-on:place_update='updateLocation'></Navbar>
    <div style="height: 100%">
    <div style="height: 100%">
      <div class='d-flex align-self-center' style="padding-top: 3.4em; height: 100%">
        <div style="min-width:60%; height: 100%;">
          <Map v-bind:current-place="this.currentLocation"></Map>
        </div>
        <div style="min-width:40%; padding-top: 2em; height: 100%">
          <transition name='fade'>
            <component v-bind:is='state.right' v-bind:current-place="this.currentLocation"></component>
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
import Navbar from './components/Navbar'
// import Footer from './components/Footer.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Map from './components/Map.vue'
import Login from './components/Login.vue'
import Contacts from './components/Contacts.vue'

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
      currentLocation: { lat: 45.508, lng: -73.587 }
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    updateLocation (place) {
      this.currentLocation = place
    }
  },
  components: {
    // Footer,
    Navbar,
    RightHome,
    Register,
    Login,
    Map,
    Contacts
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
