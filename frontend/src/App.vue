<template>
  <v-app>
    <v-app-bar color="rgb(20,20,20)" dark>
      <v-app-bar-nav-icon @click="menu = true"></v-app-bar-nav-icon>
      <!-- <v-toolbar-title>{{test}}</v-toolbar-title> -->
    </v-app-bar>
    <v-navigation-drawer color="primary" v-model="menu" absolute temporary>
      <v-list nav dense dark>
        <v-list-group
          :color="randomColor()"
          dark
          v-for="item in items"
          :key="item.title"
          v-model="item.active"
          :prepend-icon="item.icon"
          append-icon=""
          class="no-mb"
          no-action
        >
          <template v-slot:activator>
            <v-list-item-content color="white">
              <v-list-item-title class="white--text" @click="reRoute(item)" >{{ item.title }}</v-list-item-title>
            </v-list-item-content>
          </template>
            <v-list-item
              v-for="child in item.items"
              :key="child.title"
            >
              <v-list-item-content>
                <v-list-item-title class="white--text" @click="$router.push(child.link).catch(()=>{})" v-text="child.title"></v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-group>

      </v-list>
    </v-navigation-drawer>
    <router-view :key="$route.fullPath"></router-view>
    <Footer />
  </v-app>
</template>

<script>
import Footer from "@/components/Footer.vue";

export default {
  name: "App",

  data() {
    return {
      menu: false,
      items: [
        { title: "Home", link: "/", icon: "mdi-home" },
        { title: "Products", link: "/products", icon: "mdi-tshirt-crew", items: [
          {title: "Product page", link: "/products"},
          {title: "Brands", link: "/brands"},
          {title: "Colors", link: "/colors"},
          {title: "Categories", link: "/categories"},
          {title: "Custom filter", link: "/filter"},
        ]},
        { title: "Likes", link: "/likes", icon: "mdi-heart" },
        { title: "Cart", link: "/cart", icon: "mdi-cart" },
        { title: "Sell to us", link: "/sell_to_us", icon: "mdi-cash-multiple" },
        { title: "Search", link: "/search", icon: "mdi-magnify" },
        { title: "Contact us", link: "/contact", icon: "mdi-email-outline" },
        { title: "About us", link: "/about", icon: "mdi-account-multiple" }
      ],
      colors: ["blue", "yellow", "green", "orange", "purple", "white", "red"]
    };
  },

  methods: {
    setup() {
      this.$store.dispatch("getProducts");
      this.$store.dispatch("getCategories");
      this.$store.dispatch("getShippingData");
      this.$store.dispatch("getColors");
      this.$store.dispatch("getBrands");
    },

    randomColor(){
      return this.colors[Math.floor(Math.random() * this.colors.length)]
    },

    reRoute(item){
      if(item.items == undefined){this.$router.push(item.link).catch(()=>{})}
    },

    localStorageInit() {
      if (localStorage.getItem("likes") == null) {
        localStorage.setItem("likes", JSON.stringify([]));
      }

      if (localStorage.getItem("liked_categories") == null) {
        localStorage.setItem("liked_categories", JSON.stringify([]));
      }

      if (localStorage.getItem("cart") == null) {
        localStorage.setItem("cart", JSON.stringify([]));
      }
    }
  },

  created() {
    this.localStorageInit();
    this.setup();
  },

  components: {
    Footer
  }
};
</script>

<style lang="scss">
main {
  width: 100vw;
  min-height: 100vh;
  height: fit-content;
}

.link {
  text-decoration: none;
}

.changed-title {
  font-size: 1em !important;
}

.changed-subtitle {
  font-size: 0.75em !important;
}

.changed-text {
  font-size: 0.5em !important;
  line-height: 1.6;
}

.changed-buttons {
  font-size: 0.6em !important;
}

.changed-button-alert {
  font-size: 0.75em !important;
}

.label{
  font-size: 0.80em;
}

.link-inside{
  text-decoration: underline;

}

.no-mb{
  margin-bottom: 0 !important;

  *{
    margin-bottom: 0 !important;
  }
}
</style>
