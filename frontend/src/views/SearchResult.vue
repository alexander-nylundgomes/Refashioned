<template>
  <main class="searchresult">

  </main>
</template>

<script>
const axios = require("axios");

export default {
    name: "SearchResult",
    props: ["tag"],

    data(){
        return{
            results: [],
        }
    },

    methods: {
        async getResults(){
            let results = await axios.get(`${process.env.VUE_APP_BACKEND}/search/${this.tag}`)
            .then(function(resp){
                console.log(resp)
                return resp.data
            })
            .catch(function(error){
                alert(error)
            })

            this.results = results;
        }
    },

    created(){
        this.getResults();
    }
}

</script>

<style lang="scss">

</style>