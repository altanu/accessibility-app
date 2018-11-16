<template>
  <div id="app">
    <Navbar v-bind:onClick='setState'></Navbar>
    <div>
    <div class='container d-flex'>
      <Map></Map>
      <transition name='fade'>
        <component v-bind:is='state.right'></component>
      </transition>
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

if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(function(position) {
    var pos = {
      lat: position.coords.latitude,
      lng: position.coords.longitude
    };

    console.log('found html5 location', pos)
  }, function() {
    console.log('there was an error');
  });
}

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
      state: store.state
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
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
