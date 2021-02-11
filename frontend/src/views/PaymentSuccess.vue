<template>
  <main class="payment-success">
    <div class="success-text">
      <h1>Wohoo!</h1>
      <p>
        The order was placed and your awesome new clothing should be with you in
        a couple of days! You will recieve your reciept shortly in an email.
        When the order is shipped, you will receive your tracking number in an
        email as well.
      </p>

      <div class="button-wrapper">
        <v-btn
          depressed
          color="primary"
          @click="$router.push('/')"
          class="accept-button"
          block
          >Awesome!</v-btn
        >
        <v-btn
          depressed
          color="primary"
          @click="runConfetti()"
          outlined
          class="mt-3"
          block
          >Celebrate again!</v-btn
        >
        <div ref="confetti1" class="confetti"></div>
        <div ref="confetti2" class="confetti"></div>
      </div>
    </div>
  </main>
</template>

<script>
import { confetti } from "dom-confetti";

export default {
  name: "PaymentSuccess",
  methods: {
    runConfetti() {
      confetti(this.$refs.confetti1, {
        angle: 75
      });
      confetti(this.$refs.confetti2, {
        angle: 105
      });
    }
  },

  mounted: function() {
    this.runConfetti();
  }
};
</script>

<style lang="scss" scoped>
.success-text {
  width: 100%;
  margin: 2em auto;
  h1,
  p {
    text-align: center;
  }

  h1 {
    font-size: 3em;
  }

  p {
    width: 85%;
    margin: 0 auto;
    font-size: 0.85em;
  }

  .button-wrapper {
    width: 75%;
    margin: 3em auto;
  }

  .confetti {
    width: 10px;
    height: 10px;
    margin: 1em auto;
    position: absolute;
    bottom: 35%;

    &:nth-of-type(1) {
      // background-color: red;
      left: 5%;
    }

    &:nth-of-type(2) {
      // background-color: blue;
      right: 5%;
    }
  }
}
</style>
