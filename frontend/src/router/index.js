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
  {
    path: "/categories/:id",
    name: "ShowCategory",
    props: {
      itemTypeSing: "category",
      itemTypePlur: "categories"
    },
    component: () => import("@/views/TypesProducts.vue")
  },
  {
    path: "/new_arrivals",
    name: "NewlyAdded",
    component: () => import("@/views/NewlyAdded.vue")
  },
  {
    path: "/colors/:id",
    name: "ShowColors",
    props: {
      itemTypeSing: "color",
      itemTypePlur: "colors"
    },
    component: () => import("@/views/TypesProducts.vue")
  },
  {
    path: "/brands/:id",
    name: "ShowBrand",
    props: {
      itemTypeSing: "brand",
      itemTypePlur: "brands"
    },
    component: () => import("@/views/TypesProducts.vue")
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
    path: "/cart/info",
    name: "CartInfo",
    component: () => import("@/views/CartInfo.vue")
  },
  {
    path: "/colors",
    name: "Colors",
    props: {
      itemType: "colors"
    },
    component: () => import("@/views/Types.vue")
  },
  {
    path: "/brands",
    name: "Brands",
    props: {
      itemType: "brands"
    },
    component: () => import("@/views/Types.vue")
  },
  {
    path: "/categories",
    name: "Categories",
    props: {
      itemType: "categories"
    },
    component: () => import("@/views/Types.vue")
  },
  {
    path: "/brands/:id",
    name: "BrandProducts",
    props: true,
    component: () => import("@/views/TypesProducts.vue")
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
  },
  {
    path: "/admin",
    name: "Admin",
    component: () => import("@/views/Admin.vue")
  },
  {
    path: "/admin/msgs",
    name: "AdminMessages",
    component: () => import("@/views/AdminMessages.vue")
  },
  {
    path: "/admin/orders",
    name: "AdminOrders",
    component: () => import("@/views/AdminOrders.vue")
  },
  {
    path: "/admin/sell_requests",
    name: "AdminSellRequests",
    component: () => import("@/views/AdminSellRequests")
  },
  {
    path: "/admin/discounts",
    name: "AdminDiscounts",
    component: () => import("@/views/AdminDiscounts.vue")
  },
  {
    path: "/admin/products",
    name: "AdminProducts",
    component: () => import("@/views/AdminProducts.vue")
  },
  {
    path: "/admin/qualities",
    name: "AdminQualities",
    component: () => import("@/views/AdminQualities.vue")
  },
  {
    path: "/admin/miscs",
    name: "AdminMiscs",
    component: () => import("@/views/AdminMiscs.vue")
  },
  {
    path: "/admin/colors",
    name: "AdminColors",
    component: () => import("@/views/AdminColors.vue")
  },
  {
    path: "/payment-success",
    name: "PaymentSuccess",
    component: () => import("@/views/PaymentSuccess.vue")
  }
];

const router = new VueRouter({
  routes
});

export default router;
