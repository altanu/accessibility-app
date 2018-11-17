<template>
  <div class="w-75 p-5">
    <h1>Right Home</h1>
    <button @click='onClick("SubmitReview")'>Submit review</button>
    <button>Search</button>
    {{ currentPlace }}
  </div>
</template>

<script>
export default {
  props: {
    onClick: Function,
    currentPlace: Object
  },
  name: 'RightHome',
  data () {
    return {

    }
  }
}

</script>
