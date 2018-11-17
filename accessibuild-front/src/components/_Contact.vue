<template>
  <dd v-bind:class="[ contact.emergency ? 'text-danger' : 'text-success' ]">{{ fullName }} - {{ contact.phone_number }} - {{ contact.email }} <button>Update</button><button>Remove</button></dd>
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
