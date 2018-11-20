import Vue from 'vue'
import App from './App.vue'
import VueMq from 'vue-mq'
import router from './router'

import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'

// import 'bootstrap/dist/js/bootstrap'
import 'bootstrap'

// import plugins individually - require exports-loader
import 'bootstrap/js/dist/modal'
import 'bootstrap/js/dist/tooltip'

// import 'bootstrap/dist/css/bootstrap.min.css'
// import 'bootstrap/scss/bootstrap.scss'

import * as VueGoogleMaps from 'vue2-google-maps'

Vue.config.productionTip = false
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

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
    store.state.currentLocation = newLocation
    this.setRightPane('SubmitReview')
  },
  clearCurrentLocation () {
    store.state.currentLocation = {}
  },
  setRightPane (name) {
    store.state.right = name
  }
}

new Vue({
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  data: store,
  render: h => h(App)
}).$mount('#app')
