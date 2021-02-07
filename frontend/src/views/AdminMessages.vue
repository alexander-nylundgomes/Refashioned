<template>
  <main class="admin-messages">
    <v-select
      class="pl-3 pr-3 pb-0 pt-5"
      v-model="sort"
      @change="filter()"
      label="Sort by ..."
      dense
      outlined
      :items="sorts"
      item-text="text"
      item-value="id"
    ></v-select>
    <v-select
      class="pl-3 pr-3"
      @change="filter()"
      v-model="show"
      label="Show ..."
      dense
      outlined
      :items="shows"
      item-text="text"
      item-value="id"
    ></v-select>
    <Msg
      v-for="msg of msgs"
      :key="msg.id"
      :msg="msg"
      @action="shouldFilter()"
    />
  </main>
</template>

<script>
const axios = require("axios");
import Msg from "@/components/Msg.vue";
export default {
  name: "AdminMessages",
  data() {
    return {
      msgs: [],
      sort: null,
      show: null,
      sorts: [
        { text: "Newest first", id: 1 },
        { text: "Oldest first", id: 2 }
      ],
      shows: [
        { text: "Read - Read messages first", id: 1 },
        { text: "Unread - Unread messages first", id: 2 }
      ]
    };
  },
  methods: {
    async getMessages() {
      let vue = this;
      axios
        .get(`${process.env.VUE_APP_BACKEND}/msgs`)
        .then(function(resp) {
          vue.msgs = resp.data;
        })
        .catch(function(error) {
          alert(error);
        });
    },

    filter() {
      switch (this.sort) {
        case 1:
          this.msgs.sort(function(x, y) {
            return y.id - x.id;
          });
          break;
        case 2:
          this.msgs.sort(function(y, x) {
            return y.id - x.id;
          });
          break;
      }

      switch (this.show) {
        case 1:
          this.msgs.sort(function(x, y) {
            return y.read - x.read;
          });
          break;
        case 2:
          this.msgs.sort(function(y, x) {
            return y.read - x.read;
          });
          break;
      }
    },

    shouldFilter() {
      if (this.show != null) {
        this.filter();
      }
    }
  },

  created() {
    this.getMessages();
  },

  components: {
    Msg
  }
};
</script>

<style lang="scss"></style>
