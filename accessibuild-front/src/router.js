import Vue from 'vue'
import Router from 'vue-router'
import Locations from './components/Locations.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Trip from './components/Trip.vue'
// import TripUser from './components/TripUser.vue'

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
      path: '/trips/:trip_id/',
      name: 'trip',
      component: Trip
    },
    // {
    //   path: '/trips/:trip_id',
    //   name: 'tripUser',
    //   component: TripUser
    // }
  ]
})
