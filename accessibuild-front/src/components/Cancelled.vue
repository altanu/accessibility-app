<template>
  <section>
    <header class="card">
      <h3>Your trip has been cancelled</h3>
    </header>
    <div class="card card-body">
      <p>To create a new trip, please click on your destination, and then click on "Create a Trip"</p>
      <p>An email has been sent to the contacts you added to your trip</p>
    </div>
  
  </section>
</template>

<script>
  export default {
    name: 'Cancelled'
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
