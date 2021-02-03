<template>
  <main class="contact">
      <div class="main-text">
        <h2>Get in touch with us!</h2>
        <p> No matter if there's an issue with your order, you have a question or something to discuss, we're always glad to hear from you! Get in touch with us through the form below.</p>
      </div>
      <v-divider class="ml-5 mr-5 mb-3"></v-divider>
      <v-form class="pa-4" ref="form" lazy-validation v-model="valid">
          <v-text-field :rules="notEmptyRule" v-model="firstname" outlined label="Firstname" dense></v-text-field>
          <v-text-field :rules="notEmptyRule" v-model="lastname" outlined label="Lastname" dense></v-text-field>
          <v-text-field :rules="notEmptyRule" v-model="phone" outlined label="Phone" prefix="+46" dense></v-text-field>
          <v-text-field :rules="emailRules" v-model="email" outlined label="Email" dense></v-text-field>
          <v-select :items="subjects" v-model="subject" dense outlined label="Subject"></v-select>
          <v-textarea :rules="notEmptyRule" v-model="msg" outlined label="Message" dense></v-textarea>
          <v-checkbox v-model="agreed">
            <template v-slot:label>
              <p class="ma-0 label">I have read and understood <a class="link-inside" @click="$router.push('/about')">Refashioneds policies</a>  and agreements regarding sending messages to Refashioned.</p>
            </template>
          </v-checkbox>
          <v-btn :disabled="!agreed" @click="sendMessage()" block large depressed color="primary" class="white--text">Send message</v-btn>
      </v-form>
  </main>
</template>

<script>
const axios = require("axios");

export default {
  name: "Contact",
  data(){
    return{
      valid: true,
      firstname: "",
      lastname: "",
      email: "",
      phone: "",
      msg: "",
      subject: "",
      agreed: false,
      subjects: ["Order", "Question", "Damaged items", "Wrong items", "Something else"],

      emailRules: [
        v => !!v || "E-mail is required",
        v => /.+@.+\..+/.test(v) || "E-mail must be valid"
      ],

      notEmptyRule: [v => !!v || "Item is required"],
    }
  },

  methods: {
    sendMessage(){
      if(!this.$refs.form.validate()){
        return
      }

      let vue = this;
      axios.post(`${process.env.VUE_APP_BACKEND}/msgs`,{
        msg: {
          msg: vue.msg,
          subject: vue.subject,
          firstname: vue.firstname,
          lastname: vue.lastname,
          phone: vue.phone,
          email: vue.email,
        }
      })
      .then(function(resp){
        console.log(resp)
      })
      .catch(function(error){
        console.log(error)
      })
    }
  }
}
</script>

<style lang="scss">

</style>
