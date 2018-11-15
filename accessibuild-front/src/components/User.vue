<template>
  <div class="User">
    <h1> This is a specific user! </h1>
    <h2>{{ msg }}</h2>
  </div>
</template>

<script>
var axios = require('axios')
export default {
  name: 'User',
  props: {
    msg: String
  },
  mounted: function () {
    axios.get('http://localhost:3000/users/' + this.$route.params.id)
      .then(response => (this.msg = response.data))
      .catch(error => console.log(error))
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
