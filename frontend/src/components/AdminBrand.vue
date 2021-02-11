<template>
  <v-card class="mr-2 ml-2 mt-5">
    <v-card-title>{{ brand.name }}</v-card-title>
    <v-card-subtitle>ID: {{ brand.id }}</v-card-subtitle>
    <v-card-text v-if="seeMore">
      <v-text-field
        outlined
        dense
        @input="pendingUpdate = true"
        label="Name"
        v-model="name"
      ></v-text-field>
      <v-textarea
        outlined
        dense
        @input="pendingUpdate = true"
        label="Description"
        v-model="description"
      ></v-textarea>
      <v-btn
        block
        depressed
        color="primary"
        v-if="pendingUpdate"
        class="mb-2"
        @click="update()"
        >Update</v-btn
      >
      <v-btn block depreseed color="primary" @click="deleteAlert = true"
        >Delete</v-btn
      >
      <v-divider class="mt-5 mb-5"></v-divider>
      <p class="brand_info"><b>Created at:</b> {{ brand.created_at }}</p>
      <p class="brand_info"><b>Updated at:</b> {{ brand.updated_at }}</p>
    </v-card-text>
    <v-card-actions>
      <v-btn
        depressed
        block
        :outlined="seeMore"
        color="primary"
        @click="seeMore = !seeMore"
      >
        {{ (!seeMore && "See more") || "See less" }}
      </v-btn>
    </v-card-actions>
    <v-dialog v-model="deleteAlert" width="500">
      <v-card>
        <v-card-title class="primary white--text">Alert</v-card-title>
        <v-card-text>
          <p>
            You are trying to delete a brand. Multiple products will therefore
            have no brand assigned to them. Please select a brand to replace
            them with.
          </p>
          <v-select
            dense
            outlined
            label="Brand"
            v-model="selectedReplaceBrand"
            :items="$store.getters.brands"
            item-text="name"
            item-value="id"
          ></v-select>
          <v-btn
            color="primary"
            :disabled="selectedReplaceBrand == null"
            class="mb-2"
            block
            depressed
            @click="destroy()"
            >Delete</v-btn
          >
          <v-btn
            color="primary"
            block
            outlined
            depressed
            @click="deleteAlert = false"
            >Cancel</v-btn
          >
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
const axios = require("axios");
export default {
  name: "AdminBrand",
  props: ["brand"],

  data() {
    return {
      seeMore: false,
      name: this.brand.name,
      description: this.brand.description,
      pendingUpdate: false,
      deleteAlert: false,
      selectedReplaceBrand: null
    };
  },

  methods: {
    async update() {
      let vue = this;

      axios
        .patch(`${process.env.VUE_APP_BACKEND}/brands/${vue.brand.id}`, {
          brand: {
            name: vue.name,
            description: vue.description
          }
        })
        .then(function(resp) {
          console.log(resp);
          vue.$emit("update", resp.data);
          vue.pendingUpdate = false;
        })
        .catch(function(error) {
          alert(error);
        });
    },

    async destroy() {
      let vue = this;
      axios
        .delete(`${process.env.VUE_APP_BACKEND}/brands/${vue.brand.id}`, {
          params: {
            newId: vue.selectedReplaceBrand
          }
        })
        .then(function(resp) {
          console.log(resp);
          vue.deleteAlert = false;
          vue.$emit("delete", vue.brand);
        })
        .catch(function(error) {
          alert(error);
        });
    }
  },

  created() {
    console.log(this.brand);
  }
};
</script>

<style lang="scss" scoped>
p.brand_info {
  text-align: center;
  margin: 0.5em 0;
}
</style>
