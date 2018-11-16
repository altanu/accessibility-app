<template>
  <div class="w-75 p-5">
    <h1>Right Home</h1>
    <button>Submit review</button>
    <button>Search</button>
    {{ currentPlace }}
  </div>
</template>

<script>
export default {
  props: {
    currentPlace: Object
  },
  name: 'RightHome',
  data () {
    return {

    }
  }
}

</script>
