<template>
  <main class="home">
    <aside>
      <div class="main-background">
        <div class="text">
          <h3>This is</h3>
          <h1>Refashioned</h1>
        </div>
        <div class="cutout-background"></div>
      </div>
    </aside>

    <v-sheet color="primary" class="sheet" elevation="0">
      <div class="sheet-text">
        <h1>Shop without guilt.</h1>
        <p>
          No, really! All of our clothes are always handpicked, second-hand and
          of the highest quality. We want to be a part of the change towards a
          brighter and more sustainable future. And also look good while doing
          it! <br />
          <br />
          You might also notice that we don't put a gender label on our clothes.
          Thats because we don't belive in dividing clothes based on gender.
          Instead we classify them by the tailoring, so you'll get a sense of
          the fit. So if you like something in our stock, no matter who you are
          and no matter where you come from, you deserve to wear it with pride.
          <br /><br />
          Thats the Refashioned way.
        </p>
      </div>
    </v-sheet>

    <BulkComponent
      v-for="section of first_sections"
      :section="section"
      :key="section.link"
    />

    <v-card elevation="0" class="text-card" tile color="primary">
      <v-card-title>
        <p class="ma-0 large-title white--text">Who are we?</p>
      </v-card-title>
      <v-card-subtitle class="white--text">From here on out</v-card-subtitle>
      <v-card-text class="white--text"
        >Who are we and where did we come from? Read about our story, vision and
        what we hope to accomplish through Refashioned.</v-card-text
      >
      <v-card-actions>
        <router-link :to="'/about'" class="link">
          <v-btn small depressed text dark>click here to read</v-btn>
        </router-link>
      </v-card-actions>
    </v-card>

    <BulkComponent
      :section="{
        text: 'Shop by filter',
        link: '/filter',
        img_path: require('@/assets/front-page9.jpg')
      }"
    />

    <TitleCardProducts
      :name="'Popular brands'"
      :category="3"
      :amount="products.slice(0, 10).length"
      :all="products.length"
    />

    <ProductContainer :products="products.slice(0, 10)" />

    <BulkComponent
      v-for="section of second_sections"
      :key="section.link"
      :section="section"
    />

    <TitleCardProducts
      :name="'Recommended products'"
      :category="3"
      :amount="recommended.length"
      :all="products.length"
    />

    <ProductContainer :products="recommended" />
  </main>
</template>

<script>
import ProductContainer from "@/components/ProductContainer.vue";
import TitleCardProducts from "@/components/TitleCardProducts.vue";
import BulkComponent from "@/components/BulkComponent.vue";
const clone = require("rfdc")(); // Returns the deep copy function

export default {
  name: "Home",

  data() {
    return {
      first_sections: [
        {
          text: "New arrivals",
          link: "/new_arrivals",
          img_path: require("@/assets/front-page5.jpg")
        }
      ],

      second_sections: [
        {
          text: "Shop by category",
          link: "/categories",
          img_path: require("@/assets/front-page7.jpg")
        },
        {
          text: "Shop by brands",
          link: "/brands",
          img_path: require("@/assets/front-page6.jpg")
        },
        {
          text: "Shop by colors",
          link: "/colors",
          img_path: require("@/assets/front-page8.jpg")
        }
      ],

      recommended: []
    };
  },

  methods: {
    setRecommended() {
      let products = this.$store.getters.products;
      products = clone(products);
      this.recommended = products.splice(0, 10);
    }
  },

  created() {
    this.setRecommended();
  },

  computed: {
    products() {
      return this.$store.getters.products;
    }
  },

  components: {
    ProductContainer,
    TitleCardProducts,
    BulkComponent
  }
};
</script>

<style scoped lang="scss">
main.home {
  display: flex;
  align-items: center;
  flex-direction: column;
  height: fit-content;
}

.text-card {
  width: 95%;
  margin-top: 0.5em;

  p.large-title {
    font-size: 1.25em;
    font-weight: 700;
  }
}

aside:nth-of-type(1) {
  .main-background {
    background-image: url(../assets/main.png);
    height: 100%;
    width: 100%;
    background-position: center;
    background-size: cover;
    position: relative;

    .text {
      position: absolute;
      width: 100%;
      padding-top: 1em;
      h3 {
        padding-left: 2em;
      }
      h1 {
        line-height: 1;
        font-weight: 800;
        font-size: 3.5rem;
        width: 100%;
        text-align: center;
      }
    }

    .cutout-background {
      background-position: center;
      background-size: cover;
      background-image: url(../assets/cutout.png);
      width: 100%;
      height: 100%;
      position: absolute;
      top: 0;
    }
  }
}

aside {
  width: calc(100% - 1em);
  height: 27rem;
  margin-top: 0.5em;
}

.sheet {
  width: 95%;
  height: fit-content;
  margin-top: 0.5em;
}

.overlay {
  background-color: rgb(0, 0, 0, 0.35);
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
  flex-direction: column;
}

.sheet-text {
  padding: 1em;
  h1,
  p {
    color: whitesmoke;
  }

  h1 {
    font-size: 3em;
    line-height: 1.3;
    margin-bottom: 0.5em;
    font-weight: 750;
  }
}
</style>
