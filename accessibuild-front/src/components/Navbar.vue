<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div>
      <form class="form-inline">
        <input class="form-control" ref="autocomplete" onFocus="value = ''" type="text" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-primary" type="submit" style="margin-left: 1rem">🔍 Search</button>
      </form>
      <router-link to="/" class="navbar-brand" style="margin: auto">AccessiBuild</router-link>       
    </div>
  </nav>
</template>

<script>
export default {
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
