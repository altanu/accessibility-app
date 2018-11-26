<template>
  <div style="display:flex; width: auto">
    <pulse-loader :loading="loading" style="margin:auto"></pulse-loader>
    <section v-if="!loading" v-bind:id="this.place.place_id" class="card" style="border: 1px solid grey">
      <div v-if="this.place.name" class="card-header">{{this.place.name}}</div>
      <div class="card-header">Address: {{this.place.formatted_address}}</div>
      <ul class="list-group list-group-flush">
        <li class="list-group-item">Wheelchair Access: <span :class="wheelChairClass">{{ wheelchairParsed }}</span></li>
        <li class="list-group-item">Accessible Bathrooms: <span :class="bathroomClass">{{ bathroomParsed }}</span></li>
        <li class="list-group-item">Parking: <span :class="parkingClass">{{ parkingParsed }}</span></li>
      </ul>
      <button class="btn" @click="reviewLocation(place)" v-if="sharedState.loggedIn">Review this location</button>
      <button class="btn" @click="renderCreateTrip(place)" v-if="sharedState.loggedIn">Create a Trip</button>
    </section>
  </div>
</template>

<script>
import PulseLoader from 'vue-spinner/src/PulseLoader.vue'

var axios = require('axios')
export default {
  name: 'Location',
  props: {
    placesList: Array,
    place: Object,
    onClick: Function
  },
  data () {
    return {
      loading: true,
      sharedState: store.state
    }
  },
  methods: {
    fetchLocationInfo () {
      console.log(this.place)
      var self = this
      axios.get('http://localhost:3000/api/v2/places/' + this.place.place_id)
        .then(response => {
          const dbLocation = response.data[0]
          if (dbLocation) {
            this.place.wheelchair = dbLocation.wheelchair
            this.place.bathroom = dbLocation.bathroom
            this.place.parking = dbLocation.parking
            this.place.id = dbLocation.id
          }
        }).then(() => {
          self.loading = false
        })
    },
    reviewLocation (location) {
      var self = this

      var geocoder = new google.maps.Geocoder()
      geocoder.geocode({ 'placeId': this.place.place_id, 'language': 'en' }, function (results, status) {
        var lat = results[0].geometry.location.lat()
        var lng = results[0].geometry.location.lng()
        const saveLocation = {
          place_id: self.place.place_id,
          wheelchair: self.wheelchair,
          bathroom: self.bathroom,
          parking: self.parking,
          lat: lat,
          lng: lng
        }
        if (!self.place.id) {
          axios.post('http://localhost:3000/api/v2/locations', saveLocation)
            .then(response => {
              store.setCurrentLocation(location)
              store.setCurrentLocationId(response.data.id)
              self.onClick('SubmitReview')
            })
        } else {
          store.setCurrentLocation(location)
        }
      })
    },
    renderCreateTrip (location) {
      var self = this

      var geocoder = new google.maps.Geocoder()
      geocoder.geocode({ 'placeId': this.place.place_id, 'language': 'en' }, function (results, status) {
        var lat = results[0].geometry.location.lat()
        var lng = results[0].geometry.location.lng()
        const saveLocation = {
          place_id: self.place.place_id,
          wheelchair: self.wheelchair,
          bathroom: self.bathroom,
          parking: self.parking,
          lat: lat,
          lng: lng
        }
        if (!self.place.id) {
          axios.post('http://localhost:3000/api/v2/locations', saveLocation)
            .then(response => {
              store.setCurrentLocation(location)
              store.setCurrentLocationId(response.data.id)
              self.onClick('CreateTrip')
            })
        } else {
          store.setCurrentLocation(location)
          self.onClick('CreateTrip')
        }
      })
    }
  },
  computed: {
    wheelchairParsed () {
      switch (this.place.wheelchair) {
        case 2:
          return 'Full'
          break
        case 1:
          return 'Partial'
          break
        case 0:
          return 'None'
          break;
        case 1:
          return 'Partial'
          break;
        case 0:
          return 'None'
          break;
          break
        default:
          return 'Unknown'
      }
    },
    bathroomParsed () {
      switch (this.place.bathroom) {
        case true:
          return 'Yes'
          break
        case false:
          return 'No'
          break;
        case false:
          return 'No'
          break;
          break
        default:
          return 'Unknown'
      }
    },
    parkingParsed () {
      switch (this.place.parking) {
        case true:
          return 'Yes'
          break
        case false:
          return 'No'
          break;
        case false:
          return 'No'
          break;
          break
        default:
          return 'Unknown'
      }
    },
    wheelChairClass () {
      switch (this.place.wheelchair) {
        case 2:
          return { 'type-badge': true, 'full': true }
          break
        case 1:
          return { 'type-badge': true, 'partial': true }
          break
        case 0:
          return { 'type-badge': true, 'none': true }
          break;
        case 1:
          return { 'type-badge': true, 'partial': true }
          break;
        case 0:
          return { 'type-badge': true, 'none': true }
          break;
          break
        default:
          return { 'type-badge': true, 'unknown': true }
      }
    },
    bathroomClass () {
      switch (this.place.bathroom) {
        case true:
          return { 'type-badge': true, 'full': true }
          break
        case false:
          return { 'type-badge': true, 'none': true }
          break;
        case false:
          return { 'type-badge': true, 'none': true }
          break;
          break
        default:
          return { 'type-badge': true, 'unknown': true }
      }
    },
    parkingClass () {
      switch (this.place.parking) {
        case true:
          return { 'type-badge': true, 'full': true }
          break
        case false:
          return { 'type-badge': true, 'none': true }
          break;
        case false:
          return { 'type-badge': true, 'none': true }
          break;
          break
        default:
          return { 'type-badge': true, 'unknown': true }
      }
    }
  },
  created () {
    setTimeout(() => {
      this.fetchLocationInfo()
    }, 400);
  },
  components: {
    PulseLoader
  }
}
</script>
