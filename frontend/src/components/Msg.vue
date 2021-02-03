<template>
    <v-card class="ma-3" :class="{'readMessage' : msg.read}">
        <v-card-title class="message-text">Message: {{msg.id}}</v-card-title>
        <v-card-subtitle class="message-text">{{msg.subject}} - {{ msg.firstname }} {{ msg.lastname }}</v-card-subtitle>
        <v-card-text class="message-text" v-if="!hidden">
            <p> <b>Phone:</b> {{ msg.phone || 'No phone' }}</p> 
            <p> <b>Firstname: </b> {{ msg.firstname}}</p> 
            <p> <b>Lastname: </b> {{ msg.lastname}}</p> 
            <p> <b>Email: </b> {{ msg.email }}</p> 
            <p> <b>Sent in: </b> {{ msg.created_at }}</p> 
            <p> <b>Message: </b> {{ msg.msg }}</p> 
        </v-card-text>
        <v-card-actions>
            <v-btn v-if="hidden" small depressed color="primary" class="white--text" @click="hidden = !hidden">See more</v-btn>
            <v-btn v-if="!hidden" small depressed color="primary" class="white--text" outlined @click="hidden = !hidden">See less</v-btn>
            <v-btn v-if="!msg.read" small depressed color="primary" class="white--text" @click="updateReadMessage()">Mark as read</v-btn>
            <v-btn v-if="msg.read" small  depressed color="primary" outlined class="white--text" @click="updateReadMessage()">Mark as unread</v-btn>
        </v-card-actions>

        <v-snackbar v-model="snackbar">
        {{ snackbarText }}
        <template v-slot:action="{ attrs }">
          <v-btn
            color="white"
            text
            v-bind="attrs"
            @click="snackbar = false"
            :class="{ 'changed-button-alert': $vuetify.breakpoint.xs }"
          >
            Close
          </v-btn>
        </template>
      </v-snackbar>
    </v-card>
</template>

<script>
const axios = require("axios");
export default {
    name: "Msg",
    props: ['msg'],
    data(){
        return{
            hidden: true,
            snackbar: false,
            snackbarText: "",
        }
    },

    methods: {
        updateReadMessage(){
            let vue = this;
            
            axios.patch(`${process.env.VUE_APP_BACKEND}/msgs/${vue.msg.id}`, {
                msg: {
                    read: !vue.msg.read
                }
            })
            .then(function(){
                let marked;
                vue.msg.read = !vue.msg.read

                if(vue.msg.read){
                    marked = "unread"
                }else{
                    marked = "read"
                }

                vue.snackbarText = `Message ${vue.msg.id} was successfully marked as ${marked}!`
                vue.snackbar = true;
                vue.$emit('action', vue.msg.id)
            })
            .catch(function(error){
                console.log(error)
                vue.snackbarText = `Something went wrong...`
                vue.snackbar = true;
            })
        }
    }
}
</script>

<style lang="scss" scoped>
.readMessage{
    background-color: lightgray;
    .message-text{
        color: gray;
    }
}
</style>