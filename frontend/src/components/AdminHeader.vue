<template>
  <section class="admin-header">
    <v-app-bar color="white">
      <v-app-bar-nav-icon
        color="black"
        @click="menu = true"
      ></v-app-bar-nav-icon>
    </v-app-bar>
    <v-navigation-drawer color="white" v-model="menu" absolute temporary>
      <v-list nav dense>
        <v-list-group
          :color="randomColor()"
          v-for="item in items"
          :key="item.title"
          v-model="item.active"
          :prepend-icon="item.icon"
          append-icon=""
          class="no-mb"
          no-action
        >
          <template v-slot:activator>
            <v-list-item-content color="#00BFFF">
              <v-list-item-title class="specify_color" @click="reRoute(item)">{{
                item.title
              }}</v-list-item-title>
            </v-list-item-content>
          </template>
          <v-list-item v-for="child in item.items" :key="child.title">
            <v-list-item-content>
              <v-list-item-title
                class="blue--text"
                @click="$router.push(child.link).catch(() => {})"
                v-text="child.title"
              ></v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-group>
      </v-list>
    </v-navigation-drawer>
  </section>
</template>

<script>
export default {
  name: "AdminHeader",
  data() {
    return {
      menu: false,
      items: [
        { title: "View messages", link: "/admin/msgs", icon: "mdi-message" },
        { title: "View orders", link: "/admin/orders", icon: "mdi-cart" },
        { title: "View categories", link: "/admin/categories", icon: "mdi-apps" },
        { title: "View brands", link: "/admin/brands", icon: "mdi-currency-usd" },
        {
          title: "View sell requests",
          link: "/admin/sell_requests",
          icon: "mdi-cash-multiple"
        },
        { title: "View qualities", link: "/admin/qualities", icon: "mdi-tag"},
        { title: "View discounts", link: "/admin/discounts", icon: "mdi-cash" },
        { title: "View colors", link: "/admin/colors", icon: "mdi-palette" },
        {
          title: "View products",
          link: "/admin/products",
          icon: "mdi-tshirt-crew"
        },
        { title: "View miscellaneous", link: "/admin/miscs", icon: "mdi-dots-horizontal" },
        { title: "Customer page", link: "/", icon: "mdi-backburger" }
      ],
      colors: ["blue", "yellow", "green", "orange", "purple", "white", "red"]
    };
  },

  methods: {
    randomColor() {
      return this.colors[Math.floor(Math.random() * this.colors.length)];
    },
    reRoute(item) {
      if (item.items == undefined) {
        this.$router.push(item.link).catch(() => {});
      }
    }
  }
};
</script>

<style lang="scss">
.admin-header {
  i.v-icon,
  .specify_color {
    color: rgb(40, 40, 40) !important;
  }
}
</style>
