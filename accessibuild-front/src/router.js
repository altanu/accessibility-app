import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Locations from './components/Locations.vue'
import Users from './components/Users.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/locations',
      name: 'locations',
      component: Locations
    },
    {
      path: '/users/:id',
      name: 'users',
      component: Users
    }
  ]
})
