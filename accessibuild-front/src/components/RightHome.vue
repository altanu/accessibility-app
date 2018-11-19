<template>
  <div class="w-75 p-5">
    <div v-if="placesList.length == 0">
      <h4>Welcome</h4>
      <div>
      <p v-if="addressString">We located you at {{addressString}}</p>
      <p v-else>Please allow us to access your location, so we can help you better.</p>
      </div>
      
      <p>What would you like to do today?</p>
    </div>
    <div>
      <button class="btn btn-primary" @click='onClick("SubmitReview")'>Submit a new review</button>
    </div>

    <div v-if="placesList.length > 0">
    <p>We found the following results for you:</p>
    <p v-for="place in placesList">{{place.formatted_address}}</p>
    <!-- <Location
      v-for="place in placesList"
      v-bind:placeID="place.place_id"
      v-bind:key="place.place_id"
    ></Location> -->
    </div>

  </div>
</template>

<script>
import Location from './_Location.vue'

export default {
  props: {
    onClick: Function,
    currentPlace: Object,
    placesList: Array,
    addressString: String
  },
  name: 'RightHome',
  components: {
    Location
  }
}
</script>
