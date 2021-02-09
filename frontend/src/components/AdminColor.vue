<template>
  <v-card class="mr-2 ml-2 mt-5">
      <v-card-title>{{ color.name }}</v-card-title>
      <v-card-subtitle>ID: {{ color.id }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
          <v-text-field dense outlined label="Name" v-model="name" @input="updatePending = true"></v-text-field>
          <v-textarea dense outlined @input="updatePending = true" label="Description" v-model="description"></v-textarea>
          <v-color-picker :mode="'hexa'" @update:color="updatePending = true"  v-model="selectedColor"></v-color-picker>
          <v-btn color="primary" block depressed @click="update()" v-if="updatePending">Update</v-btn>
          <v-btn color="primary" block depressed class="mt-5" @click="deleteAlert = true">Delete</v-btn>
          <p><b>Created at:</b> {{ color.created_at }}</p>
          <p><b>Updated at:</b> {{ color.updated_at }}</p>
      </v-card-text>
      <v-card-actions>
          <v-btn depressed block color="primary" :outlined="seeMore" @click="seeMore = !seeMore">{{ !seeMore && 'See more' || 'See less' }}</v-btn>
      </v-card-actions>
      <v-dialog v-model="deleteAlert" width="500">
          <v-card>
              <v-card-title class="primary white--text">Alert</v-card-title>
              <v-card-text>
                  <p>You are trying to delete a color. Multiple products will therefore have no color assigned to them. Please select a color to replace them with.</p>
                  <v-select dense outlined label="Color" v-model="selectedReplaceColor" :items="$store.getters.colors" item-text="name" item-value="id"></v-select>
                  <v-btn color="primary" :disabled="selectedReplaceColor == null" class="mb-2" block depressed @click="destroy()">Delete</v-btn>
                  <v-btn color="primary" block outlined depressed @click="deleteAlert = false">Cancel</v-btn>
              </v-card-text>
          </v-card>
      </v-dialog>
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
            deleteAlert: false,

            selectedReplaceColor: null,

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
        async update(){
            let vue = this;
            axios.patch(`${process.env.VUE_APP_BACKEND}/colors/${vue.color.id}`, {
                color: {
                    color: vue.selectedColor.hex,
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
        },

        destroy(){
            console.log(this.selectedReplaceColor)
            let vue = this;
            axios.delete(`${process.env.VUE_APP_BACKEND}/colors/${vue.color.id}`, {
                params: {
                    newId: parseInt(vue.selectedReplaceColor),
                }
            })
            .then(function(){
                vue.snackbarText = "Color was deleted successfully!"
                vue.deleteAlert = false;
                vue.$store.commit('deleteColor', vue.color)
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