<template>
  <v-card class="mr-2 ml-2 mb-6 mt-2">
      <v-card-title>Sell request: {{ sr.id }}</v-card-title>
      <v-card-subtitle>{{ sr.brand }} - {{ sr.condition }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
          <p><b>Firstname:</b> {{ sr.firstname }}</p>
          <p><b>Lastname:</b> {{ sr.lastname }}</p>
          <p><b>Email: </b> {{ sr.email }} kr</p>
          <p><b>Phone number: </b> {{ sr.phone }} kr</p>
          <p><b>Sent in: </b> {{ sr.created_at }} kr</p>
          <p><b>Asking price:</b> {{ sr.asking_price }} kr</p>
          <div class="pretend-image">

          </div>
      </v-card-text>
      <v-card-actions>
          <v-btn depressed color="primary" v-if="!seeMore" @click="seeMore = true" block>See more</v-btn>
          <v-btn depressed color="primary" v-if="seeMore" @click="seeMore = false" outlined block>See less</v-btn>
      </v-card-actions>
  </v-card>
</template>

<script>
export default {
    name: "SellRequest",
    props: ['sr'],
    data(){
        return{
            seeMore: false,
        }
    }
}
</script>

<style lang="scss" scoped>
    .pretend-image{
        width: 100%;
        margin: 0 auto;
        height: 15em;
        background-color: lightgray;
    }
</style>