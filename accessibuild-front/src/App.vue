<template>
  <div id="app">
    <Navbar v-bind:onClick='setState' v-on:place_update='updateLocation'></Navbar>
    <div>
    <div>
      <div class='d-flex'>
        <div style="min-width:60%">
          <Map v-bind:current-place="this.currentLocation"></Map>
        </div>
        <div style="min-width:40%">
          <transition name='fade'>
            <component v-bind:is='state.right' v-bind:current-place="this.currentLocation"></component>
          </transition>
        </div>
      </div>
    </div>
  </div>
    <router-view/>
    <Footer></Footer>
  </div>
</template>

<script>
import Navbar from './components/Navbar'
import Footer from './components/Footer.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Map from './components/Map.vue'
import Login from './components/Login.vue'

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
      currentLocation: {}
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    updateLocation (place) {
      this.currentLocation = place
      console.log('updated location', this.currentLocation)
    }
  },
  components: {
    Footer,
    Navbar,
    RightHome,
    Register,
    Login,
    Map
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
