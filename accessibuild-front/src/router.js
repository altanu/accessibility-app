import Vue from 'vue'
import Router from 'vue-router'
import Locations from './components/Locations.vue'
import Users from './components/Users.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'

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
      path: '/users/:id',
      name: 'users',
      component: Users
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
    }
  ]
})
