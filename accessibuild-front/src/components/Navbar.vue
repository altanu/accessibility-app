<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div style="display: flex">
      <div>
      <form class="form-inline my-2 my-lg-0">
        <input class="form-control mr-sm-3" ref="autocomplete" onFocus="value = ''" type="text" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success my-3 my-sm-0" type="submit">Search</button>
      </form>
      </div>
      <div style="float: right">
      <ul class="navbar-nav mr-auto">
        <router-link to="/" class="navbar-brand">AccessiBuild</router-link>
        <li class="nav-item">
          <router-link to="/users" class="nav-link">Users</router-link>
        </li>
        <li class="nav-item">
          <router-link to="/locations" class="nav-link">Locations</router-link>
        </li>
        <li class="nav-item">
          <router-link to="/register" class="nav-link">Register</router-link>
        </li>
      </ul>
      </div>
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
