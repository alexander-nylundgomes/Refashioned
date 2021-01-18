import Vue from "vue";
import Vuex from "vuex";
const axios = require('axios');

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    products: [],
  },
  mutations: {
    setProducts(state, payload){
      state.products = payload
    }
  },
  actions: {
    async getProducts(state){
      // let resp = await fetch(`${process.env.VUE_APP_BACKEND}/products`);
      // let products = await resp.json();

      // console.log(products)
      // state.commit('setProducts', products)

      axios.get(`${process.env.VUE_APP_BACKEND}/products`)
        .then(function (resp){
          console.log(resp.data)
          state.commit('setProducts', resp.data)
        })
        .catch(function(error){
          alert(error)
        })
    }
  },
  modules: {},
  getters: {
    products(state){
      return state.products
    }
  }
});
