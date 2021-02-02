<template>
  <main class="items">
    <v-sheet
        height="100"
        class="all-sheet sheet"
        color="rgb(240,240,240)"
        flat
        @click="$router.push('/filter')"
    >
        <h3 class="type-sheet pl-2 pr-2"> All {{ itemType }}</h3>
    </v-sheet>
    <v-sheet
        v-for="item of items"
        :key="item.id"
        color="rgb(240,240,240)"
        flat
        height="140"
        width="140"
        class="sheet"
    >

    <router-link :to="`${itemType}/` + item.id" class="link">
        <div 
            v-if="itemType == 'colors'"
            class="circle"
            :style="{backgroundColor: item.color}"    
        >
        </div>

        <h3
            v-if="itemType == 'brands' || itemType == 'categories'"
            class="type-sheet pl-2 pr-2"
        >
        {{ item.name }}
        </h3>
    </router-link>
    </v-sheet>
  </main>
</template>

<script>
export default {
    name: "Colors",
    props: ['itemType', 'link'],

    data(){
        return{
            items: this.$store.getters[this.itemType]
        }
    }
}
</script>

<style lang="scss">
    main.items{
        padding: 2rem;
        display: flex;
        justify-content: space-between;
        align-content: flex-start;
        flex-wrap: wrap;

        >*{
            margin-bottom: 1rem;
        }

        .type-sheet{
            text-align: center;
        }

        .all-sheet{
            width: 100%;
        }

        .sheet{
            >*{
                width: 100%;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                .circle{
                    width: 75%;
                    height: 75%;
                    border-radius: 50%;
                }
            }
        }
    }
</style>