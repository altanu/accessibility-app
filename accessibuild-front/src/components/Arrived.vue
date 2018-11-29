<template>
  <div>
    <section>
      <header class="card">
        <h3>You've arrived at your destination</h3>
      </header>
      <div class="card card-body">
        <p>Thank you for using Accessibl. We hope your trip is a success!</p>
        <p>An email has been sent to the contacts you added to your trip</p>
      </div>
    </section>
    <div style="width: 100%">
      <button style="margin: 0 0 0 30%" @click='reviewPage' class='btn btn-outline-primary round-button'>Review this location</button>
    </div> 
  </div>
</template>

<script>
  export default {
    name: 'Arrived',
    methods: {
      reviewPage() {
        store.state.currentLocation = { 
          "address_components": [ 
            { "long_name": "1275", "short_name": "1275", "types": [ "street_number" ] }, 
            { "long_name": "Avenue des Canadiens-de-Montréal", "short_name": "Avenue des Canadiens-de-Montréal", "types": [ "route" ] }, 
            { "long_name": "Ville-Marie", "short_name": "Ville-Marie", "types": [ "political", "sublocality", "sublocality_level_1" ] }, 
            { "long_name": "Montréal", "short_name": "Montréal", "types": [ "locality", "political" ] }, 
            { "long_name": "Communauté-Urbaine-de-Montréal", "short_name": "Communauté-Urbaine-de-Montréal", "types": [ "administrative_area_level_2", "political" ] }, 
            { "long_name": "Québec", "short_name": "QC", "types": [ "administrative_area_level_1", "political" ] }, 
            { "long_name": "Canada", "short_name": "CA", "types": [ "country", "political" ] }, 
            { "long_name": "H3B 5E6", "short_name": "H3B 5E6", "types": [ "postal_code" ] } ], 
          "formatted_address": "1275 Avenue des Canadiens-de-Montréal, Montréal, QC H3B 5E6, Canada", 
          "geometry": { "location": { "lat": 45.4964397, "lng": -73.5706624 }, 
          "location_type": "ROOFTOP", 
          "viewport": { "south": 45.49509071970849, "west": -73.57201138029154, "north": 45.49778868029149, "east": -73.56931341970846 } }, 
          "place_id": "ChIJAVPyG2gayUwRFbKNtoOUdOo", 
          "plus_code": { "compound_code": "FCWH+HP Montreal, Quebec, Canada", "global_code": "87Q8FCWH+HP" }, 
          "types": [ "street_address" ], 
          "name": "1275 Avenue des Canadiens-de-Montréal", 
          "wheelchair": 2, 
          "lat": 45.4964397, "lng": -73.5706624, 
          "bathroom": null, 
          "parking": null, 
          "id": 1 }
        store.setRightPane('SubmitReview')
      }
    }
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
