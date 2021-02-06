<template>
  <v-card class="ml-2 mr-2">
      <v-card-title>{{ product.name }}</v-card-title>
      <v-card-subtitle>{{ product.cat_name }}</v-card-subtitle>
      <v-card-text v-if="seeMore">
        <v-select :items="sizes" @change="updatePending = true" label="Size..." dense outlined v-model="size"></v-select>
        <v-select :items="[true, false]" @change="updatePending = true" label="Availability" dense outlined v-model="available"></v-select>
        <v-select :items="brands" dense @change="updatePending = true" outlined label="Brand" item-text="name" v-model="brand"></v-select>
        <v-select :items="colors" dense @change="updatePending = true" outlined label="Color" item-text="name" v-model="color"></v-select>
        <v-select :items="qualities" dense @change="updatePending = true" outlined label="Quality" item-text="name" v-model="quality"></v-select>
        <v-text-field dense outlined @change="updatePending = true" label="Name..." :value="product.name"></v-text-field>
        <v-text-field dense outlined @change="updatePending = true" label="Price" suffix="kr" :value="product.price"></v-text-field>
        <v-text-field dense outlined @change="updatePending = true" label="Old price" suffix="kr" :value="product.old_price"></v-text-field>
        <v-textarea outlined dense @change="updatePending = true" label="Description" :value="product.description "></v-textarea>
        <p class="center-text"><b>Created at:</b> {{ product.created_at }}</p>
        <!-- <v-text-field dense outlined label="Available" :value="product.name"></v-text-field> -->
      </v-card-text>
      <v-card-actions>
          <v-btn depressed color="primary" @click="seeMore = !seeMore" :outlined="seeMore" block>{{ seeMore && 'See less' || 'See more'}}</v-btn>
      </v-card-actions>
  </v-card>
</template>

<script>
export default {
    name: "AdminProduct",
    props: ['product', 'qualities', 'colors'],
    
    data(){
        return{
            seeMore: false,
            sizes: ['XSS', 'XS', 'S', 'M', 'L', 'XL', 'XLL'],
            size: this.product.size,
            available: this.product.bought == 0,
            brands: this.$store.getters.brands,
            brand: this.product.brands_name,
            quality: this.product.quality_name,
            color: [],
        }
    },

    methods: {
        firstColor(){
            let color = this.colors.find(p => p.id == this.product.color_id);
            console.log(color)
            this.color = color;
        },
    },

    created(){
        this.firstColor();
    }
}
</script>

<style lang="scss" scoped>
    .center-text{
        text-align: center;
    }
</style>