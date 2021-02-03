<template>
  <main class="orders" v-if="loaded">
      <v-select class="pl-3 pr-3 pb-0 pt-5" @change="filter()" v-model="isShowing" dense outlined label="Show..." :items="shows"></v-select>
    <Order v-for="order of showingOrders" :key="order.id" :order="order"/>
  </main>
</template>

<script>
const axios = require("axios");
import Order from "@/components/Order.vue"
export default {
    name: "AdminOrders",
    data(){
        return{
            allOrders: [],
            showingOrders: [],
            loaded: false,
            isShowing: "",
            shows: [
                'sent',
                'recieved',
                'problem',
                'All orders'
            ]
        }
    },
    methods: {
        async getOrders(){
            let vue = this;

            axios.get(`${process.env.VUE_APP_BACKEND}/orders`)
            .then(function(resp){
                console.log(resp.data)

                vue.allOrders = resp.data
                vue.showingOrders = resp.data
                vue.loaded = true;
            })
            .catch(function(error){
                console.log(error)
            })
        },

        filter(){
            if(this.isShowing == "All orders"){
                this.showingOrders = this.allOrders
            }else{
                this.showingOrders = this.allOrders.filter(o => o.status == this.isShowing)
            }
        }
    },

    components: {
        Order
    },

    created(){
        this.getOrders();
    }
}
</script>

<style lang="scss" scoped>

</style>