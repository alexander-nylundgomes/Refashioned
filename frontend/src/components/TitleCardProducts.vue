<template>
  <v-card class="info-section" elevation="0">
    <v-card-title>
      <p class="ma-0" :class="{ 'changed-title': $vuetify.breakpoint.xs }">
        {{ name }}
      </p>
    </v-card-title>
    <v-card-subtitle>Showing {{ amount }} out of {{ all }}</v-card-subtitle>
    <v-card-actions v-if="buttons">
      <router-link :to="`/category/${category}`" class="link mr-3">
        <v-btn depressed dark color="primary">Show all</v-btn>
      </router-link>
      <v-btn
        @click="saveAction()"
        depressed
        dark
        color="primary"
        v-if="!isLiked"
        >Save category</v-btn
      >
      <v-btn
        @click="saveAction()"
        depressed
        outlined
        dark
        color="primary"
        v-if="isLiked"
        >Unsave category</v-btn
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
</template>

<script>
export default {
  name: "TitleCardProducts",
  props: ["name", "amount", "all", "category", "buttons"],

  data() {
    return {
      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    saveAction() {
      if (this.isLiked) {
        this.snackbarText = `${this.name} was unsaved!`;
      } else {
        this.snackbarText = `${this.name} was saved!`;
      }

      this.snackbar = true;

      this.$store.dispatch("categoryAction", this.category);
    }
  },

  computed: {
    isLiked() {
      let isLiked = false;

      for (let d of this.$store.getters.liked_categories) {
        if (d == this.category) {
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
.info-section {
  width: 100%;
  margin: 0.5em auto;
  background-color: rgb(240, 240, 240);
}
</style>
