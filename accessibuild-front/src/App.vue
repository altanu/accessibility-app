<template>
  <div id="app" style="height: 100%">
    <Navbar v-bind:onClick='setState' v-bind:is-logged-in="this.loggedIn" v-bind:set-login="setLogin"></Navbar>
    <div style="height: 100%">
    <div style="height: 100%">
      <div :class="classObject" style="padding-top: 4em; height: 100%">
        <div id="left-box">
          <Map
            v-bind:current-place="this.currentLocation"
            v-bind:places-list="this.placesList"
            v-bind:address-string="this.currentAddress"
            v-on:address-change="updateAddress"
            v-on:new-list="newList">
          </Map>
        </div>
        <div id="right-box" v-show="$mq !== 'sm'">
          <transition name='fade'>
            <component
              v-bind:state="state"
              v-bind:is='state.right'
              v-bind:address-string="this.currentAddress"
              v-bind:set-login="setLogin"
              v-bind:current-place="this.currentLocation"
              v-bind:places-list="this.placesList"
              v-bind:onClick='setState'
              :user-id="this.userId">
            </component>
          </transition>
        </div>
      </div>
    </div>
  </div>
    <router-view/>
  </div>
</template>

<script>
import SubmitReview from './components/SubmitReview.vue'
import Navbar from './components/Navbar.vue'
import Register from './components/Register.vue'
import RightHome from './components/RightHome.vue'
import Map from './components/Map.vue'
import Login from './components/Login.vue'
import Contacts from './components/Contacts.vue'
import Profile from './components/Profile.vue'

export default {
  name: 'App',
  props: {
    msg: String
  },
  mounted () {
    this.geolocate()
    console.log('store: ', store.state)
  },
  data: () => {
    return {
      state: store.state,
      // default to montreal
      currentLocation: { lat: 45.5, lng: -73.5 },
      userId: 1,
      placesList: [],
      currentAddress: '',
      loggedIn: false,
    }
  },
  methods: {
    setState (stateValue) {
      this.state.right = stateValue
    },
    updateLocation (place) {
      this.currentLocation = place
    },
    updateAddress (newAddress) {
      this.currentAddress = newAddress
    },
    geolocate: function () {
      navigator.geolocation.getCurrentPosition(position => {
        this.updateLocation({
          lat: position.coords.latitude,
          lng: position.coords.longitude
        })
      })
    },
    setLogin: function () {
      this.loggedIn = !this.loggedIn
    },
    newList: function(arr) {
      this.placesList = arr
      this.state.right = 'rightHome'
      store.clearCurrentLocation()
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
    }
  },
  components: {
    // Footer,
    Navbar,
    RightHome,
    Register,
    Login,
    Map,
    Contacts,
    Profile,
    SubmitReview,
  }
}
</script>

<style lang="scss">
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
