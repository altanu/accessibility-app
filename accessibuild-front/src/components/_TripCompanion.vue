<template>
  <div>
    <div class="contact-info card col" style="padding: 0;">
      <div class="card-header">
        <h3 style="margin: 0">{{ full_name }}</h3>
      </div>
      <div class="card-body">
        <p>{{companion.email}}</p>
        <p>{{companion.phone_number}}</p>
        <p v-if="companion.emergency">{{companion.first_name}} is one of your emergency contacts!</p>
        <p v-else >{{companion.first_name}} isn't an emergency contact.</p>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'TripCompanion',
  props: {
    companion: Object
  },
  data () {
    return {
      isOnTrip: false
    }
  },
  methods: {
    setIsOnTrip (bool) {
      this.isOnTrip = bool
    }
  },
  computed: {
    full_name () {
      return this.companion.first_name + ' ' + this.companion.last_name
    }
  }
}

</script>
