<template>
  <main class="cart">
    <TitleCardProducts
      :name="'Your cart'"
      :amount="products.length"
      :all="products.length"
    />
    <ProductContainer :products="products" />

    <v-container>
      <v-row justify="center" align="center">
        <v-col class="pr-0" cols="9">
          <v-text-field
            v-model="discount_code"
            hide-details
            outlined
            clearable
            dense
            label="Discount code"
            :disabled="discount"
          ></v-text-field>
        </v-col>
        <v-col class="pl-0" cols="3" align="end">
          <v-btn color="primary" @click="getDiscount()" dark depressed>+</v-btn>
        </v-col>
      </v-row>

      <v-row>
        <v-col>
          <v-alert v-if="discount" type="success" dense>
            Discount: {{ refactorDiscountValue }}
          </v-alert>
        </v-col>
      </v-row>

      <v-row class="mt-3">
        <v-col>
          <v-btn
            large
            color="primary"
            @click="validateStock()"
            dark
            depressed
            block
            >Begin payment - {{ collectedPrice - discount_sum }} kr</v-btn
          >
        </v-col>
      </v-row>
    </v-container>

    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-title
          class="primary white--text"
          :class="{ 'changed-title': $vuetify.breakpoint.xs }"
        >
          {{ missingItems.length }} items are missing ...
        </v-card-title>

        <v-card-text class="pt-2">
          <p>
            Sadly, it seems like {{ missingItems.length }} items are not
            available anymore in our store. Someone else seems to have bought
            them. These items are:
          </p>
          <p v-for="item of missingItems" :key="item.id">{{ item.name }}</p>
          <p>The items have now been removed from your cart.</p>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" text @click="dialog = false">
            I understand
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

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
import ProductContainer from "@/components/ProductContainer.vue";
import TitleCardProducts from "@/components/TitleCardProducts";
const axios = require("axios");

export default {
  name: "Cart",

  data() {
    return {
      dialog: false,
      missingItems: [],
      discount_code: "",
      snackbarText: "",
      snackbar: false,
      discount: false,
      discount_value: {},
      discount_sum: 0
    };
  },

  methods: {
    async validateStock() {
      let arrayOfIds = this.products.map(p => p.id);
      let arrayOfNames = this.products.map(p => p.name);

      let inStock = await axios
        .get(`${process.env.VUE_APP_BACKEND}/validate_stock`, {
          params: { products_id: arrayOfIds, products_name: arrayOfNames }
        })
        .then(function(resp) {
          return resp.data;
        })
        .catch(function(error) {
          alert(error);
          console.log(error.text);
        });

      console.log(inStock);

      if (inStock.length == this.products.length) {
        this.$store.commit("finalCartInsertion", [
          { discount: this.discount_code },
          { products: arrayOfIds }
        ]);
        this.$router.push("cart/info");
      } else {
        let stockIds = inStock.map(p => p.id);

        var difference = arrayOfIds.filter(x => stockIds.indexOf(x) === -1);
        let soldItems = [];

        for (let p of this.products) {
          if (difference.includes(p.id)) {
            soldItems.push(p);
          }
        }

        this.missingItems = soldItems;
        this.dialog = true;

        for (let item of this.missingItems) {
          this.$store.commit("removeFromCart", item);
        }
      }
    },

    async getDiscount() {
      const collectedPrice = this.collectedPrice;
      let snackbarText = "";
      let vue = this;

      this.snackbarText = await axios
        .post(`${process.env.VUE_APP_BACKEND}/validate_discount`, {
          code: this.discount_code
        })
        .then(function(resp) {
          console.log(resp.data);
          if (resp.data.length == 0) {
            snackbarText = "No discount found. Have you spelled it correctly?";
          } else if (resp.data[0].required_value > collectedPrice) {
            snackbarText = `We're very sorry but the discount is only for purchases larger or equal to ${resp.data[0].required_value} kr.`;
          } else if (
            resp.data != [] &&
            resp.data[0].required_value <= collectedPrice
          ) {
            snackbarText =
              "We found you a discount! The discount will be registered when you pay.";

            if (resp.data[0].value_in_cash) {
              vue.discount_value = {
                type: "cash",
                value: resp.data[0].value_in_cash
              };

              vue.discount_sum = resp.data[0].value_in_cash;
            } else if (resp.data[0].value_in_percent) {
              vue.discount_value = {
                type: "percent",
                value: resp.data[0].value_in_percent
              };

              vue.discount_sum =
                collectedPrice * (resp.data[0].value_in_percent / 100);
            } else if (resp.data[0].value_in_shipping) {
              vue.discount_value = {
                type: "shipping",
                value: resp.data[0].value_in_shipping
              };
            }

            vue.discount = true;

            console.log(vue.discount_value);
          }

          return snackbarText;
        })
        .catch(function(error) {
          console.log(error);
        });

      this.snackbar = true;
    }
  },
  computed: {
    products() {
      return this.$store.getters.cart;
    },

    collectedPrice() {
      return this.products.reduce((a, b) => a + b.price, 0);
    },

    refactorDiscountValue() {
      var text;

      switch (this.discount_value.type) {
        case "cash":
          text = `${this.discount_value.value} kr`;
          break;
        case "percent":
          text = `${this.discount_value.value}%`;
          break;
        case "shipping":
          text = `Free shipping`;
          break;
      }

      return text;
    }
  },
  components: {
    ProductContainer,
    TitleCardProducts
  }
};
</script>

<style lang="scss" scoped></style>
