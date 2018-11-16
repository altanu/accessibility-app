<template>
  <div>
    <h1>Big Container</h1>
    <div class='container-fluid d-flex no-padding'>
      <div class='container-fluid flex-fill' id='map'>This is the map component</div>
      <div class='container' id='right'>This is the right component</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Container',
  // components: {
  //   map,
  //   right
  // }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.Container {
  flex-direction: column;
}
.no-padding {
  padding: 0;
}
#map {
  background-color: green;
  height: 80vh;
  width: 60vw;
}
#right {
  background-color: yellow;
  height: 80vh;
  width: 40rem;
}

</style>
