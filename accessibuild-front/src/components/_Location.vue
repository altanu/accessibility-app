<template>
  <div style=" width: auto">
    <pulse-loader :loading="loading" style="margin:auto"></pulse-loader>
    <section v-if="!loading" v-bind:id="this.place.place_id" class="card" style="border: 1px solid grey">
      <div class="card-header" style="display: flex; flex-direction: row">
        <div style="margin-right: auto">
          <span v-if="this.place.name" style="font-weight: 700; font-size:larger">{{this.place.name}}</span><br v-if="this.place.name"/>
          <span>{{this.place.formatted_address}}</span>
        </div>
        <div style="border-left: 1px solid white; min-width: %30">
          <div style="display: flex; flex-direction: column; align-items: center; padding-left: 1rem">
            <img style="width: 37px; height: auto" :src="wheelchairIcon"/>
            <br/>
            <span style="font-size: smaller; text-align: center" >{{wheelchairString}}</span>
          </div>
        </div>
      </div>
      <ul class="list-group list-group-flush">
        <li style="display:flex" class="list-group-item">Wheelchair Access: <span style="margin-left:auto" :class="wheelChairClass">{{ wheelchairParsed }}</span></li>
        <li style="display:flex" class="list-group-item">Accessible Bathrooms: <span style="margin-left:auto" :class="bathroomClass">{{ bathroomParsed }}</span></li>
        <li style="display:flex" class="list-group-item">Parking: <span style="margin-left:auto" :class="parkingClass">{{ parkingParsed }}</span></li>
      </ul>
      <button class="btn btn-primary" id="review-btn" @click="reviewLocation(place)" v-if="sharedState.loggedIn">Review this location</button>
      <button class="btn btn-primary" id="trip-btn" @click="renderCreateTrip(place)" v-if="sharedState.loggedIn">Create a Trip</button>
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
      sharedState: store.state,
      pinStyles: ['/redPin.png', '/yellowPin.png', '/greenPin.png', '/greyPin.png']
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
        case 1:
          return 'Partial'
        case 0:
          return 'None'
        case 1:
          return 'Partial'
        case 0:
          return 'None'
        default:
          return 'Unknown'
      }
    },
    bathroomParsed () {
      switch (this.place.bathroom) {
        case true:
          return 'Yes'
        case false:
          return 'No'
        case false:
          return 'No'
        default:
          return 'Unknown'
      }
    },
    parkingParsed () {
      switch (this.place.parking) {
        case true:
          return 'Yes'
        case false:
          return 'No'
        case false:
          return 'No'
        default:
          return 'Unknown'
      }
    },
    wheelChairClass () {
      switch (this.place.wheelchair) {
        case 2:
          return { 'type-badge': true, 'full': true }
        case 1:
          return { 'type-badge': true, 'partial': true }
        case 0:
          return { 'type-badge': true, 'none': true }
        case 1:
          return { 'type-badge': true, 'partial': true }
        case 0:
          return { 'type-badge': true, 'none': true }
        default:
          return { 'type-badge': true, 'unknown': true }
      }
    },
    bathroomClass () {
      switch (this.place.bathroom) {
        case true:
          return { 'type-badge': true, 'full': true }
        case false:
          return { 'type-badge': true, 'none': true }
        case false:
          return { 'type-badge': true, 'none': true }
        default:
          return { 'type-badge': true, 'unknown': true }
      }
    },
    parkingClass () {
      switch (this.place.parking) {
        case true:
          return { 'type-badge': true, 'full': true }
        case false:
          return { 'type-badge': true, 'none': true }
        case false:
          return { 'type-badge': true, 'none': true }
        default:
          return { 'type-badge': true, 'unknown': true }
      }
    },
    wheelchairIcon () {
      return this.pinStyles[this.place.wheelchair]
    },
    wheelchairString () {
      switch(this.place.wheelchair) {
        case 2:
          return "Fully Accessible"
          break
        case 1:
          return "Limited Accessibility"
          break
        case 0:
          return "Not Accessible"
          break
        default:
          return "Unknown Accessibility"
      }
    }
  },
  created () {
    setTimeout(() => {
      this.fetchLocationInfo()
    }, 400)
  },
  components: {
    PulseLoader
  }
}
</script>

<style>
  #review-btn {
    border-radius: 0;
  }
  #trip-btn {
    border-radius: 0;
  }
</style>
