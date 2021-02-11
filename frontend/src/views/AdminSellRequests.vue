<template>
  <main class="sell-requests">
    <v-select
      class="pl-3 pr-3 pb-0 pt-5"
      @change="filter()"
      v-model="isShowing"
      dense
      outlined
      label="Show..."
      :items="shows"
    ></v-select>
    <v-select
      class="pl-3 pr-3 pb-0"
      @change="filter()"
      v-model="sortBy"
      dense
      outlined
      label="Sort by"
      :items="sorts"
      item-text="text"
      item-value="id"
    ></v-select>
    <div class="sell-requests" v-if="loaded">
      <SellRequest
        @updated="filter()"
        v-for="sr of showingRequests"
        :key="sr.id"
        :sr="sr"
      />
    </div>
  </main>
</template>

<script>
const axios = require("axios");
import SellRequest from "@/components/SellRequest.vue";
export default {
  name: "AdminSellRequests",
  data() {
    return {
      loaded: false,
      sellRequests: [],
      showingRequests: [],
      isShowing: "All requests",
      shows: ["All requests", "Accepted", "Bought", "Rejected"],
      sorts: [
        { text: "New first", id: 1 },
        { text: "Old first", id: 2 }
      ],
      sortBy: null
    };
  },
  methods: {
    async getSellRequests() {
      let vue = this;

      axios
        .get(`${process.env.VUE_APP_BACKEND}/sell_requests`)
        .then(function(resp) {
          console.log(resp);
          vue.sellRequests = resp.data;
          vue.showingRequests = resp.data;
        })
        .catch(function(error) {
          alert(error);
        });

      this.loaded = true;
    },

    filter() {
      if (this.isShowing == "All requests") {
        this.showingRequests = this.sellRequests;
      } else {
        this.showingRequests = this.sellRequests.filter(
          s => s.status == this.isShowing
        );
      }

      switch (this.sortBy) {
        case 2:
          this.showingRequests.sort(function(a, b) {
            return a.id - b.id;
          });
          break;
        case 1:
          this.showingRequests.sort(function(a, b) {
            return b.id - a.id;
          });
          break;
      }
    }
  },

  created() {
    this.getSellRequests();
  },

  components: {
    SellRequest
  }
};
</script>

<style lang="scss"></style>
