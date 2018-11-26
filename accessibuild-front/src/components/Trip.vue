<template>
  <section>
    <section v-if="loggedIn">
      <h3>This is the page for owner of the trip</h3>
      <p>Destination: {{address}}</p>
      <p>Trip Time: {{trip_time}}</p>
      <ul>
        Companions attached to this trip:
        <li v-for="companion in companions" v-bind:key="companion.id">
          {{companion.first_name}} {{companion.last_name}}
        </li>
      </ul>
      <button class="btn round-button arrived-btn" @click="arrivedAtDestination">I've arrived</button>
      <button class="btn round-button cancel-btn" @click="cancelledTrip">Cancel this Trip</button>
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
    this.fetch
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
</style>
