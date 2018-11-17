<template>
  <div id="profile">
    <h3>Profile</h3>
    <p> {{ msg }} </p>
    <p> My parent says: {{ userId }}</p>

    <dl>
      <dt>First Name</dt>
      <dd>{{ user.first_name }}</dd>
      <dt>Last Name</dt>
      <dd>{{ user.last_name }}</dd>
      <dt>Email</dt>
      <dd>{{ user.email }}</dd>
    </dl>
  </div>
</template>

<script>

export default {
  name: 'Profile',
  props: {
    userId: Number,
  },
  data () {
    return {
      msg: 'Component loaded!',
      user: {
        first_name: "Test",
        last_name: "Testerson",
        email: "testing@email.com"
      }
    }
  }
}

</script>
