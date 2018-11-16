<template>
  <nav class='navbar navbar-expand-lg navbar-light bg-light'>
      <form class='form-inline' v-on:submit.prevent>
        <button @click='onClick("RightHome")' class='btn btn-outline-primary'>Home</button>

        <form class='form-inline'>
          <input class='form-control' ref='autocomplete' type='text' placeholder='Search' aria-label='Search'>
          <button class='btn btn-outline-success' type='submit' style='margin-left: .5rem'>🔍 Search</button>
        </form>

        <button @click='onClick("Register")' class='btn btn-outline-primary' ref='register' type='submit'>Register</button>
        <button @click='onClick("Login")' class='btn btn-outline-primary' ref='login' type='submit'>Login</button>
      </form>
  </nav>
</template>

<script>
export default {
  props: {
    onClick: Function
  },
  mounted () {
    this.autocomplete = new google.maps.places.Autocomplete(
      (this.$refs.autocomplete),
      {types: ['geocode']}
    )
    this.autocomplete.addListener('place_changed', () => {
      let place = this.autocomplete.getPlace();
      let address_components = place.address_components;
      let lat = place.geometry.location.lat();
      let lon = place.geometry.location.lng();
      console.log("place", place)
    })
  }
}
</script>
