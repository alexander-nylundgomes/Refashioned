import Vue from "vue";
import Vuex from "vuex";
const axios = require("axios");

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    products: [],
    likes: JSON.parse(localStorage.getItem("likes")),
    cart: JSON.parse(localStorage.getItem("cart")),
    categories: [],
    liked_categories: JSON.parse(localStorage.getItem("liked_categories")),
    finalCart: [],
  },
  mutations: {
    setProducts(state, payload) {
      state.products = payload;
    },

    finalCartInsertion(state, payload){
      state.finalCart = payload;
    },

    like(state, payload) {
      state.likes.push(payload);
      localStorage.setItem("likes", JSON.stringify(state.likes));
    },

    dislike(state, payload) {
      let index = state.likes.indexOf(payload);
      state.likes.splice(index, 1);
      localStorage.setItem("likes", JSON.stringify(state.likes));
    },

    categoryDislike(state, payload) {
      let index = state.liked_categories.indexOf(payload);
      state.liked_categories.splice(index, 1);
      localStorage.setItem(
        "liked_categories",
        JSON.stringify(state.liked_categories)
      );
    },

    categoryLike(state, payload) {
      state.liked_categories.push(payload);
      localStorage.setItem(
        "liked_categories",
        JSON.stringify(state.liked_categories)
      );
    },

    setCategories(state, payload) {
      state.categories = payload;
    },

    addToCart(state, payload) {
      state.cart.push(payload);
      localStorage.setItem("cart", JSON.stringify(state.cart));
    },

    removeFromCart(state, payload) {
      let index = state.cart.indexOf(payload);
      state.cart.splice(index, 1);
      localStorage.setItem("cart", JSON.stringify(state.cart));
    }
  },
  actions: {
    async getProducts(state) {
      axios
        .get(`${process.env.VUE_APP_BACKEND}/products`)
        .then(function(resp) {
          console.log(resp.data);
          state.commit("setProducts", resp.data);
        })
        .catch(function(error) {
          alert(error);
        });
    },

    async getCategories(state) {
      axios
        .get(`${process.env.VUE_APP_BACKEND}/categories`)
        .then(function(resp) {
          state.commit("setCategories", resp.data);
        })
        .catch(function(error) {
          alert(error);
        });
    },

    likeAction(state, payload) {
      let isLiked = false;

      for (let d of state.getters.likes) {
        if (d.id == payload.id) {
          isLiked = true;
          break;
        }
      }

      if (isLiked) {
        state.commit("dislike", payload);
      } else {
        state.commit("like", payload);
      }
    },

    categoryAction(state, payload) {
      let isLiked = false;

      for (let d of state.getters.liked_categories) {
        if (d == payload) {
          isLiked = true;
          break;
        }
      }

      if (!isLiked) {
        state.commit("categoryLike", payload);
      } else {
        state.commit("categoryDislike", payload);
      }
    },

    cartAction(state, payload) {
      let inCart = false;

      for (let d of state.getters.cart) {
        if (d.id == payload.id) {
          inCart = true;
          break;
        }
      }

      if (inCart) {
        state.commit("removeFromCart", payload);
      } else {
        state.commit("addToCart", payload);
      }
    }
  },
  modules: {},
  getters: {
    products(state) {
      return state.products;
    },

    likes(state) {
      return state.likes;
    },

    categories(state) {
      return state.categories;
    },

    liked_categories(state) {
      // Returns all liked liked_categories
      return state.liked_categories;
    },

    cart(state) {
      return state.cart;
    },

    finalCart(state){
      return state.finalCart;
    }
  }
});
