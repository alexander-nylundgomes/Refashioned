<template>
  <main class="sell-requests" >
      <div class="sell-requests" v-if="loaded">
        <SellRequest v-for="sr of sellRequests" :key="sr.id" :sr="sr"/>  
      </div>
  </main>
</template>

<script>
const axios = require("axios");
import SellRequest from "@/components/SellRequest.vue"
export default {
    name: "AdminSellRequests",
    data(){
        return{
            loaded: false,
            sellRequests: [],
        }
    },
    methods: {
        async getSellRequests(){
            let vue = this;

            axios.get(`${process.env.VUE_APP_BACKEND}/sell_requests`)
            .then(function(resp){
                console.log(resp)
                vue.sellRequests = resp.data;
            })
            .catch(function(error){
                alert(error)
            })
            
            this.loaded = true
        },
    },

    created(){
        this.getSellRequests();
    },

    components: {
        SellRequest
    }
}
</script>

<style lang="scss">

</style>