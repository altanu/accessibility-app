<template>
  <div id="app">
    <Navbar v-bind:onClick='setState'></Navbar>
    <div>
    <h1>Big Container</h1>
    <div class='container d-flex'>
      <div class='container flex-fill' id='map'>This is the map component</div>
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
// import Container from './components/Container.vue'
import Footer from './components/Footer.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'

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
