<template>
  <v-lazy>
    <v-card class="ml-2 mr-2 mb-6">
      <v-card-title>Order: {{ order.id }}</v-card-title>
      <v-card-subtitle>{{ order.city }} - {{ order.address }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
        <p><b>Address:</b> {{ order.address }}</p>
        <p><b>City:</b> {{ order.city }}</p>
        <p><b>Postal code:</b> {{ order.postal }}</p>
        <p><b>Firstname: </b> {{ order.firstname }}</p>
        <p><b>Lastname: </b> {{ order.lastname }}</p>
        <p><b>Email: </b> {{ order.email }}</p>
        <p><b>Phone number: </b> {{ order.phone }}</p>
        <p>
          <b>Shipping cost: </b>
          {{ order.shipping_cost + " kr" || "Did not pay for shipping" }}
        </p>
        <p><b>Order value: </b> {{ order.value }} kr</p>
        <p>
          <b>Discount ID: </b>
          {{ order.discount_id || "Did not have discount" }}
        </p>
        <p><b>Timestamp: </b> {{ order.created_at }}</p>
        <p><b>Tracking number: </b> {{ order.tracking }}</p>
        <div v-for="product of products" :key="product.id">
          <v-divider class="pt-3 pb-1"></v-divider>
          <p><b>Product ID:</b> {{ product.id }}</p>
          <p><b>Name:</b> {{ product.name }}</p>
          <p><b>Price:</b> {{ product.price }} kr</p>
          <p><b>Description:</b> {{ product.description }}</p>
          <p><b>Brand:</b> {{ product.brands_name }}</p>
          <p><b>Category:</b> {{ product.cat_name }}</p>
          <p><b>Quality:</b> {{ product.quality_name }}</p>
          <p><b>Size:</b> {{ product.size }}</p>
        </div>

        <v-btn
          depressed
          color="primary"
          @click="getProducts()"
          v-if="products.length == 0"
          block
          class="mt-3 mb-5"
          >Load products</v-btn
        >
        <v-select
          label="Status"
          hide-details
          class="pb-4"
          outlined
          dense
          v-model="status"
          @change="updatePending = true"
          :items="statuses"
        ></v-select>
        <v-text-field
          dense
          outlined
          hide-details
          class="pb-4"
          @input="updatePending = true"
          v-model="tracking"
          label="Tracking"
        ></v-text-field>
        <v-btn
          block
          color="primary"
          v-if="updatePending"
          @click="updateStatus()"
          >Update</v-btn
        >
      </v-card-text>
      <v-card-actions>
        <v-btn
          depressed
          block
          v-if="!seeMore"
          @click="seeMore = !seeMore"
          color="primary"
          >See more</v-btn
        >
        <v-btn
          depressed
          block
          outlined
          v-if="seeMore"
          @click="seeMore = !seeMore"
          color="primary"
          >See less</v-btn
        >
      </v-card-actions>
      <v-snackbar v-model="snackbar">
        {{ snackbarText }}
        <template v-slot:action="{ attrs }">
          <v-btn
            color="white"
            text
            v-bind="attrs"
            @click="snackbar = false"
            :class="{ 'changed-button-alert': $vuetify.breakpoint.xs }"
          >
            Close
          </v-btn>
        </template>
      </v-snackbar>
    </v-card>
  </v-lazy>
</template>

<script>
const axios = require("axios");

export default {
  name: "Order",
  data() {
    return {
      seeMore: false,
      statuses: ["sent", "recieved", "problem"],
      updatePending: false,
      status: this.order.status,
      products: [],
      snackbar: false,
      snackbarText: "",
      tracking: this.order.tracking
    };
  },
  props: ["order"],

  methods: {
    async getProducts() {
      let vue = this;

      axios
        .get(
          `${process.env.VUE_APP_BACKEND}/admin/orders/get_products/${vue.order.id}`
        )
        .then(function(resp) {
          vue.products = resp.data;
          console.log(resp);
        })
        .catch(function(error) {
          alert(error);
        });
    },

    async updateStatus() {
      let vue = this;
      axios
        .patch(`${process.env.VUE_APP_BACKEND}/orders/${vue.order.id}`, {
          order: {
            status: vue.status,
            tracking: vue.tracking
          }
        })
        .then(function(resp) {
          console.log(resp.data);
          vue.snackbarText = `Order with ID ${vue.order.id} was successfully updated!`;
          vue.updatePending = false;
        })
        .catch(function(error) {
          console.log(error);
          vue.snackbarText = `Order with ID ${vue.order.id} was not updated. A problem occured. Check log for details.`;
        });

      this.snackbar = true;
    }
  }
};
</script>

<style lang="scss" scoped></style>
