<template>
  <v-card class="mt-5 mr-2 ml-2">
    <v-card-title>{{ misc.name }}</v-card-title>
    <v-card-subtitle>ID: {{ misc.id }}</v-card-subtitle>
    <v-card-text v-if="seeMore">
      <v-text-field
        dense
        outlined
        v-model="value"
        @input="updatePending = true"
        label="Value"
      ></v-text-field>
      <v-btn
        color="primary"
        block
        depressed
        class="mb-4"
        v-if="updatePending"
        @click="update()"
        >Update</v-btn
      >
      <p><b>Created at:</b> {{ misc.created_at }}</p>
      <p><b>Updated at:</b> {{ misc.updated_at }}</p>
    </v-card-text>
    <v-card-actions>
      <v-btn
        depressed
        :outlined="seeMore"
        color="primary"
        @click="seeMore = !seeMore"
        block
        >{{ (!seeMore && "See more") || "See less" }}</v-btn
      >
    </v-card-actions>
    <Snackbar
      :snackbar="snackbar"
      :snackbarText="snackbarText"
      @closeSnackbar="snackbar = false"
    />
  </v-card>
</template>

<script>
import Snackbar from "@/components/Snackbar.vue";
const axios = require("axios");
export default {
  name: "AdminMisc",
  props: ["misc"],

  data() {
    return {
      seeMore: false,
      updatePending: false,
      value: this.misc.value,
      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    async update() {
      let vue = this;

      axios
        .patch(`${process.env.VUE_APP_BACKEND}/miscs/${vue.misc.id}`, {
          misc: {
            value: parseInt(vue.value)
          }
        })
        .then(function(resp) {
          console.log(resp);
          vue.snackbarText = "Misc was updated successfully!";
          // show accept message
        })
        .catch(function(error) {
          console.log(error);
          vue.snackbarText = "Something went wrong. Check logs for details.";
        });

      vue.snackbar = true;
    }
  },

  components: {
    Snackbar
  }
};
</script>

<style lang="scss" scoped>
p {
  text-align: center;
  margin: 0.5em 0;
}
</style>
