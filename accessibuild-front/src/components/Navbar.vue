<template>
  <nav class='navbar fixed-top navbar-light bg-light'>
    <div style="display:flex; flex-direction: column; width: 100%">
      <div style="display: flex; align-content: center; width: 100%">
      </div>

      <div style="display:flex; width: 100%; flex-direction: row; justify-content: space-between">
        <div v-if="$mq === 'lg'" style="flex-grow: 1;">
        <h3 id="logo" style="width:100%; text-align: center">
          <button id="accessibuild" style="width: 7.5rem" @click='sendMeHome'>Accessibl</button>
        </h3>
        </div>
        <div style="flex-grow: 1" id="search-container">
          <input v-on:focus="isFocused" v-on:blur="isFocusedOnMobile = false" id="pac-input" class="form-control" type="text" placeholder="🔍 Search keywords or addresses">
        </div>
        <div v-bind:style="hideButtonsWhileSearchingOnMobile">
          <button v-show="!isLoggedIn" style="width: 7.5rem; padding: 2px;" @click='onClick("Register")' class='btn btn-outline-primary round-button' ref='register' type='submit'>Register</button>
          <button v-show="isLoggedIn" style="width: 7.5rem" @click='onClick("Profile")' class='btn btn-outline-primary round-button' ref='profile' type='submit'>Profile</button>
          <button v-show="!isLoggedIn" style="width: 7.5rem" @click='onClick("Login")' class='btn btn-outline-primary round-button' ref='login' type='submit'>Login</button>

          <button v-show="isLoggedIn" style="width: 7.5rem" @click='setLogin' class='btn btn-outline-primary round-button' type='submit'>Log Out</button>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  props: {
    onClick: Function,
    isLoggedIn: Boolean,
    setLogin: Function
  },
  data () {
    return {
      currentPlace: null,
      isFocusedOnMobile: false
    }
  },
  methods: {
    signOut () {
      this.$http.secured.delete('/sessions')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    },
    isFocused: function () {
      this.isFocusedOnMobile = this.$mq === 'sm'
    },
    sendMeHome() {
      this.$emit('new-list', [])
    }
  },
  computed: {
    hideButtonsWhileSearchingOnMobile: function () {
      if (!this.isFocusedOnMobile) {
        return {
          'flex-grow': 1,
          'display': 'flex',
          'justify-content': 'flex-end'
        }
      } else {
        return {
          'display': 'none'
        }
      }
    }
  }
}
</script>
