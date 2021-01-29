<template>
  <main class="sell-to-us">
      <h2 class="title-main">Sell your clothes <br> to us</h2>
      <p>Fill out the form with a picture of the clothing and we'll come back to you with a fair appraisal from one of our experts!</p>

      <v-form lazy-validation ref="form" v-model="valid" class="pl-4 pr-4">
          <v-text-field required :rules="notEmptyRule"   v-model="firstname" label="Firstname" outlined dense></v-text-field>
          <v-text-field required :rules="notEmptyRule"   v-model="lastname" label="Lastname" outlined dense></v-text-field>
          <v-text-field required :rules="emailRules.concat(notEmptyRule)"   v-model="email" label="Email" outlined dense></v-text-field>
          <v-text-field required :rules="notEmptyRule" prefix="+46"  v-model="phone" label="Phone" outlined dense></v-text-field>
          <v-text-field required :rules="notEmptyRule"   v-model="brand" label="Brand" outlined dense></v-text-field>
          <v-subheader>Condition: {{conditions[condition]}}</v-subheader>
          <v-slider v-model="condition" ticks="always" tick-size="4" max="10" min="0"></v-slider>
          <v-file-input
            required
            :prepend-icon="''"
            v-model="file"
            label="Select a image"
            outlined
            clearable
            dense
            :rules="fileRules.concat(notEmptyRule)"
          ></v-file-input>
          <v-text-field :rules="notEmptyRule.concat(onlyNumbers)" suffix="kr" v-model="asking_price" label="Asking price" outlined dense></v-text-field>
          <v-checkbox required v-model="agree" label="I have read and agreed with Refashioneds policies regarding selling items."></v-checkbox>
          <v-btn @click="sendRequest()" block :disabled="accepted" color="primary" large class="mb-4">Send sell request</v-btn>
      </v-form>

      <Loading 
        :loading="loading"
      />

      <Dialog 
        :dialog="dialog"
        :title="dialog_title"
        :text="dialog_text"
        :buttonText="dialog_buttonText"
        :success="dialog_success"
      />
  </main>
</template>

<script>
const axios = require("axios");
import Dialog from "@/components/Dialog.vue";
import Loading from "@/components/Loading.vue";

export default {
    name: "SellToUs",

    data(){
        return{
            dialog: false,
            dialog_title: "",
            dialog_text: "",
            dialog_buttonText: "",
            dialog_success: false,

            emailRules: [
                v => !!v || "E-mail is required",
                v => /.+@.+\..+/.test(v) || "E-mail must be valid"
            ],

            onlyNumbers: [
                v => /^[0-9]*$/.test(v) || "Only numbers is allowed"
            ],

            nameRules: [
                v => !!v || "Name is required",
                v => (v && v.length <= 10) || "Name must be less than 10 characters"
            ],

            notEmptyRule: [v => !!v || "Item is required"],

            loading: false,

            valid: false,
            condition: 7,
            conditions: [
                'Absolute garbage',
                'Pretty bad',
                'Bad',
                'Not to bad',
                'Decent',
                'OK',
                'Pretty good',
                'Great',
                'Really good',
                'Amazing',
                'Never been worn',
            ],
            file: null,
            agree: false,
            firstname: "",
            lastname: "",
            email: "",
            phone: "",
            brand: "",
            asking_price: "",
            fileRules: [
                file => !file || file.size < 1024 * 1024 * 0.5 || 'Image must be smaller than 0.5 MB'
            ]
        }
    },

    methods: {
        sendRequest(){
            if(!this.$refs.form.validate()){
                return
            }

            let vue = this;
            this.loading = true;

            let formData = new FormData();
            let sell_request = {
                firstname: vue.firstname,
                lastname: vue.lastname, 
                email: vue.email,
                phone: '+46' + vue.phone,
                brand: vue.brand, 
                condition: vue.conditions[vue.condition],
                asking_price: vue.asking_price,
            }

            formData.append("image", this.file);
            formData.append("sell_request", JSON.stringify(sell_request));

            axios.post(`${process.env.VUE_APP_BACKEND}/sell_requests`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data'
                },
            })
            .then(function(){
                vue.dialog_title = "Success!"
                vue.dialog_text = "You're one step closer to getting paid! We will contact you by email regarding the sell request with an offer if we're interested. In the mean time, why don't you look at some other great clothes!"
                vue.dialog_buttonText = "Okay!"
                vue.dialog_success = true
            })
            .catch(function(error){
                console.log(error)
                vue.dialog_title = "Uh oh!"
                vue.dialog_text = "Something happend while sending your sell request! Try again, or contact us via our contact page."
                vue.dialog_buttonText = "Okay!"
                vue.dialog_success = false
            })
            vue.loading = false;
            vue.dialog = true;
        }
    },

    computed: {
        accepted(){
            // Returns reverse because of disabled property
            if(this.agree){
                console.log('asdasd')
                return false
            }else{
                return true
            }
        }
    },  

    components: {
        Dialog,
        Loading
    }
}

        Loading</script>

<style lang="scss" scoped>
    main.sell-to-us{
        overflow-x: hidden;
    }

    .title-main{
        text-align: center;
        margin: 1em 0 0.25em 0;
        padding: 0 1.25em;
        font-size: 2em;
        line-height: 1.3;
    }

    p{
        text-align: center;
        padding: 0 1.25rem;
        margin: 0 0 2em 0;
    }
</style>