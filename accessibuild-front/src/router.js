import Vue from 'vue'
import Router from 'vue-router'
import Locations from './components/Locations.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Trip from './components/Trip.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/locations',
      name: 'locations',
      component: Locations
    },
    {
      path: '/register',
      name: 'register',
      component: Register
    },
    {
      path: '/home',
      name: 'home',
      component: RightHome
    },
    {
      path: '/api/v2/trips/:trip_id',
      name: 'trip',
      component: Trip
    }
  ]
})
