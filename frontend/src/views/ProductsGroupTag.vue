<template>
  <main class="products-group">
      <h3>Group: {{ group }}</h3>
      <h3>Tag: {{ tag }}</h3>
  </main>
</template>

<script>
export default {
    name: "ProductsGroup",
    props: ["group", "tag"]
}
</script>

<style lang="scss">

</style>