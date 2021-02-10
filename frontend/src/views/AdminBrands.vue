<template>
  <main class="brands">

      <section class="brands">
          <AdminBrand 
            :brand="brand" 
            v-for="brand of brands" 
            :key="brand.id"
            @delete="deleteBrand($event)"
            @update="updateBrand($event)"
            />
      </section>
      <Snackbar :snackbar="snackbar" :snackbarText="snackbarText" @closeSnackbar="snackbar = false" />
  </main>
</template>

<script>
import Snackbar from "@/components/Snackbar.vue"
import AdminBrand from "@/components/AdminBrand.vue"
export default {
    name: "AdminBrands",

    data(){
        return{
            snackbar: false,
            snackbarText: ""
        }
    },

    computed: {
        brands(){
            return this.$store.getters.brands;
        }
    },

    methods: {
        deleteBrand(e){
            this.$store.commit('deleteBrand', e)
            this.snackbarText = "Brand was deleted successfully!"
            this.snackbar = true;
        },

        updateBrand(e){
            this.$store.commit('updateBrand', e)
            this.snackbarText = "Brand was updated successfully!"
            this.snackbar = true;
        }
    },

    components: {
        AdminBrand,
        Snackbar
    }
}
</script>

<style lang="scss" scoped>

</style>