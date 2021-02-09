<template>
  <v-card class="mr-2 ml-2 mt-5">
      <v-card-title>{{ category.name }}</v-card-title>
      <v-card-subtitle>ID: {{ category.id }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
          <v-text-field outlined dense label="Name" @input="pendingUpdate = true" v-model="name"></v-text-field>
          <v-textarea dense outlined label="Description" @input="pendingUpdate = true" v-model="description"></v-textarea>
          <v-btn depressed color="primary" v-if="pendingUpdate" @click="update()" block>Update</v-btn>
          <v-btn depressed color="primary" class="mt-5" @click="deleteAlert = true" block>Delete</v-btn>
          <v-divider class="mb-5 mt-5"></v-divider>
          <p class="cat_info"><b>Created at:</b> {{ category.created_at }}</p>
          <p class="cat_info"><b>Updated at:</b> {{ category.updated_at }}</p>
      </v-card-text>
      <v-card-actions>
          <v-btn block :outlined="seeMore" color="primary" depressed @click="seeMore = !seeMore">{{ !seeMore && 'See more' || 'See less' }}</v-btn>
      </v-card-actions>

      <v-dialog v-model="deleteAlert" width="500">
        <v-card>
            <v-card-title class="primary white--text">Alert</v-card-title>
            <v-card-text>
                <p>You are trying to delete a color. Multiple products will therefore have no color assigned to them. Please select a color to replace them with.</p>
                <v-select dense outlined label="Category" v-model="selectedReplaceCat" :items="$store.getters.categories" item-text="name" item-value="id"></v-select>
                <v-btn color="primary" :disabled="selectedReplaceCat == null" class="mb-2" block depressed @click="destroy()">Delete</v-btn>
                <v-btn color="primary" block outlined depressed @click="deleteAlert = false">Cancel</v-btn>
            </v-card-text>
        </v-card>
    </v-dialog>
  </v-card>
</template>

<script>
const axios = require('axios');
export default {
    name: "AdminCategory",
    props: ['category'],

    data(){
        return{
            name: this.category.name,
            description: this.category.description,
            seeMore: false,
            pendingUpdate: false,
            deleteAlert: false,
            selectedReplaceCat: null,
        }
    },

    methods: {
        async update(){
            let vue = this;
            axios.patch(`${process.env.VUE_APP_BACKEND}/categories/${vue.category.id}`, {
                category: {
                    name: vue.name,
                    description: vue.description,
                }
            })
            .then(function(resp){
                vue.$emit('update', resp.data)
                console.log(resp)
            })
            .catch(function(error){
                alert(error)
            })
        },

        destroy(){
            let vue = this;

            axios.delete(`${process.env.VUE_APP_BACKEND}/categories/${vue.category.id}`, {
                params: {
                    newId: vue.selectedReplaceCat,
                }
            })
            .then(function(resp){
                console.log(resp)
                vue.$emit('destroy', vue.category)
            })
            .catch(function(error){
                alert(error)
            })
        }
    },

    created(){
        console.log(this.category)
    }
}
</script>

<style lang="scss" scoped>
    p.cat_info{
        text-align: center;
        margin: 0.5em 0;
    }
</style>