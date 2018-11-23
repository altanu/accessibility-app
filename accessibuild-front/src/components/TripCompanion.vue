<template>
  <section>
    <section v-if="loggedIn">

    </section>
    <section v-if="!loggedIn">
      <h3>This is the page for companions of the user</h3>
      {{address}}
      {{trip_time}}
      {{trip_owner}}
    </section>  
  </section>
</template>

<script>
import axios from 'axios'
export default {
  name: 'TripCompanion',
  props: {
      
  },
  data () {
    return {
      loggedIn: store.state.loggedIn,
      tripId: this.$route.params.trip_id,
      address: store.state.currentTrip.address,
      trip_time: store.state.currentTrip.trip_time,
      trip_owner: store.state.currentTrip.trip_owner,
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
          store.setRightPane('TripCompanion')
        })
    }
  },
  created () {
    this.fetchTripInfo()
  }
}
</script>

