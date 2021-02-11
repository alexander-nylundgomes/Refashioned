<template>
  <main class="colors">
    <v-form lazy-validation ref="form" v-model="accepted">
      <v-card class="mt-5 mr-2 ml-2">
        <v-card-title>Create new color</v-card-title>
        <v-card-text>
          <v-text-field
            outlined
            dense
            v-model="name"
            label="Name"
            :rules="notEmptyRule"
          ></v-text-field>
          <v-textarea
            outlined
            dense
            v-model="description"
            label="Description"
            :rules="notEmptyRule"
          ></v-textarea>
          <v-color-picker :mode="'hexa'" v-model="newColor"></v-color-picker>
        </v-card-text>
        <v-card-actions>
          <v-btn
            color="primary"
            block
            depressed
            @click="create()"
            :disabled="!accepted"
            >Create</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-form>
    <section class="colors" v-if="colors.length != 0">
      <AdminColor :color="color" v-for="color of colors" :key="color.id" />
    </section>
  </main>
</template>

<script>
const axios = require("axios");
import AdminColor from "@/components/AdminColor.vue";

export default {
  name: "AdminColors",

  data() {
    return {
      accepted: true,
      description: "",
      name: "",
      newColor: "",
      notEmptyRule: [v => !!v || "Item is required"]
    };
  },

  computed: {
    colors() {
      return this.$store.getters.colors;
    }
  },

  methods: {
    create() {
      if (this.$refs.form.validate()) {
        let vue = this;
        axios
          .post(`${process.env.VUE_APP_BACKEND}/colors`, {
            color: {
              img_path: "",
              name: vue.name,
              description: vue.description,
              color: vue.color
            }
          })
          .then(function(resp) {
            console.log(resp);
          })
          .catch(function(error) {
            console.log(error);
          });
      }
    }
  },

  watch: {
    newColor(value) {
      // temporary fix while there is no way to disable the alpha channel in the colorpicker component: https://github.com/vuetifyjs/vuetify/issues/9590
      if (value.toString().match(/#[a-zA-Z0-9]{8}/)) {
        this.newColor = value.substr(0, 7);
      }
    }
  },

  components: {
    AdminColor
  }
};
</script>

<style lang="scss" scoped></style>
