<template>
  <div class="w-100 p-5" style="height: 100%; overflow: scroll;">
    <h1>Submit Review</h1>
    <p>How accessible is this building?</p>
      {{location.name}}
      {{location.formatted_address}}
      {{location.wheelchair}}
    <section class="d-flex flex-column accessibility-info">
      <section class="picker wheelchair-picker">
        <p>Wheelchair</p>
        <button @click="savePickerChoice($event)" class="btn btn-success" id="wheel-fully">Fully</button>
        <button @click="savePickerChoice($event)" class="btn btn-warning" id="wheel-partially">Partially</button>
        <button @click="savePickerChoice($event)" class="btn btn-danger" id="wheel-no">Not at all</button>
      </section>
      <section class="picker bathroom-picker">
        <p>Accessible Bathroom</p>
        <button @click="savePickerChoice($event)" class="btn btn-success" id="bath-yes">Yes</button>
        <button @click="savePickerChoice($event)" class="btn btn-danger" id="bath-no">No</button>
      </section>
      <section class="picker parking-picker">
        <p>Accessible Parking</p>
        <button @click="savePickerChoice($event)" class="btn btn-success" id="parking-yes">Yes</button>
        <button @click="savePickerChoice($event)" class="btn btn-danger" id="parking-no">No</button>
      </section>
      <section class="comment-container">
        <form v-on:submit.prevent>
          <label for="comment">Leave a comment:</label>
          <textarea class="form-control" id="comment" v-model="newComment.description"></textarea>
          <star-rating v-model="newComment.rating" v-bind:star-size='25'></star-rating>
          <button class="btn btn-submit" type="submit" @click="saveComment">Submit</button>
        </form>
      </section>
    </section>
    <section>
      <li class="card" v-for="comment in comments">
        <div class="card-header">User: {{ comment.user_id }}</div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">Comment: {{ comment.description }}</li>
          <li class="list-group-item">Rating: {{ comment.rating }} at {{ comment.created_at }}</li>
        </ul>
      </li>
    </section>
  </div>
</template>
<style type="text/css">
  .card {
    margin-top: 1rem;
    margin-bottom: 1rem;
  }
  .picker {
    margin-bottom: 2rem;
  }
  li {
    list-style-type: none;
  }
</style>
<script>
import StarRating from 'vue-star-rating'
var axios = require('axios')
export default {
  name: 'SubmitReview',
  data () {
    return {
      location: store.state.currentLocation,
      baseUrl: 'http://localhost:3000/api/v2/locations/',
      comments: [],
      newComment: {
        user_id: 1,
        location_id: store.state.currentLocation.id,
        description: '',
        rating: 5
      }
    }
  },
  created () {
    this.fetchReviews()
  },
  methods: {
    fetchReviews () {
      axios.get(this.baseUrl + store.state.currentLocation.id + '/reviews')
        .then(response => (this.comments = response.data))
        .catch(error => console.log(error))
    },
    saveComment () {
      axios.post(this.baseUrl + store.state.currentLocation.id + '/reviews', { review: this.newComment })
        .then((response) => console.log(response))
        .catch((error) => console.log(error))
        .then(() => {
          this.emptyComment()
          this.fetchReviews()
        })
    },
    emptyComment () {
      this.newComment.description = ''
    },
    savePickerChoice (event) {
      if (event.target.id[0] === 'w') {
        if (event.target.id === 'wheel-fully') {
          this.wheel_status = 2
        } else if (event.target.id === 'wheel-partially') {
          this.wheel_status = 1
        } else if (event.target.id === 'wheel-no') {
          this.wheel_status = 0
        }
        axios.put(this.baseUrl + this.location.id, { wheelchair: this.wheel_status })
      } else if (event.target.id[0] === 'b') {
        if (event.target.id === 'bath-yes') {
          this.bathroom_status = true
        } else if (event.target.id === 'bath-no') {
          this.bathroom_status = false
        }
        axios.put(this.baseUrl + this.location.id, { bathroom: this.bathroom_status })
      } else if (event.target.id[0] === 'p') {
        if (event.target.id === 'parking-yes') {
          this.parking_status = true
        } else if (event.target.id === 'parking-no') {
          this.parking_status = false
        }
        axios.put(this.baseUrl + this.location.id, { parking: this.parking_status })
      }
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  },
  components: {
    StarRating
  }
}

</script>
