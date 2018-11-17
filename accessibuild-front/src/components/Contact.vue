<template>
  <dd>{{ fullName }} - {{ contact.phone_number }} - {{ contact.email }} </dd>
</template>

<script>

export default {
  name: 'Contact',
  props: {
    contact: Object
  },
  data () {
    return {
      nothing: 'Nothing'
    }
  },
  computed: {
    fullName: function() {
      return this.contact.first_name + ' ' + this.contact.last_name
    }
  }
}

</script>
