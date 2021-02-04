<template>
  <main class="discounts">
      <v-card class="ml-2 mr-2 mt-4 mb-6">
          <v-card-title>Create new discount</v-card-title>
          <v-card-subtitle>Something</v-card-subtitle>
          <v-card-text>
              <v-form ref="form" lazy-validate>
                <v-select outlined :rules="[v => !!v || 'Item is required']" required dense @change="changeValueSuffix()" label="Select type" v-model="type" :items="types"></v-select>
                <v-text-field outlined :rules="mustBeNumbers" v-model="discount_amount" dense label="Select amount" suffix="st"></v-text-field>
                <v-text-field outlined :rules="mustBeNumbers" dense v-model="discount_required" label="Select required value" suffix="kr"></v-text-field>
                <v-text-field outlined v-model="discount_value" :rules="percentLimitRules" dense :disabled="selectedShipping" label="Select discount value" :suffix="value_suffix" :value="selectedShipping && '1' || null"></v-text-field>
                <v-text-field outlined :rules="notEmptyRule" v-model="discount_code" dense label="Select discount code"></v-text-field>
              </v-form>
          </v-card-text>
          <v-card-actions>
              <v-btn depressed block color="primary" @click="createDiscount()">Create</v-btn>
          </v-card-actions>
        
        <Snackbar :snackbar="snackbar" :snackbarText="snackbarText" @closeSnackbar="snackbar = false"/>
      </v-card>
      <section class="discounts" v-if="loaded">
        <Discount :discount="discount" v-for="discount of discounts" :key="discount.id" @deletedDiscount="removeDiscount($event)"/>
      </section>
  </main>
</template>

<script>
import Discount from "@/components/Discount.vue";
import Snackbar from "@/components/Snackbar.vue";
const axios = require('axios')
export default {
    name: "AdminDiscounts",

    data(){
        return{
            discounts: [],
            loaded: false,
            snackbar: false,
            snackbarText: "",
            types: [
                {text: 'Percent', value: 1},
                {text: 'Cash', value: 2},
                {text: 'Shipping', value: 3},
            ],
            type: null,

            discount_value: null,
            discount_code: "",
            discount_amount: "",
            discount_required: "",

            value_suffix: "kr",
            selectedShipping: false,
            notEmptyRule: [
                v => !!v || "Item is required",
            ],

            mustBeNumbers: [
                v => !!v || "Item is required",
                v => /^[0-9]*$/.test(v) || "Only numbers accepted"
            ],

            percentLimitRules: [
                v => !!v || "Item is required",
                v => /^[0-9]*$/.test(v) || "Only numbers accepted",
                v => parseInt(v) < 100 && parseInt(v) > 0 || "Must be between 0 and 100"
            ]

        }
    },

    methods: {
        async getDiscounts(){
            let vue = this;
            axios.get(`${process.env.VUE_APP_BACKEND}/discount_codes`)
            .then(function(resp){
                console.log(resp)
                vue.discounts = resp.data
                vue.loaded = true;
            })
            .catch(function(error){
                alert(error)
            })
        },

        createDiscount(){
            if(this.$refs.form.validate()){
                let value_in_cash;
                let value_in_shipping;
                let value_in_percent;
                switch(this.type){
                    case 1: value_in_percent = this.discount_value; break;
                    case 2: value_in_cash = this.discount_value; break;
                    case 3: value_in_shipping = true; break;
                }

                let vue = this;
                axios.post(`${process.env.VUE_APP_BACKEND}/discount_codes`, {
                    discount_code: {
                        code: vue.discount_code,
                        amount: vue.discount_amount,
                        required_value: vue.required,
                        value_in_percent: value_in_percent,
                        value_in_cash: value_in_cash,
                        value_in_shipping: value_in_shipping,
                    }
                })
                .then(function(resp){
                    console.log(resp.data)
                    vue.snackbarText = "The discount was created!"
                    vue.$refs.form.reset();
                })
                .catch(function(error){
                    vue.snackbarText = "Something went wrong! Look at console for more info."
                    console.log(error)
                })

                vue.snackbar = true;
            }
        },

        removeDiscount(e){
            let x = this.discounts.find(e => e.id == e)
            let index = this.discounts.indexOf(x);
            this.discounts.splice(index, 1);
        },

        changeValueSuffix(){
            switch(this.type){
                case 1: this.value_suffix = '%'; this.selectedShipping = false; break;
                case 2: this.value_suffix = 'kr'; this.selectedShipping = false; break;
                case 3: this.value_suffix = 'st'; this.selectedShipping = true; break;
            }
        }
    },

    created(){
        this.getDiscounts();
    },

    components: {
        Discount,
        Snackbar
    }
}
</script>

<style>

</style>