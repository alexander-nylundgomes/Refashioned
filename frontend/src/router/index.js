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
  },
  {
    path: "/likes",
    name: "Likes",
    component: () => import('@/views/Likes.vue')
  },
  {
    path: "/categories",
    name: "Categories",
    component: () => import('@/views/Categories.vue')
  },
  {
    path: "/category/:id",
    name: "ShowCategory",
    props: true,
    component: () => import('@/views/ShowCategory.vue')
  }
];

const router = new VueRouter({
  routes
});

export default router;
