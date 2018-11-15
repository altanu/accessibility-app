<template>
  <div id="app">
    <Navbar></Navbar>
    <Container></Container>
    <router-view/>
    <Footer></Footer>
  </div>
</template>

<script>
import Navbar from './components/Navbar'
import Container from './components/Container.vue'
import Footer from './components/Footer.vue'
export default {
  name: 'Users',
  props: {
    msg: String
  },
  components: {
    Container,
    Footer,
    Navbar
  }
}
</script>
