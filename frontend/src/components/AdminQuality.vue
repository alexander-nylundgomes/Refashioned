<template>
  <v-card class="mr-2 ml-2 mt-5 quality-card">
    <v-card-title>{{ quality.name }} - {{ quality.id }}</v-card-title>
    <v-card-subtitle>Grade {{ quality.grade }}</v-card-subtitle>
    <v-card-text v-if="seeMore">
      <v-text-field
        dense
        outlined
        @input="updatePending = true"
        label="Grade"
        v-model="grade"
      ></v-text-field>
      <v-text-field
        dense
        outlined
        @input="updatePending = true"
        label="Name"
        v-model="name"
      ></v-text-field>
      <v-btn
        color="primary"
        class="mb-2"
        v-if="updatePending"
        block
        depressed
        @click="update()"
        >Update</v-btn
      >
      <p><b>Created at:</b> {{ quality.created_at }}</p>
      <p><b>Updated at:</b> {{ quality.updated_at }}</p>
      <v-divider class="mb-5 mt-5"></v-divider>
      <v-checkbox
        label="Do you want to delete this quality?"
        v-model="accessDelete"
      ></v-checkbox>
      <v-btn
        color="primary"
        class="mb-2"
        :disabled="!accessDelete"
        block
        depressed
        @click="destroy()"
        >Delete</v-btn
      >
    </v-card-text>
    <v-card-actions>
      <v-btn
        depressed
        color="primary"
        :outlined="seeMore"
        block
        @click="seeMore = !seeMore"
        >{{ (!seeMore && "See more") || "See less" }}</v-btn
      >
    </v-card-actions>
  </v-card>
</template>

<script>
const axios = require("axios");

export default {
  name: "AdminQuality",
  props: ["quality"],

  data() {
    return {
      seeMore: false,
      updatePending: false,
      accessDelete: false,

      snackbar: false,
      snackbarText: "",

      name: this.quality.name,
      grade: this.quality.grade
    };
  },

  methods: {
    async update() {
      let vue = this;
      axios
        .patch(`${process.env.VUE_APP_BACKEND}/qualities/${vue.quality.id}`, {
          quality: {
            name: vue.name,
            grade: vue.grade
          }
        })
        .then(function(resp) {
          vue.updatePending = false;
          vue.$emit("update", resp.data);
        })
        .catch(function(error) {
          console.log(error);
        });
    },

    async destroy() {
      let vue = this;
      axios
        .delete(`${process.env.VUE_APP_BACKEND}/qualities/${vue.quality.id}`)
        .then(function() {
          vue.$emit("destroy", vue.quality.id);
        })
        .catch(function(error) {
          console.log(error);
          vue.snackbarText = "Something went wrong. Check console for details.";
        });
    }
  }
};
</script>

<style lang="scss" scoped>
.quality-card {
  p {
    text-align: center;
    margin: 0;
  }
}
</style>
