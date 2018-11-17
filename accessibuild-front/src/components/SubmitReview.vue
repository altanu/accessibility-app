<template>
  <div class="w-100 p-5" style="height: 100%; overflow: scroll;">
    <h1>Submit Review</h1>
    <p>How accessible is this building?</p>
    <section class="d-flex flex-column accessibility-info">
      <section class="picker wheelchair-picker">
        <p>Wheelchair</p>
        <button class="btn btn-success">Fully</button><button class="btn btn-warning">Partially</button><button class="btn btn-danger">Not at all</button>
      </section>
      <section class="picker bathroom-picker">
        <p>Accessible Bathroom</p>
        <button class="btn btn-success">Yes</button><button class="btn btn-danger">No</button>
      </section>
      <section class="picker parking-picker">
        <p>Accessible Parking</p>
        <button class="btn btn-success">Yes</button><button class="btn btn-danger">No</button>
      </section>
      <section class="comment-container">
        <form>
          <label for="comment">Leave a comment:</label>
          <textarea class="form-control" id="comment"></textarea>
          <button class="btn btn-submit" type="submit">Submit</button>
        </form>
      </section>
    </section>
  </div>
</template>
<style type="text/css">
  .picker {
    margin-bottom: 2rem;
  }
</style>
<script>
export default {
  name: 'SubmitReview',
  data () {
    return {

    }
  },
  created () {
    if (!localStorage.signedIn) {
      // this.$router.replace('/home')
    } else {

    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}

</script>
