<template>
  <div id="app">
    <div id="nav">
      <router-link to="/users">Users</router-link> |
      <router-link to="/locations">Locations</router-link>
    </div>
    <router-view/>
    <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin: 0 30% 0">
      With Bootstrap!
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  </div>
</template>
