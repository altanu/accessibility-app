<template>
  <section>
    <h3>This is the page for companions of the user</h3>
    {{address}}
    {{trip_time}}
    {{trip_owner}}
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
      tripId: this.$route.params.trip_id,
      address: null,
      trip_time: null,
      trip_owner: null,
          
    }
  },
  methods: {
    fetchTripInfo () {
    axios.get('http://localhost:3000/api/v2/trips/' + this.tripId)
      .then(response => {
        const trip = response.data
        this.trip_owner = trip.trip_owner
        this.trip_time = trip.trip_time
      })
    }
  },
  created () {
    this.fetchTripInfo()
  }
}
</script>

