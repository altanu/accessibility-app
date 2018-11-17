<template>
  <div style="height: 100%">
    <gmap-map
      :center="currentPlace"
      :zoom="zoom"
      style="min-width:50%; height: 100%"
    >
      <gmap-marker
        :key="index"
        v-for="(m, index) in markers"
        :position="m.position"
        @click="center=m.position"
      ></gmap-marker>
    </gmap-map>
  </div>
</template>

<script>
export default {
  name: 'GoogleMap',
  props: {
    currentPlace: Object
  },
  data () {
    return {
      // default to Montreal to keep it simple
      center: { lat: 45.508, lng: -73.587 },
      zoom: 16,
      markers: [],
      places: [],
    }
  },

  mounted () {
    this.geolocate()
  },

  methods: {
    geolocate: function () {
      navigator.geolocation.getCurrentPosition(position => {
        this.center = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        }
      })
    }
  }
}
</script>
