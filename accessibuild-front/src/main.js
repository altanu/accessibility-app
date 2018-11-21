import Vue from 'vue'
import App from './App.vue'
import VueMq from 'vue-mq'
import router from './router'
import axios from 'axios'

// import 'bootstrap/dist/js/bootstrap'
import 'bootstrap'

// import plugins individually - require exports-loader
import 'bootstrap/js/dist/modal'
import 'bootstrap/js/dist/tooltip'

// import 'bootstrap/dist/css/bootstrap.min.css'
// import 'bootstrap/scss/bootstrap.scss'

import * as VueGoogleMaps from 'vue2-google-maps'

// let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
// axios.defaults.headers.common['Authorization']
axios.defaults.headers.common['Accept'] = 'application/json'

// jquery
global.$ = $

Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyDhckeqRinlpHeTfo3T-ethx8hJyTG62UY',
    libraries: 'places'
  },
  installComponents: true
})

// Breakpoints for reactive design: these are available to all components with $mq
Vue.use(VueMq, {
  breakpoints: {
    sm: 450,
    md: 1250,
    lg: Infinity
  }
})

Vue.config.productionTip = false
var self = this

global.store = {
  state: {
    currentLocation: {},
    right: 'RightHome'
  },
  setCurrentLocation (newLocation) {
    this.state.currentLocation = newLocation
    this.setRightPane('SubmitReview')
  },
  clearCurrentLocation () {
    this.state.currentLocation = {}
  },
  setRightPane (name) {
    this.state.right = name
  },
  setCurrentLocationId (id) {
    this.state.currentLocation.id = id
  }
}

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
