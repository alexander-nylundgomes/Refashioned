<template>
  <main class="colors">
      <section class="colors" v-if="colors.length != 0">
          <AdminColor :color="color" v-for="color of colors" :key="color.id"/>
      </section>
  </main>
</template>

<script>
const axios = require('axios');
import AdminColor from "@/components/AdminColor.vue";

export default {
    name: "AdminColors",

    data(){
        return{
            colors: []
        }
    },

    methods: {
        async getColors(){
            let vue = this;

            axios.get(`${process.env.VUE_APP_BACKEND}/colors`)
            .then(function(resp){
                console.log(resp.data)
                vue.colors = resp.data
            })
            .catch(function(error){
                alert(error)
            })
        }
    },

    created(){
        this.getColors();
    },

    components: {
        AdminColor
    }
}
</script>

<style lang="scss" scoped>

</style>