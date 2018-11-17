<template>
  <div id="profile">
    <h3>Profile</h3>
    <p> {{ msg }} </p>
  </div>
</template>

<script>

export default {
  name: 'Profile',
  data () {
    return {
      msg: 'Component loaded!'
    }
  }
}

</script>
