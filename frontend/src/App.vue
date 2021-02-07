<template>
  <v-app>
    <AdminHeader v-if="isInAdmin" />
    <Header v-if="!isInAdmin" />
    <router-view :key="$route.fullPath"></router-view>
    <Footer />
  </v-app>
</template>

<script>
import Footer from "@/components/Footer.vue";
import Header from "@/components/Header.vue";
import AdminHeader from "@/components/AdminHeader.vue";
export default {
  name: "App",

  data() {
    return {
      isInAdmin: window.location.hash.startsWith("#/admin")
    };
  },

  methods: {
    setup() {
      this.$store.dispatch("getProducts");
      this.$store.dispatch("getCategories");
      this.$store.dispatch("getShippingData");
      this.$store.dispatch("getColors");
      this.$store.dispatch("getBrands");
      this.$store.dispatch("getQualities");
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

  watch: {
    $route: function(to) {
      this.isInAdmin = to.path.startsWith("/admin");
    }
  },

  created() {
    this.localStorageInit();
    this.setup();
  },

  components: {
    Header,
    Footer,
    AdminHeader
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

.main-text {
  h2 {
    text-align: center;
    margin: 1em 0 0.25em 0;
    padding: 0 1.25em;
    font-size: 2em;
    line-height: 1.3;
  }

  p {
    text-align: center;
    padding: 0 1.25rem;
    margin: 0 0 2em 0;
  }
}

.label {
  font-size: 0.8em;
}

.link-inside {
  text-decoration: underline;
}

.products-wrapper {
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  padding: 1em 0;
  > * {
    margin: 1em 0;
  }
}
</style>
