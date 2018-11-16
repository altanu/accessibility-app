<template>
  <nav class='navbar navbar-expand-lg navbar-light bg-light'>
      <form class='form-inline' v-on:submit.prevent>
        <button @click='onClick("RightHome")' class='btn btn-outline-primary'>Home</button>

        <form class='form-inline'>
          <gmap-autocomplete class='form-control' @place_changed="moveMap"></gmap-autocomplete>
          <button class='btn btn-outline-success' type='submit' style='margin-left: .5rem'>🔍 Search</button>
        </form>
      
        <button @click='onClick("Register")' class='btn btn-outline-primary' ref='registerlogin' type='submit'>Login / Register</button>
      </form>
  </nav>
</template>

<script>
export default {
  props: {
    onClick: Function
  },
  methods: {
    moveMap(place) {
      this.$emit('newLocation',place)
    }
  }
}
</script>
