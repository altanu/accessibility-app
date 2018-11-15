<template>
  <div id="app">
    <Container></Container>
    <router-view/>
    <Footer></Footer>
    <Navbar></Navbar>
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
