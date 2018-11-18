<template>
  <div class="w-75 p-5">
    <h1>Right Home</h1>
    <button @click='onClick("SubmitReview")'>Submit review</button>
    <button>Search</button>
    <p> below is a list of places from the map </p>
    <table>
      <tr>
        <td>Place_ID</td>
        <td>Wheelchair?</td>
      </tr>
      <tr v-for="place in placesList">
        <td>{{ place.place_id }}</td>
        <td> NEEDTOCALLAPI </td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  props: {
    onClick: Function,
    currentPlace: Object,
    placesList: Array
  },
  name: 'RightHome',
  data () {
    return {

    }
  }
}

</script>
