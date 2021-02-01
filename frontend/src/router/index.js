import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: () => import("../views/Home.vue")
  },
  {
    path: "/products",
    name: "Products",
    component: () => import("@/views/Products.vue")
  },
  {
    path: "/likes",
    name: "Likes",
    component: () => import("@/views/Likes.vue")
  },
  // {
  //   path: "/categories",
  //   name: "Categories",
  //   component: () => import("@/views/Categories.vue")
  // },
  {
    path: "/category/:id",
    name: "ShowCategory",
    props: true,
    component: () => import("@/views/ShowCategory.vue")
  },
  {
    path: "/product/:id",
    name: "ProductView",
    props: true,
    component: () => import("@/views/ProductView.vue")
  },
  {
    path: "/cart",
    name: "Cart",
    component: () => import("@/views/Cart.vue")
  },
  {
    path: "/admin/login",
    name: "AdminLogin",
    component: () => import("@/views/AdminLogin.vue")
  },
  {
    path: "/search",
    name: "SearchField",
    component: () => import("@/views/SearchField.vue")
  },
  {
    path: "/search/:tag",
    name: "SearchResult",
    props: true,
    component: () => import("@/views/SearchResult.vue")
  },
  {
    path: "/about",
    name: "About",
    component: () => import("@/views/About.vue")
  },
  {
    path: "/saved_categories",
    name: "SavedCategories",
    component: () => import("@/views/SavedCategories.vue")
  },
  {
    path: "/cart/info",
    name: "CartInfo",
    component: () => import("@/views/CartInfo.vue")
  },
  // {
  //   path: "/products/:group",
  //   name: "ProductsGroup",
  //   props: true,
  //   component: () => import("@/views/ProductsGroup.vue")
  // },
  {
    path: "/colors",
    name: "Colors",
    props: {
      itemType: 'colors'
    },
    component: () => import("@/views/Colors.vue")
  },
  {
    path: "/brands",
    name: "Brands",
    props: {
      itemType: 'brands',
    },
    component: () => import("@/views/Colors.vue")
  },
  {
    path: "/categories",
    name: "Categories",
    props: {
      itemType: 'categories'
    },
    component: () => import("@/views/Colors.vue")
  },
  {
    path: "/brands/:id",
    name: "BrandProducts",
    props: true,
    component: () => import("@/views/BrandProducts.vue")
  },
  {
    path: "/sell_to_us",
    name: "SellToUs",
    component: () => import("@/views/SellToUs.vue")
  },
  {
    path: "/filter",
    name: "Filter",
    component: () => import("@/views/Filter.vue")
  },
  {
    path: "/contact",
    name: "Contact",
    component: () => import("@/views/Contact.vue")
  }
];

const router = new VueRouter({
  routes
});

export default router;
