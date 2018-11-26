<template>
  <div id='right-home'>
    <button @click.self="$emit('drop-right')" v-show="isFocused && $mq === 'sm'" class="btn btn-outline-primary btn-block">Hide</button>
    <div @click="$emit('lift-right')" v-if="placesList.length == 0">
      <div class="alert alert-dark">
        <p>We located you near:</p>
        <b>{{userDetectedPlace.formatted_address}}</b>
      </div>
      
      <h1>Accessibl helps plan your trip</h1>

      <p class="lead">
        Accessibl was built to help people with reduced mobility plan their outings. We keep track of which locations have a
        <strong>ramp</strong>, <strong>accessible bathroom</strong> or <strong>reserved parking</strong>, so you know what to expect
        when you get to your destination.
      </p>
      <p class="lead">
        The reviews for locations are user generated, and you can see comments people have left on the accessibility status of each.
        You will see the most recent data we have on the physical facilities, so if things change since you've last been somewhere, you
        know ahead of time. If you want to provide updates for a location, or just add a new one, all you have to do is make an account, 
        and then you will be able to review any location.
      </p>
      <p class="lead">
        Having an account will also allow you to add contacts we can notify on your behalf when you plan a trip using Accessibl. If you
        like, we can send updates to them before, during and after your trip so your companions will now when and where to meet you.
      </p>

      <button class='btn btn-outline-primary round-button' @click="focusOnSearch">Search</button>
    </div>
    <div @click="$emit('lift-right')" v-if="placesList.length > 0">
      <p>We found the following results for you:</p>

      <Location
        v-for="place in placesList"
        v-bind:placesList="placesList"
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
    isFocused: Boolean
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
  mounted() {
    this.$parent.$on('app-refresh', this.refreshMap)
  }
}
</script>
