<template>
  <main class="product" v-if="product != []">
    <section class="padded">
      <v-carousel
        class="carousel-images"
        cycle
        height="400"
        hide-delimiter-background
        hide-delimiters
        show-arrows-on-hover
        v-model="current"
      >
        <v-carousel-item v-for="img of product_imgs" :key="img.id">
          <v-img height="400" :src="img.path"></v-img>
        </v-carousel-item>
      </v-carousel>
      <v-progress-linear
        class="progress mt-2"
        :value="(current + 1) * (100 / product_imgs.length )"
      ></v-progress-linear>

      <v-container>
        <v-row align="center">
          <v-col cols="12">
            <h2>{{ product.name }}</h2>
          </v-col>
        </v-row>

        <v-row class="pl-3">
          <h3 v-if="product.old_price" class="old-price">
            {{ product.old_price }} kr
          </h3>
          <h3 :class="{'pl-2' : product.old_price}">{{ product.price }} kr</h3>
        </v-row>

        <v-row>
          <v-col class="">
            <p>
              Size: {{ product.size }} - {{ product.brands_name }} -
              {{ product.quality_name }}
            </p>
          </v-col>
        </v-row>

        <v-row>
          <v-col>
            <p>{{ product.desc }}</p>
          </v-col>
        </v-row>

        <v-row>
          <v-col cols="8" class="pr-0">
            <v-btn
              depressed
              color="primary"
              dark
              block
              @click="cartAction()"
              v-if="!inCart"
              >Add to cart</v-btn
            >
            <v-btn
              depressed
              color="primary"
              outlined
              dark
              block
              @click="cartAction()"
              v-if="inCart"
              >Remove from cart</v-btn
            >
          </v-col>
          <v-col cols="4" class="pl-0" block align="end">
            <v-btn depressed color="rgb(240,240,240)" @click="likeAction()">
              <v-icon color="#EF6B6F" v-if="isLiked">mdi-heart</v-icon>
              <v-icon color="#EF6B6F" v-if="!isLiked">mdi-heart-outline</v-icon>
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </section>
    <ProductContainer :products="relatedProducts" />

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
  </main>
</template>

<script>
const axios = require("axios");

import ProductContainer from "@/components/ProductContainer.vue";

export default {
  name: "ProductView",
  props: ["id"],

  data() {
    return {
      current: 0,
      product: [],
      chips: [
        { text: "Pants", id: 1 },
        { text: "Red", id: 2 },
        { text: "Fitting", id: 3 },
        { text: "Loose fit", id: 4 },
        { text: "Something", id: 5 },
        { text: "Something else", id: 6 }
      ],
      relatedProducts: [],
      snackbar: false,
      snackbarText: "",
      product_imgs: []
    };
  },

  components: {
    ProductContainer
  },

  methods: {
    async setup() {
      let vue = this;
      axios
        .get(`${process.env.VUE_APP_BACKEND}/products/${this.id}`)
        .then(function(resp) {
          console.log(resp.data)
          // Sets product
          vue.product = resp.data.product[0];

          // Sets product images
          vue.product_imgs = resp.data.product_imgs

          // Sets related products
          let products = vue.$store.getters.products;
          vue.relatedProducts = products.filter(p => p.category_id == vue.product.category_id);
        })
        .catch(function(error) {
          console.log(error);
        });
    },

    likeAction() {
      if (this.isLiked) {
        this.snackbarText = `${this.product.name} was unliked!`;
      } else {
        this.snackbarText = `${this.product.name} was liked!`;
      }

      this.snackbar = true;
      this.$store.dispatch("likeAction", this.product);
    },

    cartAction() {
      this.$store.dispatch("cartAction", this.product);
    },
  },

  computed: {
    isLiked() {
      let isLiked = false;
      for (let d of this.$store.getters.likes) {
        if (d.id == this.product.id) {
          isLiked = true;
          break;
        }
      }

      return isLiked;
    },

    inCart() {
      let inCart = false;
      for (let d of this.$store.getters.cart) {
        if (d.id == this.product.id) {
          inCart = true;
          break;
        }
      }
      return inCart;
    }
  },

  created() {
    this.setup();
  }
};
</script>

<style lang="scss" scoped>
section.padded {
  padding: 5%;
}

.old-price {
  text-decoration: line-through;
  color: red;
}

.progress {
  width: 75%;
  margin: 0 auto;
}
</style>
