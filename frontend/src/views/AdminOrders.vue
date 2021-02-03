<template>
  <main class="orders">

  </main>
</template>

<script>
const axios = require("axios");

export default {
    name: "AdminOrders",
    methods: {
        getOrders(){
            axios.get(`${process.env.VUE_APP_BACKEND}/orders`)
            .then(function(resp){
                console.log(resp.data)
            })
            .catch(function(error){
                console.log(error)
            })
        }
    },

    created(){
        this.getOrders();
    }
}
</script>

<style lang="scss" scoped>

</style>