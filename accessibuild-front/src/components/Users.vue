<template>
  <div class="Users">
    <h1>{{ msg }}</h1>

  </div>
</template>

<script>
var axios = require('axios')
export default {
  name: 'Users',
  props: {
    msg: String
  },
  mounted: function () {
    axios.get('http://localhost:3000/users/' + this.$route.params.id + '.json')
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
