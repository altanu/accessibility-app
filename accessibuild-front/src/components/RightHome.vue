<template>
  <div class="w-75 p-5">

      <h4>Welcome</h4>
      <p>We located you at {{addressString[0].formatted_address}}</p>
      <p>What would you like to do today?</p>

    <div>
      <button class="btn btn-primary" @click='onClick("SubmitReview")'>Submit a new review</button>
    </div>

      <p>We found the following results for you:</p>
      <p v-for="place in receivedPlaceList">{{place.formatted_address}}</p>

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
  data() {
    return {
      receivedPlaceList: this.placesList
    }
  },
  name: 'RightHome',
}
</script>
