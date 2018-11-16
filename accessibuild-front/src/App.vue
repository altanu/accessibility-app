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
            <component v-bind:is='state.right'></component>
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
import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    right: 'RightHome',
    mapCenter : { lat: 45.508, lng: -73.587 },
  },
  mutations: {
    updateMap (state, newLoc) {
      console.log("Original state mapcenter", state.mapCenter)
      console.log("received new location", newLoc)
      state.mapCenter = newLoc
    }
  }
})

export default {
  name: 'App',
  props: {
    msg: String
  },
  data: () => {
    return {
      state: store.state,
      currentLocation: store.state.mapCenter
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    updateLocation (place) {
      console.log("PLACE", place)
      store.commit('updateMap', place)
      console.log("CURRENTLOCATION", this.currentLocation)
    }
  },
  components: {
    Footer,
    Navbar,
    RightHome,
    Register,
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
