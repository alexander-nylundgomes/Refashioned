<template>
  <v-lazy width="200" class="product-card  ml-1 mr-1">
    <v-card  elevation="0" lazy @click="$router.push('/product/' + product.id)">
      <div class="img-replace">
        <v-btn @click="likeAction()" icon class="mt-1 mr-1">
          <v-icon v-if="!isLiked" color="#EF6B6F">mdi-heart-outline</v-icon>
          <v-icon v-if="isLiked" color="#EF6B6F">mdi-heart</v-icon>
        </v-btn>
      </div>
      <v-card-title
        class="pa-1 pl-2 pr-2"
        :class="{ 'changed-product-title': $vuetify.breakpoint.xs }"
      >
        <v-container>
          <v-row>
            <v-col class="pa-0 pb-2">
              <p
                class="ma-0 limited-p"
                :class="{ 'changed-product-title': $vuetify.breakpoint.xs }"
              >
                {{ refactor(product.name, 21) }}
              </p>
            </v-col>
          </v-row>

          <v-row>
            <v-col class="pa-0">
              <div class="price-wrapper">
                <p class="ma-0 mr-2 price" v-if="product.old_price " :class="{ 'changed-product-title': $vuetify.breakpoint.xs, 'discounted': product.old_price  }">
                  {{ product.old_price }} kr
                </p>
                <p class="ma-0 price" :class="{ 'changed-product-title': $vuetify.breakpoint.xs}">
                  {{ product.price }} kr - Size: {{ product.size }}
                </p>
              </div>
            </v-col>
          </v-row>
        </v-container>

      </v-card-title>
      <v-card-subtitle
        class="pa-1 pl-2 pr-2"
        :class="{ 'changed-subtitle': $vuetify.breakpoint.xs }"
      >
        {{ product.brand }}
      </v-card-subtitle>
      <v-card-text
      class="pl-2 pr-2 pt-1"
      :class="{ 'changed-product-text': $vuetify.breakpoint.xs }"
      >
      {{product.brands_name}} - {{ product.cat_name }}
      </v-card-text>

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
export default {
  name: "Product",
  props: ["product"],
  data() {
    return {
      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    refactor(text, number) {
      let refactoredText = text.substring(0, number);
      if (refactoredText != text) {
        return refactoredText + "...";
      } else {
        return refactoredText;
      }
    },

    likeAction() {
      if (this.isLiked) {
        this.snackbarText = `${this.product.name} was unliked!`;
      } else {
        this.snackbarText = `${this.product.name} was liked!`;
      }

      this.snackbar = true;
      this.$store.dispatch("likeAction", this.product);
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
    }
  }
};
</script>

<style lang="scss" scoped>
.img-replace {
  background-color: lightgray;
  width: 100%;
  height: 10.5rem;
  display: flex;
  justify-content: flex-end;
  align-items: flex-start;
}

.limited-p {
  white-space: nowrap;
}

.changed-product-text{
  font-size: 0.6rem;
  line-height: 1.4;
  height: 3em;
  overflow: hidden;
}

.price-wrapper{
  display: flex;
}

.changed-product-title{
  font-size: 0.85rem;
  line-height: 1.7;
}

.discounted{
  color: red;
  text-decoration: line-through;
}

.product-card {
  overflow: hidden;
  display: inline-block;
  height: fit-content;
  max-width: 45vw;
}

// .price{
//   line-height: 1.3;
// }

.product-btn {
  width: 100%;
}
</style>
