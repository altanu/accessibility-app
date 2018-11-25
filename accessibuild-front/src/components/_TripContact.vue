<template>
  <div>
    <div class="contact-info card col" style="padding: 0;">
      <div class="card-header">
        <h3 style="margin: 0">{{ full_name }}</h3>
      </div>
      <div class="card-body">
        <p>{{contact.email}}</p>
        <p>{{contact.phone_number}}</p>
        <p v-if="contact.emergency">{{contact.first_name}} is one of your emergency contacts!</p>
        <p v-else >{{contact.first_name}} isn't an emergency contact.</p>
      </div>
    </div>
    <div class="contact-buttons card col-sm-4" style="display: flex; flex-direction: column; padding: 0;">
      <button v-show="!isOnTrip" @click="addContactToTrip(contact); setIsOnTrip(true)" style="flex-grow: 1;" class="btn btn-outline-success">Add</button>
      <button v-show="isOnTrip" @click="removeContactFromTrip(contact); setIsOnTrip(false)" style="flex-grow: 1;" class="btn btn-outline-warning">Remove</button>
    </div>
  </div>
</template>

<script>

export default {
  name: 'TripContact',
  props: {
    contact: Object,
    addContactToTrip: Function,
    removeContactFromTrip: Function
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
      return this.contact.first_name + " " + this.contact.last_name
    }
  }
}

</script>
