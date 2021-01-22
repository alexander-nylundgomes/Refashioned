<template>
  <v-app>
    <v-app-bar
      color="rgb(20,20,20)"
      dark
    >
      <v-app-bar-nav-icon @click="menu = true"></v-app-bar-nav-icon>
      <!-- <v-toolbar-title>{{test}}</v-toolbar-title> -->
    </v-app-bar>
    <v-navigation-drawer
      v-model="menu"
      absolute
      temporary
    >
      <v-list
        nav
        dense
      >
        <v-list-item-group
          active-class="deep-purple--text text--accent-4"
        >
          <v-list-item color="blue" v-for="item of listItems" :key="item.link"  :link="true" :to="item.link">
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>
              <v-list-item-title> {{ item.title }} </v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
    <router-view></router-view>
    <Footer />
  </v-app>
</template>

<script>

import Footer from "@/components/Footer.vue";

export default {
  name: "App",

  data(){
    return{
      menu: false,
      listItems: [
        {title: "Home", link: "/", icon: "mdi-home"},
        {title: "Products", link: "/products", icon: "mdi-tshirt-crew"},
        {title: "Likes", link: "/likes", icon: "mdi-heart"},
        {title: "Categories", link: "/categories", icon: "mdi-apps"},
      ],
    }
  },

  methods: {
    setup(){
      this.$store.dispatch("getProducts");
      this.$store.dispatch("getCategories");
    },
    localStorageInit() {
      if (localStorage.getItem("likes") == null) {
        localStorage.setItem("likes", JSON.stringify([]));
      }

      if (localStorage.getItem("liked_categories") == null) {
        localStorage.setItem("liked_categories", JSON.stringify([]));
      }
    }
  },

  created(){
    this.localStorageInit();
    this.setup();
  },

  components: {
    Footer
  }
};
</script>

<style lang="scss">
  main{
    width: 100vw;
    height: 100vh;
  }

  .link{
    text-decoration: none;
  }

  .changed-title{
      font-size: 1em !important;
  }

  .changed-subtitle{
      font-size: 0.75em !important;
  }

  .changed-text{
      font-size: 0.5em !important;
      line-height: 1.6;
  }
  
  .changed-buttons{
      font-size: 0.6em !important;
  }

  .changed-button-alert{
      font-size: 0.75em !important;
  }
</style>
