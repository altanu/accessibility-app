<template>
  <div class="w-75 p-5">
    <h1>Contacts</h1>
    <ul>
      <li v-for="contact in contacts" v-bind:key="contact.id">
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
