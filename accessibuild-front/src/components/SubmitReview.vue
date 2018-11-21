<template>
  <div class="w-100 p-5" style="height: 100%; overflow: scroll;">
    <button class="btn btn-info" @click="onClick('RightHome')">< Back</button>
    <h1>Submit Review</h1>
    <p>How accessible is this building?</p>
    <p>{{location.name}}</p>
    <p>{{location.formatted_address}}</p>
    <section class="d-flex flex-column accessibility-info">
      <p>Average Rating: {{averageRating}}</p>
      <section class="picker wheelchair-picker">
        <p>Wheelchair Access</p>
        <div class="btn-group">
          <label class="btn btn-radio"for="wheel-fully">
          <input name="wheelchair" type="radio" value="2" v-model.number="location.wheelchair" id="wheel-fully">  Fully
          </label><br>
          <label class="btn btn-radio"for="wheel-partially">
          <input name="wheelchair" type="radio" value="1" v-model.number="location.wheelchair" id="wheel-partially">  Partially
          </label><br>
          <label class="btn btn-radio"for="wheel-no">
          <input name="wheelchair" type="radio" value="0" v-model.number="location.wheelchair" id="wheel-no">  None
          </label><br>
        </div>
      </section>
      <section class="picker bathroom-picker">
        <p>Accessible Bathroom</p>
        <input type="checkbox" id="bathroom-acc" v-model="location.bathroom">
      </section>
      <section class="picker parking-picker">
        <p>Accessible Parking</p>
        <input type="checkbox" id="parking-acc" v-model="location.parking">
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
        <div class="card-header">User: {{ comment.first_name }}</div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">Comment: {{ comment.review.description }}</li>
          <li class="list-group-item"><span v-if="comment.review.rating">Rating: {{ comment.review.rating }}</span>At {{ comment.review.created_at }}</li>
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
      someTestData: null,
      newComment: {
        user_id: 1,
        location_id: store.state.currentLocation.id,
        description: '',
        rating: null
      },
      averageRating: 0
    }
  },
  props: {
    onClick: Function
  },
  created () {
    this.fetchReviews()
  },
  methods: {
    fetchReviews () {
      axios.get(this.baseUrl + store.state.currentLocation.id + '/reviews')
        .then(response => {
          this.comments = response.data
          this.averageRating = Math.round(this.comments.reduce((acc, curr) => {
            return acc + curr.rating / this.comments.length
          }, 0) * 10) / 10
        }).catch(error => console.log(error))
    },
    saveComment () {
      axios.post(this.baseUrl + store.state.currentLocation.id + '/reviews', { review: this.newComment })
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
    },
    putNewData () {
      var locationData = this.location
      console.log('Sending this:' + JSON.stringify(locationData))
      axios.put(this.baseUrl + this.location.id, { location: this.location })
    }
  },
  components: {
    StarRating
  },
  watch: {
    location: {
      handler () {
        this.putNewData()
      },
      deep: true
    }
  }
}

</script>
