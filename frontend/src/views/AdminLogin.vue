<template>
  <main class="login">
      <v-card class="form">
          <v-card-title>Login</v-card-title>
          <v-card-text>
            <v-text-field outlined dense label="Email"></v-text-field>
            <v-text-field outlined dense label="Password" type="password"></v-text-field>
          </v-card-text>
          <v-divider class="pt-5"></v-divider>
          <v-card-actions>
              <v-btn block large color="primary" @click="login()" dark>Login</v-btn>
          </v-card-actions>
      </v-card>
  </main>
</template>

<script>
export default {
    name: "AdminLogin",

    methods: {
        login(){
            console.log('logging in')
        }
    }
}
</script>

<style lang="scss">
    main.login{
        display: flex;
        justify-content: center;
    }

    .form{
        width: 80%;
        margin-top: 25%;
        height: fit-content;
    }
</style>