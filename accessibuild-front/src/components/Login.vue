<template>

  <div class="w-75 p-5">
  <h1>Login</h1>

  <form v-on:submit.prevent>
    <div class="form-group">
      <input type="text" name="email" placeholder="Email" class="form-control" v-model="email">
    </div>
    <div class="form-group">
      <input type="password" name="password" placeholder="Password" class="form-control" v-model="password">
    </div>
    <button type="submit" class="btn btn-success btn-block">Login</button>
  </form>
</div>
</template>

<script>

  export default {
    name: 'Login',
    data() {
      return {
        email: "",
        password: ""
      }
    }
  }

</script>
