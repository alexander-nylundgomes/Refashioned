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
        <v-carousel-item v-for="(slide, i) in 3" :key="i">
          <v-sheet color="primary" height="100%">
            <v-row class="fill-height" align="center" justify="center">
              <div class="display-3">
                {{ slide }}
              </div>
            </v-row>
          </v-sheet>
        </v-carousel-item>
      </v-carousel>
      <v-progress-linear
        class="progress"
        :value="(current + 1) * 33.33"
      ></v-progress-linear>

      <v-container>
        <v-row align="center">
          <v-col cols="12">
            <h2>{{ product.name }}</h2>
          </v-col>
        </v-row>

        <v-row class="pl-3">
            <h3 v-if="product.old_price" class="old-price">{{ product.old_price }} kr</h3>
            <h3 class="pl-2">{{ product.price }} kr</h3>
        </v-row>

        <v-row>
          <v-col class="">
            <p>{{ product.cat_name }} - {{ product.brands_name }} - {{ product.quality_name }}</p>
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
      snackbarText: ""
    };
  },

  components: {
    ProductContainer
  },

  methods: {
    async setup() {
      this.product = await axios
        .get(`${process.env.VUE_APP_BACKEND}/products/${this.id}`)
        .then(function(resp) {
          console.log(resp.data);
          return resp.data[0];
        })
        .catch(function(error) {
          console.log(error);
        });

      let products = this.$store.getters.products;
      const category_id = this.product.category_id;
      this.relatedProducts = products.filter(p => p.category_id == category_id);
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
    }
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
    console.log(this.product)
  }
};
</script>

<style lang="scss" scoped>
section.padded {
  padding: 5%;
}

.old-price{
  text-decoration: line-through;
  color: red;
}

.progress {
  width: 75%;
  margin: 0 auto;
}
</style>
