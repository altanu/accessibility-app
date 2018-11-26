<template>
  <div id='app' style='height: 100%'>
    <Navbar
      v-bind:onClick='setState'
      v-bind:is-logged-in='this.loggedIn'
      v-bind:set-login='setLogin'
       v-on:new-list='newList'>
    </Navbar>
    <div style='height: 100%'>
      <div id='flexbox-container' :class='classObject'>
        <div v-show='renderMap' id='left-box'>
          <Map
            v-bind:places-list='this.placesList'
            v-on:new-list='newList'
            v-on:user-detected-place='detectUserPlace'>
          </Map>
        </div>
        <div id='right-box' @click="scaleUpOnMobile" v-bind:style='rightHeight'>
          <transition name='fade'>
            <component
              v-bind:user-detected-place='this.userDetectedPlace'
              v-bind:state='state'
              v-bind:is='state.right'
              v-bind:set-login='setLogin'
              v-bind:places-list='this.placesList'
              v-bind:onClick='setState'
              v-bind:user-id='this.userId'
              v-on:refresh-map='refreshMap'>
            </component>
          </transition>
          <div style="display: none;">
            <router-view></router-view>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import SubmitReview from './components/SubmitReview.vue'
import Navbar from './components/Navbar.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Map from './components/Map.vue'
import Login from './components/Login.vue'
import Profile from './components/Profile.vue'
import CreateTrip from './components/CreateTrip.vue'
import Trip from './components/Trip.vue'
export default {
  name: 'App',
  data: () => {
    return {
      state: store.state,
      userDetectedPlace: {},
      userId: 1,
      placesList: [],
      loggedIn: true
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    setLogin: function () {
      this.loggedIn = !this.loggedIn
    },
    newList: function (arr) {
      this.placesList = arr
      this.state.right = 'RightHome'
      store.clearCurrentLocation()
    },
    detectUserPlace: function (place) {
      this.userDetectedPlace = place
    },
    refreshMap: function (arr) {
      console.log('app received the refresh-map event')
      this.placesList = []
      this.newList(arr)
    },
    scaleUpOnMobile: function () {
      if (this.$mq === 'sm' && store.state.right === 'RightHome') {
        console.log('Mobile touch on div!')
      } else if (store.state.right === 'RightHome') {
        console.log('Desktop touch on div!')
      }
    }
  },
  computed: {
    classObject: function () {
      if (this.$mq !== 'sm') {
        return {
          'd-flex': true,
          'align-self-center': true
        }
      } else {
        return {
          flexClass: '',
          alignClass: ''
        }
      }
    },
    renderMap: function () {
      return this.state.right === 'RightHome' || this.$mq !== 'sm'
    },
    rightHeight: function () {
      return this.renderMap && this.$mq === 'sm' ? { height: '40%' } : { height: '100%' }
    }
  },
  components: {
    Navbar,
    RightHome,
    Register,
    Login,
    Map,
    Profile,
    SubmitReview,
    CreateTrip,
    Trip
  }
}
</script>

<style lang='scss'>
  @import './assets/scss/main.scss'
</style>

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
