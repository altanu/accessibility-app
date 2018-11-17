<template>
  <dd v-bind:class="[ contactInfo.emergency ? 'text-danger' : 'text-success' ]">{{ fullName }} - {{ contactInfo.phone_number }} - {{ contactInfo.email }} <button @click='setForm'>Update</button><button>Remove</button></dd>
</template>

<script>

export default {
  name: 'Contact',
  props: {
    contact: Object
  },
  data () {
    return {
      isForm: false,
      contactInfo: this.contact
    }
  },
  computed: {
    fullName: function() {
      return this.contactInfo.first_name + ' ' + this.contactInfo.last_name
    }
  },
  methods: {
    setForm: function () {
      this.isForm = !this.isForm
    },
    setState: function () {
      this.contactInfo = this.contact
    }
  }
}

</script>
