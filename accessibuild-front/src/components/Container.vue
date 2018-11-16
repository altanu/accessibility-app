<template>

</template>

<script>


export default {
  name: 'Container',
  components: {
    Register,
    RightHome
  },
  data: () => {
    return {
      state: store.state
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.Container {
  flex-direction: column;
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
