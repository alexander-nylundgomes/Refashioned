import Vue from "vue";
import Vuex from "vuex";
const axios = require('axios');

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    products: [],
    likes: JSON.parse(localStorage.getItem('likes')),
  },
  mutations: {
    setProducts(state, payload){
      state.products = payload
    },

    like(state, payload){
      state.likes.push(payload)
      localStorage.setItem("likes", JSON.stringify(state.likes));
    },

    dislike(state, payload){
      let index = state.likes.indexOf(payload);
      state.likes.splice(index, 1)
      localStorage.setItem("likes", JSON.stringify(state.likes));
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
    },

    likeAction(state, payload){
      let isLiked = false;

      for (let d of state.getters.likes) {

        if (d.id == payload.id) {
            isLiked = true;
            break;
        }

      }

      if(isLiked){
        state.commit('dislike', payload)
      }else{
        state.commit('like', payload)
      }
    }
  },
  modules: {},
  getters: {
    products(state){
      return state.products;
    },

    likes(state){
      return state.likes;
    }
  }
});
