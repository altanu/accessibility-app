<template>
  <div class="w-100 p-5" style="height: 100%; overflow: scroll;">
    <h1>Submit Review</h1>
    <p>How accessible is this building?</p>
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
        <form>
          <label for="comment">Leave a comment:</label>
          <textarea class="form-control" id="comment"></textarea>
          <button class="btn btn-submit" type="submit">Submit</button>
        </form>
      </section>
    </section>
    <section>
      <li class="card" v-for="comment in comments">
        <div class="card-header">User: {{ comment.user_id }}</div>
        <ul class="list-group list-group-flush">
          <li class="list-group-item">Comment: {{ comment.description }}</li>
          <li class="list-group-item">Rating: {{ comment.rating }}</li>
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
var axios = require('axios')
export default {
  name: 'SubmitReview',
  data () {
    return {
      testUrl: 'http://localhost:3000/api/v2/locations/1',
      wheel_status: '',
      bathroom_status: '',
      parking_status: '',
      comments: []
    }
  },
  created () {
    axios.get(this.testUrl + '/reviews')
      .then(response => (this.comments = response.data))
      .catch(error => console.log(error))
    axios.get(this.testUrl)
      .then(response => {
        const location = response.data
        this.wheel_status = location.wheelchair
        this.bathroom_status = location.bathroom
        this.parking_status = location.parking
      })
  },
  methods: {
    savePickerChoice (event) {
      if (event.target.id[0] === 'w') {
        if (event.target.id === 'wheel-fully') {
          this.wheel_status = 2
        } else if (event.target.id === 'wheel-partially') {
          this.wheel_status = 1
        } else if (event.target.id === 'wheel-no') {
          this.wheel_status = 0
        }
        axios.put(this.testUrl, { wheelchair: this.wheel_status })
      } else if (event.target.id[0] === 'b') {
        if (event.target.id === 'bath-yes') {
          this.bathroom_status = true
        } else if (event.target.id === 'bath-no') {
          this.bathroom_status = false
        }
        axios.put(this.testUrl, { bathroom: this.bathroom_status })
      } else if (event.target.id[0] === 'p') {
        if (event.target.id === 'parking-yes') {
          this.parking_status = true
        } else if (event.target.id === 'parking-no') {
          this.parking_status = false
        }
        axios.put(this.testUrl, { parking: this.parking_status })
      }
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}

</script>
