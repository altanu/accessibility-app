<template>
  <section>
    <h3>This is the </h3>
    {{address}}
    {{trip_time}}
    {{trip_owner}}
  </section>  
</template>

<script>
export default {
  name: 'TripCompanion',
  props: {
    tripId: $route.params.id,
    address: null,
    trip_time: null,
    trip_owner: null,
  },
  data () {
    return {
      
    }
  },
  methods: {
      fetchTripInfo () {
      axios.get('http://localhost:3000/api/v2/trips/' + tripId)
          .then(response => {
            const trip = response.data
            this.trip_owner = trip.first_name
            this.trip_time = trip.trip_time
          })
      }
  }
}
</script>

