<template>
  <div class="w-75 p-5">
    <div>
      <button class="btn btn-lg btn-primary" @click='onClick("SubmitReview")'>Submit review</button>
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
    placesList: Array
  },
  name: 'RightHome',
  data () {
    return {

    }
  }
}

</script>
