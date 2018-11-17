<template>
  <div id="profile">
    <h3>Profile</h3>
    <p> {{ msg }} </p>

    <dl>
      <dt>Thing</dt>
      <dd>Description of Thing</dd>
      <dt>Thing</dt>
      <dd>Description of Another Thing</dd>
    </dl>
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
