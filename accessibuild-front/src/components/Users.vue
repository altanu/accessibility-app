<template>
  <div class="Users">
    <h1>Welcome, {{ user.first_name }}</h1>
  </div>
</template>

<script>
var axios = require('axios')
export default {
  name: 'Users',
  data () {
    return {
      user: null,
    }
  },
  mounted: function () {
    var userId = this.$route.params.id
      axios.get('http://localhost:3000/users/' + userId + '.json')
        .then(response => (this.user = response.data))
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
