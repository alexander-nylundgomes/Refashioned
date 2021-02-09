<template>
  <v-card class="mr-2 ml-2 mt-5">
      <v-card-title>{{ color.name }}</v-card-title>
      <v-card-subtitle>ID: {{ color.id }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
          <v-text-field dense outlined label="Name" v-model="name" @input="updatePending = true"></v-text-field>
          <v-textarea dense outlined @input="updatePending = true" label="Description" v-model="description"></v-textarea>
          <v-color-picker :mode="'hexa'" @update:color="updatePending = true"  v-model="selectedColor"></v-color-picker>
          <v-btn color="primary" block depressed @click="update()" v-if="updatePending">Update</v-btn>
          <p><b>Created at:</b> {{ color.created_at }}</p>
          <p><b>Updated at:</b> {{ color.updated_at }}</p>
      </v-card-text>
      <v-card-actions>
          <v-btn depressed block color="primary" :outlined="seeMore" @click="seeMore = !seeMore">{{ !seeMore && 'See more' || 'See less' }}</v-btn>
      </v-card-actions>

      <Snackbar :snackbar="snackbar" :snackbarText="snackbarText" @closeSnackbar="snackbar = false" />
  </v-card>
</template>

<script>
const axios = require('axios')
import Snackbar from "@/components/Snackbar.vue";
export default {
    name: "AdminColor",
    props: ['color'],
    data(){
        return{
            name: this.color.name,
            seeMore: false,
            description: this.color.description,
            selectedColor: this.color.color,
            updatePending: false,

            snackbar: false,
            snackbarText: "",
        }
    },

    watch: {
        selectedColor(value) {
            // temporary fix while there is no way to disable the alpha channel in the colorpicker component: https://github.com/vuetifyjs/vuetify/issues/9590
            if (value.toString().match(/#[a-zA-Z0-9]{8}/)) {
                this.selectedColor = value.substr(0, 7);
            }
        }
    },

    methods: {
        update(){
            let vue = this;

            axios.patch(`${process.env.VUE_APP_BACKEND}/colors/${vue.color.id}`, {
                color: {
                    color: vue.selectedColor,
                    description: vue.description,
                    name: vue.name
                }
            })
            .then(function(){
                vue.snackbarText = "Color was updated successfully!"
            })
            .catch(function(error){
                vue.snackbarText = "Something went wrong. Check logs for details."
                console.log(error)
            })

            vue.snackbar = true;
        }
    },

    components: {
        Snackbar
    }
}
</script>

<style lang="scss" scoped>
    p{
        text-align: center;
        margin: 0.5em 0;
    }
</style>