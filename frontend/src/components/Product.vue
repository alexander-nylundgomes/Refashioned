<template>
    <v-card width="200"  class="product-card ml-2 mr-2">
        <div class="img-replace"></div>
        <v-card-title class="pa-1 pl-2 pr-2" :class="{'changed-title': $vuetify.breakpoint.xs}">
            <p class="ma-0 limited-p" :class="{'changed-title': $vuetify.breakpoint.xs}">{{ refactor(name, 14) }}</p>
            
            <v-spacer></v-spacer>
            <p class="ma-0" :class="{'changed-title': $vuetify.breakpoint.xs}">{{ price }} kr</p>
        </v-card-title>
        <v-card-subtitle class="pa-1 pl-2 pr-2" :class="{'changed-subtitle': $vuetify.breakpoint.xs}"> {{ brand }} </v-card-subtitle>
        <v-card-text class="pa-1 pl-2 pr-2" :class="{'changed-text': $vuetify.breakpoint.xs}">{{ refactor(text, 80) }}  </v-card-text>
        <v-divider></v-divider>
        <v-card-actions>
            <v-btn depressed small color="primary" block class="pl-3 pr-3" :class="{'changed-buttons': $vuetify.breakpoint.xs}">Gå till vara</v-btn>
        </v-card-actions>
    </v-card>
</template>
<script>
export default {
    name: "Product",
    props: ['name', 'text', 'price', 'brand'],
    methods: {
        refactor(text, number){
           let refactoredText = text.substring(0, number);
            if(refactoredText != text){
                return refactoredText + '...'
            }else{
                return refactoredText
            }
        }
    }
}
</script>

<style lang="scss" scoped>
    .img-replace{
        background-color: lightgray;
        width: 100%;
        height: 12.5rem;
    }

    .limited-p{
        max-width: 75%;
        white-space: nowrap;
    }

    .product-card{
        overflow: hidden;
        display: inline-block;
    }

    .changed-title{
        font-size: 1em !important;
    }

    .changed-subtitle{
        font-size: 0.75em !important;
    }

    .changed-text{
        font-size: 0.5em !important;
        line-height: 1.6;
    }
    
    .changed-buttons{
        font-size: 0.6em !important;
    }
</style>