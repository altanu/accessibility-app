<template>
  <section>
    <header class="card">
      <h3>Your trip has been cancelled successfully</h3>
    </header>
    <div class="card card-body">To create a new trip, please click on your destination, and then click on "Create a Trip"</div >

  </section>
</template>

<script>

export default {
  name: 'Arrived'
}

</script>

<style scoped>
  header {
    padding: 5%;
    margin: 5%;
    margin-top: 15%;
    margin-bottom: 0;
    box-shadow: 5px 5px 3px grey;
  }
  .card-body {
    padding: 5%;
    margin: 5%;
    box-shadow: 5px 5px 3px grey;
  }
</style>
