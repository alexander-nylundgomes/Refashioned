<template>
  <v-card class="ml-2 mr-2 mb-5">
    <v-card-title>{{ product.name }}</v-card-title>
    <v-card-subtitle>{{ product.cat_name }} - {{ product.id }}</v-card-subtitle>
    <v-card-text v-if="seeMore" class="mb-0">
      <v-select
        :items="sizes"
        @change="updatePending = true"
        label="Size..."
        dense
        outlined
        v-model="size"
      ></v-select>
      <v-select
        :items="[true, false]"
        @change="updatePending = true"
        label="Availability"
        dense
        outlined
        v-model="available"
      ></v-select>
      <v-select
        :items="brands"
        dense
        @change="updatePending = true"
        outlined
        label="Brand"
        item-text="name"
        v-model="brand"
      ></v-select>
      <v-select
        :items="colors"
        dense
        @change="updatePending = true"
        outlined
        label="Color"
        item-text="name"
        v-model="color"
      ></v-select>
      <v-select
        :items="categories"
        dense
        @change="updatePending = true"
        outlined
        label="Category"
        item-text="name"
        v-model="category"
      ></v-select>
      <v-select
        :items="qualities"
        dense
        @change="updatePending = true"
        outlined
        label="Quality"
        item-text="name"
        v-model="quality"
      ></v-select>
      <v-text-field
        dense
        outlined
        @change="updatePending = true"
        label="Name..."
        :value="product.name"
      ></v-text-field>
      <v-text-field
        dense
        outlined
        @change="updatePending = true"
        label="Price"
        suffix="kr"
        v-model="price"
      ></v-text-field>
      <v-text-field
        dense
        outlined
        @change="updatePending = true"
        label="Old price"
        suffix="kr"
        v-model="old_price"
      ></v-text-field>
      <v-text-field
        dense
        outlined
        @change="updatePending = true"
        label="Order ID"
        v-model="order_id"
      ></v-text-field>
      <v-file-input
        dense
        outlined
        label="New main image"
        @change="updatePending = true"
        prepend-icon=""
        v-model="main_img"
      ></v-file-input>
      <v-textarea
        outlined
        dense
        @change="updatePending = true"
        label="Description"
        v-model="description"
      ></v-textarea>
      <v-btn block color="primary" depressed class="mb-2" @click="getTags()"
        >Product tags</v-btn
      >

      <v-btn block color="primary" depressed class="mb-2" @click="getImages();">Product images</v-btn>
      <v-btn
        block
        color="primary"
        depressed
        class="mb-2"
        v-if="updatePending"
        @click="updateProduct()"
        >Update</v-btn
      >
      <v-img :src="product.main_image"></v-img>
      <p class="center-text mt-5"><b>Created at:</b> {{ product.created_at }}</p>
      <p class="center-text"><b>Updated at:</b> {{ product.updated_at }}</p>
      <v-btn
        block
        color="primary"
        depressed
        class="mb-2 mt-2"
        @click="deleteAlert = true"
        >Delete product</v-btn
      >
    </v-card-text>
    <v-card-actions>
      <v-btn
        depressed
        color="primary"
        @click="seeMore = !seeMore"
        :outlined="seeMore"
        block
        >{{ (seeMore && "See less") || "See more" }}</v-btn
      >
    </v-card-actions>
    <Snackbar
      :snackbar="snackbar"
      :snackbarText="snackbarText"
      @closeSnackbar="snackbar = false"
    />
    <v-dialog v-model="showTags" width="500">
      <v-card>
        <v-card-title>Tags</v-card-title>
        <v-card-subtitle>Showing tags for {{ product.name }}</v-card-subtitle>
        <v-card-text>
          <v-text-field
            v-for="tag of tagData"
            v-model="tagData[tagData.indexOf(tag)].name"
            @input="updateTagData = true"
            label="Tag"
            :key="tag.id"
            outlined
            dense
            clearable
          ></v-text-field>
          <v-btn block color="primary" outlined depressed @click="moreTags()">
            +
          </v-btn>
        </v-card-text>
        <v-card-actions>
          <v-btn
            depressed
            block
            color="primary"
            @click="sendUpdatedTagData()"
            :disabled="!updateTagData"
            >Update</v-btn
          >
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="deleteAlert" width="500">
      <v-card>
        <v-card-title class="primary white--text">Are you sure?</v-card-title>
        <v-card-text class="pa-5"
          >You are about to delete product <b>{{ product.name }}</b
          >, (id: <b>{{ product.id }}</b
          >). Doing this will remove it from the database. If you want to remove
          it from customer page instead, set availability to false and update it
          instead.</v-card-text
        >
        <v-card-actions>
          <v-container>
            <v-row>
              <v-col>
                <v-btn
                  depressed
                  color="primary"
                  block
                  @click="deleteAlert = false"
                  >No, cancel it</v-btn
                >
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-btn
                  depressed
                  outlined
                  color="primary"
                  block
                  @click="deleteProduct()"
                  >Yes, delete it</v-btn
                >
              </v-col>
            </v-row>
          </v-container>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <v-dialog v-model="showProductImages" width="500">
      <v-card>
        <v-card-title class="primary white--text">Product Images</v-card-title>
        <v-card-text>
          <div v-for="img of productImages" :key="img.id" class="mt-6" >
            <v-img v-if="img.path" :src="img.path" ></v-img>
            <div class="img-replacement" v-if="!img.path"></div>
            <v-file-input outlined dense label="Select new image" prepend-icon="" v-model="sendImages[img.id].newImage" hide-details class="mt-2 mb-4"></v-file-input>
            <v-text-field outlined dense label="Order" hide-details class="mb-4" v-model="sendImages[img.id].order"></v-text-field>
            <v-btn color="primary" block depressed  @click="updateImage(sendImages[img.id])">Update</v-btn>
            <v-btn color="primary" block outlined depressed class="mt-2" @click="deleteImage(sendImages[img.id])">Delete</v-btn>
          </div>
          <v-btn color="primary" block large depressed class="mt-15" @click="addPotentialImage()">+</v-btn>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
const axios = require("axios");
import Snackbar from "@/components/Snackbar.vue";
export default {
  name: "AdminProduct",
  props: ["product", "qualities", "colors", "categories", "brands"],

  data() {
    return {
      seeMore: false,
      sizes: ["XXS", "XS", "S", "M", "L", "XL", "XXL"],
      showTags: false,
      size: this.product.size,
      available: this.product.bought == 0,
      brand: this.product.brands_name,
      quality: this.product.quality_name,
      category: this.product.cat_name,
      color: this.product.color_name,
      price: this.product.price,
      updatePending: false,
      old_price: this.product.old_price,
      description: this.product.desc,
      main_img: null,
      showProductImages: false,

      productImages: [],
      sendImages: [],

      deleteAlert: false,

      tagData: null,
      updateTagData: false,

      order_id: this.product.order_id,

      snackbar: false,
      snackbarText: ""
    };
  },

  methods: {
    async updateProduct() {
      let vue = this;

      let headers = {
        headers: {
          "Content-Type": "multipart/form-data"
        }
      };

      let formData = new FormData();
      let product = {
        category_id: vue.categories.find(q => q.name == vue.category).id,
        brand_id: vue.brands.find(b => b.name == vue.brand).id,
        color_id: vue.colors.find(c => c.name == vue.color).id,
        order_id: vue.order_id,
        size: vue.size,
        price: vue.price,
        bought: !vue.available,
        quality_id: vue.qualities.find(q => q.name == vue.quality).id,
        old_price: vue.old_price,
        desc: vue.description
      };

      formData.append("main_img", this.main_img);
      formData.append("product", JSON.stringify(product));

      axios
        .patch(
          `${process.env.VUE_APP_BACKEND}/products/${vue.product.id}`,
          formData,
          headers
        )
        .then(function(resp) {
          console.log(resp);
          vue.snackbarText = `Product with ID ${vue.product.id} was successfully updated!`;
          vue.updatePending = false;
        })
        .catch(function(error) {
          console.log(error);
          vue.snackbarText = `Something went wrong. Check console for details.`;
        });

      vue.snackbar = true;
    },

    getTags() {
      if (this.tagData == null) {
        console.log("fetching");
        let vue = this;
        axios
          .get(`${process.env.VUE_APP_BACKEND}/product_tags/${vue.product.id}`)
          .then(function(resp) {
            vue.tagData = resp.data;
            vue.showTags = true;
          })
          .catch(function(error) {
            console.log(error);
          });
      } else {
        console.log("not fetching");
        this.showTags = true;
      }
    },

    deleteImage(img){
      let vue = this;

      axios.delete(`${process.env.VUE_APP_BACKEND}/product_images/${img.id}`)
      .then(function(){
        vue.snackbarText = "Product image was successfully deleted!"
      })
      .catch(function(error){
        vue.snackbarText = "Something went wrong. Check console for details."
        console.log(error)
      })

      vue.snackbar = true;
    },

    updateImage(img){
      let headers = {
        headers: {
          "Content-Type": "multipart/form-data"
        }
      };

      let formData = new FormData();
      let image = {
        order: img.order,
        product_id: this.product.id
      };

      formData.append("file", img.newImage);
      formData.append("product_image", JSON.stringify(image));

      let vue = this;
      if(img.exists){
        // Image should be updated
        axios.patch(`${process.env.VUE_APP_BACKEND}/product_images/${img.id}`, formData, headers)
        .then(function(resp){
          console.log(resp)
          vue.snackbarText = "Product image was successfully updated!"
        })
        .catch(function(error){
          vue.snackbarText = "Something went wrong. Check console for details."
          console.log(error)
        })
      }else{
        // Image should be created
        axios.post(`${process.env.VUE_APP_BACKEND}/product_images`, formData, headers)
        .then(function(resp){
          vue.snackbarText = "Product image was successfully created!"
          console.log(resp)
        })
        .catch(function(error){
          vue.snackbarText = "Something went wrong. Check console for details."
          console.log(error)
        })
      }

      this.snackbar = true;
    },

    getImages(){
      this.showProductImages = true;
      let vue = this;
      axios.get(`${process.env.VUE_APP_BACKEND}/product_images/${vue.product.id}`)
      .then(function(resp){
        console.log(resp.data)
        vue.productImages = resp.data
        let sendImages = {};
        for(let x of resp.data){
          sendImages[x.id] = {order: x.order, newImage: null, id: x.id, exists: true}
        }

        vue.sendImages = sendImages;
      })
      .catch(function(error){
        alert(error)
      })
    },

    addPotentialImage(){
      let h = Math.max.apply(Math, this.productImages.map(function(o) { return o.id; }))
      this.sendImages[h + 1] = {order: null, newImage: null, id: h + 1, exists: false}
      this.productImages.push({order: null, path: null, id: parseInt(h) + 1, product_id: this.product.id})
    },

    moreTags() {
      this.tagData.push({ name: "" });
    },

    sendUpdatedTagData() {
      let vue = this;
      axios
        .patch(
          `${process.env.VUE_APP_BACKEND}/product_tags/${vue.product.id}`,
          {
            tags: vue.tagData
          }
        )
        .then(function(resp) {
          console.log(resp);
        })
        .catch(function(error) {
          console.log(error);
        });
    },

    async deleteProduct() {
      let vue = this;
      axios
        .delete(`${process.env.VUE_APP_BACKEND}/products/${vue.product.id}`)
        .then(function() {
          vue.snackbarText = "Product was successfully deleted!";
        })
        .catch(function(error) {
          console.log(error);
          vue.snackbarText = "Something went wrong, check console for details";
        });

      this.snackbar = true;
    }
  },
  components: {
    Snackbar
  }
};
</script>

<style lang="scss" scoped>
.center-text {
  text-align: center;
}

.img-replacement {
  width: 100%;
  margin: 0 auto;
  height: 25em;
  margin-bottom: 1em;
  background-color: lightgray;
}
</style>
