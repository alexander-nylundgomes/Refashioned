<template>
  <v-card class="ml-2 mr-2">
    <v-card-title>Add new product</v-card-title>
    <v-card-text v-if="seeMore">
      <v-form ref="form" lazy-validation v-model="valid">
        <v-select
          :items="sizes"
          label="Size..."
          dense
          :rules="req"
          outlined
          v-model="size"
        ></v-select>
        <v-select
          :items="[true, false]"
          label="Availability"
          dense
          :rules="req"
          outlined
          v-model="available"
        ></v-select>
        <v-select
          :items="brands"
          dense
          outlined
          label="Brand"
          :rules="req"
          item-text="name"
          item-value="id"
          v-model="brand"
        ></v-select>
        <v-select
          :items="colors"
          dense
          outlined
          label="Color"
          :rules="req"
          item-text="name"
          item-value="id"
          v-model="color"
        ></v-select>
        <v-select
          :items="categories"
          dense
          outlined
          label="Category"
          :rules="req"
          item-text="name"
          item-value="id"
          v-model="category"
        ></v-select>
        <v-select
          :items="qualities"
          dense
          outlined
          label="Quality"
          :rules="req"
          item-text="name"
          item-value="id"
          v-model="quality"
        ></v-select>
        <v-text-field
          dense
          outlined
          :rules="req"
          label="Name"
          v-model="name"
        ></v-text-field>
        <v-text-field
          dense
          outlined
          label="Price"
          :rules="req"
          suffix="kr"
          v-model="price"
        ></v-text-field>
        <v-text-field
          dense
          outlined
          label="Old price"
          suffix="kr"
          v-model="old_price"
        ></v-text-field>
        <v-file-input
          dense
          outlined
          label="Select main image"
          prepend-icon=""
          :rules="fileRule"
          v-model="main_img"
        ></v-file-input>
        <v-textarea
          outlined
          dense
          :rules="req"
          label="Description"
          v-model="description"
        ></v-textarea>
        <v-btn
          block
          color="primary"
          depressed
          class="mb-2"
          @click="createProduct()"
          >Create product</v-btn
        >
      </v-form>
    </v-card-text>
    <v-card-actions>
      <v-btn
        :outlined="seeMore"
        depressed
        block
        color="primary"
        @click="seeMore = !seeMore"
        >{{ (!seeMore && "Show form") || "Hide form" }}</v-btn
      >
    </v-card-actions>
    <Snackbar :snackbar="snackbar" :snackbarText="snackbarText" @closeSnackbar="snackbar = false"/>
  </v-card> 
</template>

<script>
import Snackbar from "@/components/Snackbar.vue"
const axios = require('axios');
export default {
  name: "AdminAddProduct",
  props: ["colors", "qualities", "brands", "categories"],

  data() {
    return {
      seeMore: false,
      valid: true,

      sizes: ["XSS", "XS", "S", "M", "L", "XL", "XLL"],
      size: "",
      available: null,
      brand: null,
      quality: null,
      category: null,
      color: "",
      price: "",
      old_price: "",
      description: "",
      name: "",
      main_img: null,

      req: [v => !!v || "Item is required"],
      fileRule: [
          file => !!file || 'Image is required',
          file => !file || file.size < 1024 * 1024 * 0.5 || "Image must be smaller than 0.5 MB",
          file => !file || file.type == 'image/jpeg' || 'Image must be a JPG file',
      ],

      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    async createProduct() {
      if(this.$refs.form.validate()){
          let vue = this;
    
          let headers = {
              headers: {
                  'Content-type' : 'multipart/form-data'
              }
          }
    
          let product = {
                size: vue.size,
                bought: !vue.available,
                brand_id: vue.brand,
                quality_id: vue.quality,
                color_id: vue.color,
                category_id: vue.category,
                name: vue.name,
                price: vue.price,
                old_price: vue.old_price,
                desc: vue.description
          }
    
          let formData = new FormData();
          formData.append("main_img", this.main_img);
          formData.append("product", JSON.stringify(product));
    
          axios
            .post(`${process.env.VUE_APP_BACKEND}/products`, formData, headers)
            .then(function(resp) {
              console.log(resp);
              vue.$refs.form.reset();
              vue.$store.commit('addProduct', resp.data)
              vue.snackbarText = "Prodcut was successfully created!"
            })
            .catch(function(error) {
              vue.snackbarText = "Something went wrong. Check console for details."
              console.log(error);
            });
    
            vue.snackbar = true;
      }

    }
  },

  components: {
    Snackbar
  }
};
</script>

<style lang="scss" scoped></style>
