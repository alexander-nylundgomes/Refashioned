<template>
  <main class="filter">
    <header>
      <div class="main-text">
        <h2>Search by filter</h2>
        <p>
          Select what qualities your looking for in your next purchase by
          yourself and tailor the shopping experience to your liking!
        </p>
      </div>
      <v-select
        outlined
        @change="filter()"
        v-model="selectedBrand"
        dense
        class="pa-3"
        hide-details
        label="Brand"
        :items="brands"
        item-text="name"
      ></v-select>
      <v-select
        outlined
        @change="filter()"
        dense
        v-model="selectedSize"
        class="pa-3 pt-0"
        hide-details
        label="Size"
        :items="sizes"
      ></v-select>
      <v-select
        outlined
        @change="filter()"
        v-model="selectedColor"
        dense
        class="pa-3 pt-0"
        hide-details
        label="Colors"
        :items="colors"
        item-text="name"
        item-value="id"
      ></v-select>
      <v-select
        outlined
        @change="filter()"
        dense
        class="pa-3 pt-0"
        hide-details
        label="Categories"
        :items="categories"
        item-text="name"
      ></v-select>
      <v-select
        outlined
        @change="filter()"
        v-model="selectedSort"
        dense
        class="pa-3 pt-0"
        hide-details
        label="Sort by"
        item-text="text"
        item-value="id"
        :items="sorts"
      ></v-select>
    </header>
    <h3 class="pa-5 pb-0">Found {{ current_products.length }} items</h3>
    <section class="products">
      <Product
        lazy
        v-for="product of current_products.slice((n - 1) * 4, (n - 1) * 4 + 4)"
        :key="product.id"
        :product="product"
      />
    </section>
    <v-pagination
      class="pb-3"
      elevation="0"
      v-model="n"
      :length="calcSelectedAmount"
    ></v-pagination>
  </main>
</template>

<script>
import Product from "@/components/Product.vue";
export default {
  name: "FilterProducts",
  data() {
    return {
      n: 1,
      products: this.$store.getters.products,
      brands: this.$store.getters.brands,
      sizes: ["XSS", "XS", "S", "M", "L", "XL", "XLL"],
      colors: this.$store.getters.colors,
      categories: this.$store.getters.categories,
      sorts: [
        { text: "Price: Low to High", id: 1 },
        { text: "Price: High to Low", id: 2 }
      ],
      lengthOfCurrents: this.$store.getters.products.length,

      selectedBrand: null,
      selectedSize: null,
      selectedColor: null,
      selectedCategory: null,
      selectedSort: null,

      calcSelectedAmount: 0,

      current_products: []
    };
  },

  methods: {
    filter() {
      let ps = this.products.slice();

      if (this.selectedBrand) {
        ps = ps.filter(p => p.brands_name == this.selectedBrand);
      }

      if (this.selectedSize) {
        ps = ps.filter(p => p.size == this.selectedSize);
      }

      if (this.selectedColor) {
        ps = ps.filter(p => p.color == this.selectedColor);
      }

      if (this.selectedCategory) {
        ps = ps.filter(p => p.cat_name == this.selectedCategory);
      }

      if (this.selectedSort == 1) {
        ps.sort((a, b) => a.price - b.price);
      } else if (this.selectedSort == 2) {
        ps.sort((a, b) => b.price - a.price);
      }
      // Calculates amount of tabs
      this.n = 1;
      this.calcSelectedAmount = Math.ceil(ps.length / 4);
      this.current_products = ps;
    }
  },

  created() {
    this.filter();
  },

  components: {
    Product
  }
};
</script>

<style lang="scss" scoped>
section.products {
  width: 100%;
  height: fit-content;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  > * {
    margin: 1em 0;
  }
}
</style>
