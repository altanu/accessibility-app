<template>
  <div id="app">
    <div id="nav">
      <router-link to="/users">Users</router-link> |
      <router-link to="/locations">Locations</router-link> |
      <Container></Container>
    </div>
    <router-view/>
    <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin: 0 30% 0">
      With Bootstrap!
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    <Footer></Footer>
  </div>

</template>
<script>
import Container from './components/Container.vue'
import Footer from './components/Footer.vue'
export default {
  name: 'Users',
  props: {
    msg: String
  },
  components: {
    Container,
    Footer
  }
}
</script>
