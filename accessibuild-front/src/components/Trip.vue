<template>
  <section>
    <section v-if="loggedIn">
      <header>
        <h3>Hello, {{trip_owner}}</h3>
      </header>
      <div class='trip-info'>
        <p>Destination: <strong>{{address}}</strong></p>
        <p>Trip Time: <strong>{{trip_time}}</strong></p>
      </div>
      <ul>
        Companions attached to this trip:
        <li v-for="companion in companions" v-bind:key="companion.id">
          <TripCompanion v-bind:companion="companion"></TripCompanion>
        </li>
      </ul>
      <div class="buttons-container">
        <button class="btn btn-success" @click="arrivedAtDestination">I've arrived</button>
        <button class="btn btn-warning" @click="cancelledTrip">Cancel this Trip</button>
      </div>
    </section>
    <section v-if="!loggedIn">
      <h3>This is the page for companions of the user</h3>
      <p>Destination: {{address}}</p>
      <p>Trip Time: {{trip_time}}</p>
      <p>Trip Owner: {{trip_owner}}</p>
    </section>
  </section>
</template>

<script>
import axios from 'axios'
import TripCompanion from './_TripCompanion.vue'
export default {
  name: 'Trip',
  props: {

  },
  data () {
    return {
      loggedIn: store.state.loggedIn,
      tripId: this.$route.params.trip_id || store.state.currentTrip.trip_id,
      address: store.state.currentTrip.address,
      trip_time: store.state.currentTrip.trip_time,
      trip_owner: store.state.currentTrip.trip_owner,
      companions: []
    }
  },
  methods: {
    fetchTripInfo () {
      axios.get('http://localhost:3000/api/v2/trips/' + this.tripId)
        .then(response => {
          const trip = response.data
          store.state.currentTrip.trip_owner = trip.trip_owner
          store.state.currentTrip.trip_time = trip.trip_time
          store.state.currentTrip.address = trip.address
          store.setRightPane('Trip')
          this.companions = response.data.companions
          this.trip_owner = response.data.trip_owner
        })
    },
    arrivedAtDestination () {
      axios.put(`http://localhost:3000/api/v2/trips/${this.tripId}/completed_mail`)
    },
    cancelledTrip () {
      axios.put(`http://localhost:3000/api/v2/trips/${this.tripId}/cancelled_mail`)
    }
  },
  created () {
    this.fetchTripInfo()
  },
  components: {
    TripCompanion
  }
}
</script>

<style>
  .arrived-btn {
    background-color: green;
  }
  .cancel-btn {
    background-color: red;
  }
  .buttons-container {
    display: flex;
    justify-content: space-around;
  }
  .trip-info {
    padding: 0 20px 0 20px;
  }
  ul {
    padding: 20px;
  }
  header {
    padding: 20px;
  }
</style>
