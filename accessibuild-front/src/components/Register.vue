<template>

  <div class="w-75 p-5">
  <h1>Welcome to the Login Page!</h1>

  <form>
    <div class="form-group">
      <label>First Name</label>
      <input type="text" name="first_name" class="form-control">
    </div>
    <div class="form-group">
      <label>Last Name</label>
      <input type="text" name="last_name" class="form-control">
    </div>
    <div class="form-group">
      <label>Email</label>
      <input type="text" name="email" class="form-control">
    </div>
    <div class="form-group">
      <label>Password</label>
      <input type="password" name="password" class="form-control">
    </div>
    <div class="form-group">
      <label>Password Confirmation</label>
      <input type="password" name="password_confirmation" class="form-control">
    </div>
    <button type="submit" class="btn btn-success btn-block">Register</button>
  </form>
</div>
</template>

<script>

  export default {
    name: 'Register',
    data() {
      return {}
    }
  }

</script>
