<template>
  <div class="text-center">
    <v-dialog v-model="dialog" width="275">
      <v-card>
        <v-card-title
          :style="`color: ${color};`"
          class="headline"
        >
          {{ title }}
        </v-card-title>

        <v-card-text >
          <v-icon class="success-icon" :style="`color: ${color};`">{{ success && 'mdi-thumb-up-outline' || 'mdi-thumb-down-outline'}}</v-icon>
          <p class="pt-4 text-center">{{ text }}</p>
        </v-card-text>

        <v-divider class="ml-4 mr-4"></v-divider>

        <v-card-actions>
          <v-btn :color="color" class="ma-auto" text @click="action()">
            {{ buttonText }}
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
export default {
  name: "Dailog",
  props: ["dialog", "title", "text", "buttonText", "success"],

  computed: {
    color() {
      if (this.success) {
        return "#8cbd54";
      } else if (!this.success) {
        return "#e65643";
      } else {
        return "primary";
      }
    }
  },

  methods: {
    action() {
      if (this.success == true) {
        this.$router.push("/");
      } else {
        this.$emit("closingDialog");
      }
    }
  }
};
</script>

<style lang="scss" scoped>

  .success-icon{
    font-size: 8em;
    width: 100%;
    text-align: center;
  }

  .headline{
    width: fit-content;
    margin: 0 auto;
    margin-bottom: 1em;
    font-size: 1.75em !important;
  }

</style>
