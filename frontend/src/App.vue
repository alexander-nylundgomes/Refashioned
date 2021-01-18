<template>
  <v-app>
    <v-app-bar
      flat
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
          <v-list-item color="orange" v-for="item of listItems" :key="item.link"  :link="true" :to="item.link">
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>
              <v-list-item-title> {{ item.title }} </v-list-item-title>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
    <router-view></router-view>
  </v-app>
</template>

<script>

export default {
  name: "App",

  data(){
    return{
      menu: false,
      listItems: [
        {title: "Home", link: "/", icon: "mdi-home"},
        {title: "Products", link: "/products", icon: "mdi-home"},
      ],
    }
  },

  methods: {
    getProducts(){
      this.$store.dispatch("getProducts")
    }
  },

  created(){
    this.getProducts()
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
</style>
