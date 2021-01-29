<template>
  <main class="cart-info">
    <v-stepper v-model="e1">
      <v-stepper-header>
        <v-stepper-step :complete="e1 > 1" step="1">
          Name of step 1
        </v-stepper-step>

        <v-divider></v-divider>

        <v-stepper-step :complete="e1 > 2" step="2">
          Name of step 2
        </v-stepper-step>

        <v-divider></v-divider>

        <v-stepper-step step="3">
          Name of step 3
        </v-stepper-step>
      </v-stepper-header>

      <v-stepper-items>
        <v-stepper-content step="1" elevation="0">
          <v-card elevation="0" class="mb-6 stepper">
            <v-form
              lazy-validation
              ref="form"
              class="pt-3"
              v-model="validInputs"
            >
              <v-text-field
                v-for="input of inputs"
                :prefix="input.prefix"
                :key="input.model"
                v-model="$data[input.model]"
                outlined
                :rules="giveRules(input)"
                required
                dense
                class="mt-0 ml-3 mr-3 mb-0"
                :label="input.text"
              >
              </v-text-field>
            </v-form>
          </v-card>

          <v-btn
            color="primary"
            @click="nextStepper()"
            :disabled="!validInputs"
          >
            Continue
          </v-btn>

          <v-btn @click="returnToCart()" text>
            Cancel
          </v-btn>
        </v-stepper-content>

        <v-stepper-content step="2">
          <v-card elevation="0" class="mb-6 stepper">
            <v-card
              class="ma-3"
              v-for="type of payment_options"
              :disabled="type.active"
              :key="type.title"
            >
              <v-card-title>{{ type.title }}</v-card-title>
              <v-card-subtitle>{{ type.subtitle }}</v-card-subtitle>
              <v-card-actions>
                <v-btn
                  v-if="!type.selected"
                  block
                  dark
                  color="primary"
                  depressed
                  @click="selectPaymentAction(type)"
                >
                  Select
                </v-btn>

                <v-btn
                  v-if="type.selected"
                  block
                  dark
                  color="primary"
                  depressed
                  outlined
                  @click="selectPaymentAction(type)"
                >
                  Unselect
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-card>

          <v-btn
            color="primary"
            :disabled="!has_selected_payment"
            @click="generatePaymentIntent()"
          >
            Continue
          </v-btn>

          <v-btn @click="e1 = e1 - 1" text>
            Go back
          </v-btn>
        </v-stepper-content>

        <v-stepper-content class="last-stepper" step="3">
          <v-card elevation="0" class="mb-6 stepper">
            <h4>Amount: {{ valueFromBackend }} kr</h4>
            <form id="payment-form">
              <div id="card-element"><!--Stripe.js injects the Card Element--></div>
              <button id="submit">
                <div class="spinner hidden" id="spinner"></div>
              </button>
              <p id="card-error" role="alert"></p>
            </form>
            <v-container class="pa-0" fluid>
              <v-checkbox class="ma-0" :ripple="false"  v-model="checkbox" >
                <template v-slot:label>
                  <p class="ma-0 label">I have read and understood <a class="link-inside" @click="$router.push('/about')">Refashioneds policies</a>  and agreements regarding purchasing.</p>
                </template>
              </v-checkbox>
            </v-container>
          </v-card>

          <v-btn 
            :disabled="!checkbox" 
            color="primary" 
            id="button-text" 
            @click="payWithCard()">
            Pay
          </v-btn>

          <v-btn @click="e1 = e1 - 1" text>
            Go back
          </v-btn>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>

    <Loading :loading="loading"/>

    <Dialog
      :title="dialog_title"
      :success="dialog_success"
      :text="dialog_text"
      :dialog="dialog"
      :buttonText="dialog_button"
      @closingDialog="dialog = false"
    />
  </main>
</template>


<script>
const axios = require("axios");
let stripe = window.Stripe(process.env.VUE_APP_STRIPE_PUBL);
import Dialog from "@/components/Dialog.vue";
import Loading from "@/components/Loading.vue";

export default {
  name: "CartInfo",

  data() {
    return {
      finalCart: this.$store.getters.finalCart,

      loading: false,
      dialog: false,
      dialog_title: "",
      dialog_text: "",
      dialog_success: false,
      dialog_button: "",
      valueFromBackend: "",

      shipping_cost: this.$store.getters.shippingData.find(x => x.name == "shippingCost"),
      shipping_bar: this.$store.getters.shippingData.find(x => x.name == "shippingBar"),

      checkbox: false,

      e1: 1,

      validInputs: true,
      has_selected_payment: false,

      emailRules: [
        v => !!v || "E-mail is required",
        v => /.+@.+\..+/.test(v) || "E-mail must be valid"
      ],

      nameRules: [
        v => !!v || "Name is required",
        v => (v && v.length <= 10) || "Name must be less than 10 characters"
      ],

      notEmptyRule: [v => !!v || "Item is required"],

      inputs: [
        { text: "Firstname", model: "firstname" },
        { text: "Lastname", model: "lastname" },
        { text: "Email", model: "email" },
        { text: "Address", model: "address" },
        { text: "Postal", model: "postal" },
        { text: "City", model: "city" },
        { text: "Phone Number", model: "phone" , prefix: "+46"},
      ],

      client_secret: "",

      payment_options: [
        {
          title: "Debit card",
          subtitle: "Select debit card for payment",
          active: false,
          selected: false
        },
        {
          title: "Swish",
          subtitle: "Coming soon!",
          active: true,
          selected: false
        },
        {
          title: "Klarna",
          subtitle: "Coming soon!",
          active: true,
          selected: false
        }
      ],

      firstname: "",
      lastname: "",
      address: "",
      phone: "",
      postal: "",
      city: "",
      email: "",

      card: "",

      selected_payment: ""
    };
  },

  methods: {
    selectPaymentAction(e) {
      e.selected = !e.selected;
      this.selected_payment = e.title;

      this.has_selected_payment = this.payment_options.find(
        o => o.selected == true
      );
    },

    checkInputs(){
      console.log(this.firstname, this.lastname, this.email, this.city, this.phone, this.address, this.postal)
    },

    returnToCart() {
      this.$router.push("/cart");
    },

    giveRules(input) {
      switch (input.model) {
        case "firstname":
          return this.notEmptyRule;
        case "lastname":
          return this.notEmptyRule;
        case "email":
          return this.emailRules;
        case "address":
          return this.notEmptyRule;
        case "postal":
          return this.notEmptyRule;
        case "place":
          return this.notEmptyRule;
      }
    },

    async generatePaymentIntent() {
      if (!this.$refs.form.validate()) {
        return;
      }

      let vue = this;

      axios
        .post(`${process.env.VUE_APP_BACKEND}/create_payment`, {
          product_ids: vue.$store.getters.finalCart.products,
          discount_code: vue.$store.getters.finalCart.discount
        })
        .then(function(resp) {
          console.log(resp.data);
          vue.client_secret = resp.data.clientSecret;
          vue.valueFromBackend = resp.data.value;
          vue.e1 += 1;

          vue.insertStripeForm();
        })
        .catch(function(error) {
          alert(error);
        });
    },

    insertStripeForm() {
      var elements = stripe.elements();
      var style = {
        base: {
          color: "#141414",
          fontFamily: "Arial, sans-serif",
          fontSmoothing: "antialiased",
          fontSize: "16px",
          "::placeholder": {
            color: "#32325d"
          }
        },
        invalid: {
          fontFamily: "Arial, sans-serif",
          color: "#fa755a",
          iconColor: "#fa755a"
        }
      };

      this.card = elements.create("card", { style: style });

      // Stripe injects an iframe into the DOM
      this.card.mount("#card-element");

      this.card.on("change", function(event) {
        // Disable the Pay button if there are no card details in the Element
        document.querySelector("button").disabled = event.empty;
        document.querySelector("#card-error").textContent = event.error
          ? event.error.message
          : "";
      });

    },

    payWithCard() {
      this.loading = true;
      let card = this.card;
      let clientSecret = this.client_secret;
      let vue = this;
      stripe
        .confirmCardPayment(clientSecret, {
          receipt_email: vue.email,
          payment_method: {
            card: card,
            billing_details: {
              name: `${vue.firstname} ${vue.lastname}`,
              email: vue.email,
              phone: `+46${vue.phone}`,
              address: {
                city: vue.city,
                postal_code: vue.postal,
                line1: vue.address
              }
            }
          }
        })
        .then(function(result) {
          if (result.error) {
            // Show error to the customer
            vue.dialog_text = result.error.message;
            vue.dialog_title = "Error";
            vue.dialog_success = false;
            vue.dialog_button = "I understand";
          } else {

            axios.post(`${process.env.VUE_APP_BACKEND}/orders`, {
              products: vue.$store.getters.cart,
              order: {
                city: vue.city,
                address: vue.address,
                email: vue.email,
                phone: vue.phone,
                firstname: vue.firstname,
                lastname: vue.lastname,
                postal: vue.postal,
                tracking: "",
              },
              discount_code: vue.finalCart.discount['code'],
            })
            .then(function(){
              // The payment succeeded!
              vue.dialog_text = "Yay! The purchase went through! You will recieve an email shortly with the reciept. When the order leaves our warehouse, you will recieve an email about the tracking information!";
              vue.dialog_title = "Purchase completed!";
              vue.dialog_success = true;
              vue.dialog_button = "Great!";
              vue.removeItemsFromStore();
            })
            .catch(function(error){
              console.log(error)
            })

          }

          vue.loading = false;
          vue.dialog = true;
          vue.resetCart();
          // vue.$router.push("/")
        });
    },

    removeItemsFromStore(){
      let product_ids = this.finalCart.products;
      console.log("asdasd", this.finalCart.products)
      for(let p of product_ids){
        this.$store.commit('disableProduct', p)
      }
    },

    nextStepper() {
      if (this.$refs.form.validate()) {
        this.e1 += 1;
      }
    },

    resetCart(){
      this.$store.commit("resetCart")
    }
  },

  computed: {
    validatedInputs() {
      // this.inputs.reduce(p => p.)

      return false;
    },

    dicounted_value(){
      // TODO: Enable free shipping
      let value;

      console.log(this.finalCart.discount.type)

      switch(this.finalCart.discount.type){
        case "percent": value = (this.finalCart.price_without_discount * (1.0 - (this.finalCart.discount.value / 100.0)));break;
        case "cash": value = this.finalCart.price_without_discount - this.finalCart.discount.value;break;
        case "shipping": value = this.finalCart.price_without_discount - this.shipping_cost.value;break;
        default : value = this.finalCart.price_without_discount;break;
      }

      return value + this.shipping_cost.value
    }
  },

  created(){
    if(this.$store.getters.finalCart.length == 0){
      this.$router.go(-1)
    }
  },

  components: {
    Dialog,
    Loading
  }
};
</script>

<style lang="scss" scoped>
.stepper {
  height: 50vh;
  overflow-y: scroll;
}

#card-element {
  border-radius: 4px 4px 0 0 ;
  padding: 12px;
  border: 1px solid rgba(50, 50, 93, 0.1);
  height: 44px;
  width: 100%;
  background: white;
}




</style>
