<template>
  <div id='right-home'>
    <div v-if="placesList.length == 0">
      <h4>Welcome</h4>
      <p>We located you near {{addressString}}</p>
      <p>What would you like to do today?</p>
    </div>
    <div v-if="placesList.length > 0">
      <p>We found the following results for you:</p>

      <Location
        v-for="place in placesList"
        v-bind:place="place"
        v-bind:key="place.place_id"
        v-bind:onClick="onClick"
      ></Location>
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
