<template>
  <main class="cart-info">
    <v-stepper v-model="e1">
      <v-stepper-header>
        <v-stepper-step
          :complete="e1 > 1"
          step="1"
        >
          Name of step 1
        </v-stepper-step>

        <v-divider></v-divider>

        <v-stepper-step
          :complete="e1 > 2"
          step="2"
        >
          Name of step 2
        </v-stepper-step>

        <v-divider></v-divider>

        <v-stepper-step step="3">
          Name of step 3
        </v-stepper-step>
      </v-stepper-header>

      <v-stepper-items>
        <v-stepper-content step="1"  elevation="0">
          <v-card
            elevation="0"
            class="mb-6 stepper"
          >
            <v-form lazy-validation ref="form" class="pt-3" v-model="validInputs">
              <v-text-field
              v-for="input of inputs"
              :key="input.model"
              :model="input.model"
              outlined
              :rules="giveRules(input)"
              required
              dense 
              class="mt-0 ml-3 mr-3 mb-0"
              :label="input.text">
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

          <v-btn @click="returnToCart();" text>
            Cancel
          </v-btn>
        </v-stepper-content>

        <v-stepper-content step="2">
          <v-card
            elevation="0"
            class="mb-6 stepper"
          >
            <v-card class="ma-3" v-for="type of payment_options" :disabled="type.active" :key="type.title">
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
            @click="nextStepper()"
          >
            Continue
          </v-btn>

          <v-btn @click="e1 = e1 - 1" text>
            Go back
          </v-btn>
        </v-stepper-content>

        <v-stepper-content step="3">
          <v-card
            elevation="0"
            class="mb-6 stepper"
          ></v-card>

          <v-btn
            color="primary"
            @click="nextStepper()"
          >
            Pay
          </v-btn>

          <v-btn @click="e1 = e1 - 1" text>
            Go back
          </v-btn>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>
  </main>
</template>

<script>
export default {
  name: "CartInfo",

  data(){
    return{
      e1: 1,

      validInputs: true,
      has_selected_payment: false,

      emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      ],

      nameRules: [
        v => !!v || 'Name is required',
        v => (v && v.length <= 10) || 'Name must be less than 10 characters',
      ],

      notEmptyRule: [v => !!v || 'Item is required'],

      inputs: [
        {text: "Firstname", model: "firstname"},
        {text: "Lastname", model: "lastname"},
        {text: "Email", model: "email"},
        {text: "Address", model: "address"},
        {text: "Postal", model: "postal"},
        {text: "Place", model: "place"},
      ],

      payment_options: [
        {title: "Debit card", subtitle:"Select debit card for payment", active: false, selected: false},
        {title: "Swish", subtitle:"Coming soon!", active: true, selected: false},
        {title: "Klarna", subtitle:"Coming soon!", active: true, selected: false}
      ],

      firstname: "",
      lastname: "",
      address: "",
      postal: "",
      place: "",
      email: "",

      selected_payment: "",
    }
  },

  methods: {
    selectPaymentAction(e){
      e.selected = !e.selected;
      this.selected_payment = e.title;

      this.has_selected_payment = this.payment_options.find(o => o.selected == true);
    },

    returnToCart(){
      this.$router.push('/cart');
    },

    giveRules(input){
      switch (input.model){
        case "firstname": return this.notEmptyRule;
        case "lastname": return this.notEmptyRule;
        case "email": return this.emailRules;
        case "address": return this.notEmptyRule;
        case "postal": return this.notEmptyRule;
        case "place": return this.notEmptyRule;
      }
    },

    nextStepper(){
      if(this.$refs.form.validate()){
        this.e1 += 1;
      }
    },

  },

  computed: {
    validatedInputs(){
      // this.inputs.reduce(p => p.)

      return false;
    }
  }
}
</script>

<style lang="scss" scoped>

  .stepper{
    height: 50vh;
    overflow-y: scroll;
  }
</style>