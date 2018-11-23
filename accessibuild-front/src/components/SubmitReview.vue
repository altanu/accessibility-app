<template>
  <div id="submit-review" style="height: 100%; overflow: scroll;">
    <button id="pointer" class="btn btn-outline-primary btn-block" @click="onClick('RightHome')">Back to Search Results</button>
    <div class="card">
    <h5 class="card-header">{{location.formatted_address}}</h5>
    <div class="card-body">
      <section class="container">
        <div class="row">
          <div class="col">
            <p><strong>Accessibility Rating:</strong></p>
          </div>
          <div class="col">
            <p>{{averageRating}}</p>
          </div>
        </div>
        <section class="picker wheelchair-picker">
          <div class="row">
            <div class="col">
              <p><strong>Wheelchair Access:</strong></p>
            </div>
            <div class="col">
              <div class="btn-group">
                <label class="btn btn-radio" for="wheel-fully" style="border-right: none">
                <input name="wheelchair" type="radio" value="2" v-model.number="location.wheelchair" id="wheel-fully">  Full
                </label><br>
                <label class="btn btn-radio" for="wheel-partially" style="border-right: none">
                <input name="wheelchair" type="radio" value="1" v-model.number="location.wheelchair" id="wheel-partially">  Partial
                </label><br>
                <label class="btn btn-radio" for="wheel-no" style="border-top-right-radius: 0.25rem; border-bottom-right-radius: 0.25rem">
                <input name="wheelchair" type="radio" value="0" v-model.number="location.wheelchair" id="wheel-no">  None
                </label><br>
              </div>
            </div>
          </div>
        </section>
        <div class="row">
          <div class="col">
           <p><strong>Accessible Bathroom:</strong></p>
          </div>
          <div class="col">
            <input type="checkbox" id="bathroom-acc" v-model="location.bathroom">
          </div>
       </div>
        <div class="row">
          <div class="col">
            <p><strong>Parking Available:</strong></p>
          </div>
          <div class="col">
            <input type="checkbox" id="parking-acc" v-model="location.parking">
          </div>
        </div>
        <hr>
        <section class="comment-container">
          <form v-on:submit.prevent>
            <label for="comment">Do you know this place? Leave a comment and rating on how accessible it is!</label>
            <textarea class="form-control" id="comment" v-model="newComment.description"></textarea>
            <star-rating style="margin: auto" v-model="newComment.rating" v-bind:star-size='25'></star-rating>
            <button class="btn btn-success btn-block" style="margin-top: 5px" type="submit" @click="saveComment">Submit your review</button>
          </form>
        </section>
      </section>
    </div>
  </div>
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
      averageRating: null
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
          this.setAverageRating()
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
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    putNewData () {
      var locationData = this.location
      axios.put(this.baseUrl + this.location.id, { location: this.location })
    },
    setAverageRating () {
      var totalRating = 0
      this.comments.forEach(function (comment) {
        totalRating += comment.review.rating
      })
      var average = totalRating / this.comments.length
      this.averageRating = !average && average !== 0 ? 'No ratings yet!' : average.toFixed(1)
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
