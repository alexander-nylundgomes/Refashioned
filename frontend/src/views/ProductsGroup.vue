<template>
  <main class="products-group">
    <Group
    v-for="g of groups"
    :key="g.id"
    :title="g.name"
    :desc="g.description"
    :img_path="g.img_path"
    :link="`/${group}/` + g.id"
    />
  </main>
</template>

<script>
const axios = require("axios");
import Group from "@/components/Group.vue"
export default {
    name: "ProductsGroup",
    props: ['group'],

    data(){
        return{
            groups: []
        }
    },

    components: {
        Group
    },

    methods: {
        async getData(){
            let vue = this;
            axios.get(`${process.env.VUE_APP_BACKEND}/${vue.group}`)
            .then(function(resp){
                vue.groups = resp.data;
            })
            .catch(function(error){
                console.log(error)
            })
        },
    },
    created(){
        this.getData();
    }
}
</script>

<style>

</style>