<template>
  <section v-if="trip_owner">
    <h3>This is the page for the owner of the trip</h3>
    {{address}}
    {{trip_time}}
    {{trip_owner}}
  </section>  
</template>

<script>
import axios from 'axios'
export default {
  name: 'TripUser',
  props: {
      
  },
  data () {
    return {
      tripId: this.$route.params.trip_id,
      address: store.state.currentTrip.address,
      trip_time: store.state.currentTrip.trip_time,
      trip_owner: store.state.currentTrip.trip_owner,
      trip_companions: []
    }
  },
  methods: {
    fetchTripInfo () {
      axios.get('http://localhost:3000/api/v2/trips/' + this.tripId)
        .then(response => {
          const trip = response.data
          store.state.currentTrip.trip_owner = trip.trip_owner
          store.state.currentTrip.trip_time = trip.trip_time
          store.setRightPane('Trip')
        })
    }
  },
  created () {
    this.fetchTripInfo()
  }
}
</script>

