<template>
  <main class="miscs">
      <div class="miscs" v-if="miscs.length != 0">
        <AdminMisc v-for="misc of miscs" :key="misc.id" :misc="misc" />
      </div>
  </main>
</template>

<script>
const axios = require('axios');
import AdminMisc from "@/components/AdminMisc.vue";
export default {
    name: "Miscs",

    data(){
        return{
            miscs: []
        }
    },

    methods: {
        async getMiscs(){
            let vue = this;

            axios.get(`${process.env.VUE_APP_BACKEND}/miscs`)
            .then(function(resp){
                console.log(resp)
                vue.miscs = resp.data
            })
            .catch(function(error){
                console.log(error)
            })
        }
    },

    created(){
        this.getMiscs();
    },

    components: {
        AdminMisc
    }
}
</script>

<style lang="scss" scoped>

</style>