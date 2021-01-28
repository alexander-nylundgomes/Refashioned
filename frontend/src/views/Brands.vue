<template>
  <main class="brands">
  </main>
</template>

<script>
export default {
    name: "Brands",
    data(){
        return{
            brands: this.$store.getters.brands
        }
    }
}
</script>

<style>

</style>