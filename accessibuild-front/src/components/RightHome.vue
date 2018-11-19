<template>
  <div class="w-75 p-5">
    <div v-if="placesList.length == 0">
      <h4>Welcome</h4>
      <p>We located you at {{currentPlace}}</p>
      <p v-if="addressString">{{addressString}}</p>
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
var geocoder = new google.maps.Geocoder
var self = this
export default {
  props: {
    onClick: Function,
    currentPlace: Object,
    placesList: Array
  },
  data () {
    return {
      addressString: "TEST",
      coordinates: this.currentPlace
    }
  },
  mounted() {
    this.updateAddress()
  },
  name: 'RightHome',
  methods: {
    updateAddress: () => {
      var getAddress = new Promise(function(resolve, reject) {
        console.log("called promise")
        console.log("can I read currentPlace?", self.coordinates)
        var address = ""
        geocoder.geocode({'location': this.currentPlace}, function(results, status) {
          console.log("status received", status)
          console.log("called geocoder, got this result:", results)
          address = results[0].formatted_address
        })
        resolve(address)
      })
      getAddress.then(data => {
        console.log(data)
        addressString = data
      });
    }
  }
}

</script>
