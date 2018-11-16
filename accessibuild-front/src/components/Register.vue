<template>

  <div class="w-75 p-5">
  <h1>Welcome to the Login Page!</h1>

  <form v-on:submit.prevent="onSubmit">
    <div class="form-group">
      <label>First Name</label>
      <input type="text" name="first_name" class="form-control" v-model="first_name">
    </div>
    <div class="form-group">
      <label>Last Name</label>
      <input type="text" name="last_name" class="form-control" v-model="last_name">
    </div>
    <div class="form-group">
      <label>Email</label>
      <input type="text" name="email" class="form-control" v-model="email">
    </div>
    <div class="form-group">
      <label>Password</label>
      <input type="password" name="password" class="form-control" v-model="password">
    </div>
    <div class="form-group">
      <label>Password Confirmation</label>
      <input type="password" name="password_confirmation" class="form-control" v-model="password_confirmation">
    </div>
    <button type="submit" class="btn btn-success btn-block">Register</button>
  </form>
</div>
</template>

<script>

export default {
  name: 'Register',
  data () {
    return {
      form: {
        first_name: '',
        last_name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  }
}

</script>
