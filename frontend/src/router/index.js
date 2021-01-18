import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: () => import("../views/Home.vue"),
  },
  {
    path: "/products",
    name: "Products",
    component: () => import('@/views/Products.vue')
  }
];

const router = new VueRouter({
  routes
});

export default router;
