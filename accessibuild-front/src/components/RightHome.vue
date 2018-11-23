<template>
  <div id='right-home'>
    <div v-if="placesList.length == 0">
      <h4>Welcome</h4>
      <p>We located you near {{userDetectedPlace.formatted_address}}</p>
      <p>What would you like to do today?</p>
      <button class='btn btn-outline-primary round-button' @click="focusOnSearch">Search</button>
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
    userDetectedPlace: Object,
    placesList: Array,
  },
  name: 'RightHome',
  components: {
    Location
  },
  methods: {
    focusOnSearch: function () {
      var searchBar = document.getElementById('pac-input')
      searchBar.style.border = '3px solid black'
      searchBar.focus()
      setTimeout(function () {
        searchBar.style.border = '1px solid grey'
      }, 3000)
    }
  },
}
</script>
