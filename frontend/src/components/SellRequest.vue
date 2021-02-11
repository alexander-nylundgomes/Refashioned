<template>
  <v-lazy>
    <v-card class="mr-2 ml-2 mb-6 mt-2">
      <v-card-title>Sell request: {{ sr.id }}</v-card-title>
      <v-card-subtitle>{{ sr.brand }} - {{ sr.condition }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
        <p><b>Firstname:</b> {{ sr.firstname }}</p>
        <p><b>Lastname:</b> {{ sr.lastname }}</p>
        <p><b>Email: </b> {{ sr.email }} kr</p>
        <p><b>Phone number: </b> {{ sr.phone }} kr</p>
        <p><b>Sent in: </b> {{ sr.created_at }} kr</p>
        <p><b>Asking price:</b> {{ sr.asking_price }} kr</p>
        <p><b>Status:</b> {{ sr.status || "No status" }}</p>
        <v-img lazy :src="sr.file_path" class="image"></v-img>
        <v-select
          dense
          outlined
          hide-details
          @change="pendingUpdates = true"
          v-model="currentStatus"
          class="mt-4 mb-2"
          label="Status"
          :items="statuses"
        ></v-select>
        <v-btn
          color="primary"
          depressed
          block
          @click="update()"
          v-if="pendingUpdates"
          >Update</v-btn
        >
      </v-card-text>
      <v-card-actions>
        <v-btn
          depressed
          color="primary"
          v-if="!seeMore"
          @click="seeMore = true"
          block
          >See more</v-btn
        >
        <v-btn
          depressed
          color="primary"
          v-if="seeMore"
          @click="seeMore = false"
          outlined
          block
          >See less</v-btn
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
  name: "SellRequest",
  props: ["sr"],
  data() {
    return {
      seeMore: false,
      statuses: ["Rejected", "Bought", "Accepted"],
      currentStatus: this.sr.status,
      pendingUpdates: false,
      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    async update() {
      let vue = this;
      axios
        .patch(`${process.env.VUE_APP_BACKEND}/sell_requests/${vue.sr.id}`, {
          sell_request: {
            status: vue.currentStatus
          }
        })
        .then(function(resp) {
          console.log(resp);
          vue.snackbarText = `Sell request ${vue.sr.id} was successfully updated!`;
          vue.snackbar = true;
          vue.sr.status = vue.currentStatus;
          vue.$emit("updated");
        })
        .catch(function(error) {
          alert(error);
        });
    }
  },

  components: {
    Snackbar
  }
};
</script>

<style lang="scss" scoped>
.image {
  width: 100%;
}
</style>
