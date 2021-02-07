<template>
  <div class="text-center">
    <v-dialog v-model="dialog" width="500">
      <v-card>
        <v-card-title
          :class="{
            green: success,
            red: !success,
            primary: success == 'primary'
          }"
          class="headline white--text"
        >
          {{ title }}
        </v-card-title>

        <v-card-text class="pt-4">
          {{ text }}
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn :color="color" block class="white--text" @click="action()">
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
      if (this.success == true) {
        return "green";
      } else if (this.success == false) {
        return "red";
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

<style lang="scss" scoped></style>
