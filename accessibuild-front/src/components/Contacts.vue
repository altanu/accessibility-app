<template>
  <div>
    <h1>Contacts</h1><hr>
    <ul>
      <li class='card' v-for="contact in contacts" v-bind:key="contact.id">
      {{ contact }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'Contacts',
  data () {
    return {
      contacts: []
    }
  },
  created () {
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}

</script>
