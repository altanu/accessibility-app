<template>
  <section>
    <header class="card">
      <h3>You've arrived at your destination</h3>
    </header>
    <div class="card card-body">
      <p>Thank you for using Accessibl. We hope your trip is a success!</p>
      <p>An email has been sent to the contacts you added to your trip</p>
    </div >
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
