<template>
  <div class="w-75 p-5">
    <div v-if="placesList.length == 0">
      <h4>Welcome</h4>
      <p>We located you at {{addressString[0].formatted_address}}</p>
      <p>What would you like to do today?</p>
    </div>
    <div>
      <button class="btn btn-primary" @click='onClick("SubmitReview")'>Submit a new review</button>
    </div>
    <div v-if="placesList.length > 0">
    <p>We found the following results for you:</p>
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
  </div>
</template>

<script>
export default {
  props: {
    onClick: Function,
    currentPlace: Object,
    placesList: Array,
    addressString: Array
  },
  name: 'RightHome',
}
</script>
