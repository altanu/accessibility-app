<template>
  <div>
    <div class="contact-info card col" style="padding: 0;">
      <div class="card-header">
        <p>{{contact.first_name}}</p>
      </div>
      <div class="card-body">
        <p>{{contact.email}}</p>
        <p v-if="contact.emergency">{{contact.first_name}} is one of your emergency contacts!</p>
        <p v-else >{{contact.first_name}} isn't an emergency contact.</p>
      </div>
    </div>
    <div class="contact-buttons card col-sm-4" style="display: flex; flex-direction: column; padding: 0;">
      <button @click="addContactToTrip(contact)" style="flex-grow: 1;" class="btn btn-outline-primary round-button">Add</button>
      <button @click="removeContactFromTrip(contact)" style="flex-grow: 1;" class="btn btn-outline-primary round-button">Remove</button>
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
    }
  },
  methods () {

  },
  computed () {

  }
}

</script>
