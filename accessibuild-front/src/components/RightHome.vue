<template>
  <div id='right-home'>
    <button @click.self="$emit('drop-right')" v-show="isFocused && $mq === 'sm'" class="btn btn-outline-primary btn-block">Hide</button>
    <div @click="$emit('lift-right')" v-if="placesList.length == 0">
      <h2>Accessibl helps plan your trip</h2>

      <div class="alert alert-dark">
        <p>We located you near:</p>
        <b>{{userDetectedPlace.formatted_address}}</b>
      </div>
      
      <p class="lead">
        Accessibl was built to help people with reduced mobility plan their outings. We keep track of which locations have a
        <strong>ramp</strong>, <strong>accessible bathroom</strong> or <strong>reserved parking</strong>, so you know what to expect
        when you get to your destination.
      </p>
      <p class="lead">
        The reviews for locations are user generated, and you can see comments people have left on the accessibility status of each.
        You will see the most recent data we have on the physical facilities, so if things change since you've last been somewhere, you
        know ahead of time.
      </p>
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
  mounted() {
    this.$parent.$on('app-refresh', this.refreshMap)
  }
}
</script>

