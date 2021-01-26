<template>
  <v-card width="200" class="product-card ml-2 mr-2" lazy>
    <div class="img-replace">
      <v-btn @click="likeAction()" icon class="mt-1 mr-1">
        <v-icon v-if="!isLiked" color="#EF6B6F">mdi-heart-outline</v-icon>
        <v-icon v-if="isLiked" color="#EF6B6F">mdi-heart</v-icon>
      </v-btn>
    </div>
    <v-card-title
      class="pa-1 pl-2 pr-2"
      :class="{ 'changed-title': $vuetify.breakpoint.xs }"
    >
      <p
        class="ma-0 limited-p"
        :class="{ 'changed-title': $vuetify.breakpoint.xs }"
      >
        {{ refactor(product.name, 14) }}
      </p>

      <v-spacer></v-spacer>
      <p class="ma-0" :class="{ 'changed-title': $vuetify.breakpoint.xs }">
        {{ product.price }} kr
      </p>
    </v-card-title>
    <v-card-subtitle
      class="pa-1 pl-2 pr-2"
      :class="{ 'changed-subtitle': $vuetify.breakpoint.xs }"
    >
      {{ product.brand }}
    </v-card-subtitle>
    <v-card-text
      class="pa-1 pl-2 pr-2"
      :class="{ 'changed-text': $vuetify.breakpoint.xs }"
      >{{ refactor(product.desc, 80) }}
    </v-card-text>
    <v-divider></v-divider>
    <v-card-actions>
      <router-link class="link product-btn" :to="'/product/' + product.id">
        <v-btn
          depressed
          small
          color="primary"
          block
          class="pl-3 pr-3"
          :class="{ 'changed-buttons-alert': $vuetify.breakpoint.xs }"
          >Check it out</v-btn
        >
      </router-link>
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
  height: 12.5rem;
  display: flex;
  justify-content: flex-end;
  align-items: flex-start;
}

.limited-p {
  max-width: 75%;
  white-space: nowrap;
}

.product-card {
  overflow: hidden;
  display: inline-block;
  height: fit-content;
}

.product-btn {
  width: 100%;
}
</style>
