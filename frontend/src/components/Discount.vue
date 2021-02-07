<template>
  <v-lazy>
    <v-card class="ml-2 mr-2 mb-6">
      <v-card-title>Discount: {{ discount.id }}</v-card-title>
      <v-card-subtitle>{{ discount.code }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
        <p><b>Amount left:</b> {{ discount.amount }} st</p>
        <p><b>Required value:</b> {{ discount.required_value }} kr</p>
        <p><b>Created at:</b> {{ discount.created_at }}</p>
        <p>
          <b>Value: </b>
          {{
            (discount.value_in_cash && discount.value_in_cash + " kr") ||
              (discount.value_in_shipping && "Shipping") ||
              (discount.value_in_percent && discount.value_in_percent + "%")
          }}
        </p>
        <v-btn block depressed color="primary" @click="sendDelete()"
          >Delete</v-btn
        >
      </v-card-text>
      <v-card-actions>
        <v-btn
          depressed
          :outlined="seeMore"
          dense
          @click="seeMore = !seeMore"
          color="primary"
          block
          >{{ (seeMore && "See less") || "See more" }}</v-btn
        >
      </v-card-actions>

      <Snackbar
        :snackbar="snackbar"
        :snackbarText="snackbarText"
        @closeSnackbar="snackbar = false"
      />
    </v-card>
  </v-lazy>
</template>

<script>
const axios = require("axios");
import Snackbar from "@/components/Snackbar.vue";
export default {
  name: "Discount",
  props: ["discount"],
  data() {
    return {
      seeMore: false,
      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    sendDelete() {
      let vue = this;
      axios
        .delete(
          `${process.env.VUE_APP_BACKEND}/discount_codes/${vue.discount.id}`
        )
        .then(function(resp) {
          console.log(resp);
          vue.snackbarText = `Discount ${vue.discount.id} was successfully deleted!`;
          vue.$emit("deletedDiscount", vue.discount.id);
        })
        .catch(function(error) {
          console.log(error);
          vue.snackbarText =
            "Something happend and an error occured. Check console for more details";
        });

      this.snackbar = true;
    }
  },

  components: {
    Snackbar
  }
};
</script>

<style></style>
