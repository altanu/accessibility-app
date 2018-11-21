<template>
  <button class="btn btn-info" v-on:click="goHome"> < Back</button>
</template>

<script>

  export default {
    name: "BackButton",
    props: {
      goHome: Function
    }
  }

</script>
