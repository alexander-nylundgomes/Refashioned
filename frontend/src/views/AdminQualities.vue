<template>
  <main class="qualities">
      <AdminQuality :quality="quality" v-for="quality of qualities" :key="quality.id"/>
  </main>
</template>

<script>
import AdminQuality from "@/components/AdminQuality.vue"
export default {
    name: "AdminQualities",

    data(){
        return{
            qualities: this.$store.getters.qualities,
        }
    },

    mounted(){
        console.log(this.qualities)
    },

    components: {
        AdminQuality
    }
}
</script>

<style lang="scss" scoped>

</style>