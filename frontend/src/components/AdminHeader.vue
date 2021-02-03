<template>
  <section>
        <v-app-bar color="white">
            <v-app-bar-nav-icon color="black" @click="menu = true"></v-app-bar-nav-icon>
        </v-app-bar>
        <v-navigation-drawer color="white" v-model="menu" absolute temporary>
        <v-list nav dense >
            <v-list-group
            :color="randomColor()"
            v-for="item in items"
            :key="item.title"
            v-model="item.active"
            :prepend-icon="item.icon"
            append-icon=""
            class="no-mb"
            no-action
            >
            <template v-slot:activator>
                <v-list-item-content color="#00BFFF">
                <v-list-item-title class="specify_color" @click="reRoute(item)" >{{ item.title }}</v-list-item-title>
                </v-list-item-content>
            </template>
                <v-list-item
                v-for="child in item.items"
                :key="child.title"
                >
                <v-list-item-content>
                    <v-list-item-title class="blue--text" @click="$router.push(child.link).catch(()=>{})" v-text="child.title"></v-list-item-title>
                </v-list-item-content>
                </v-list-item>
            </v-list-group>

        </v-list>
        </v-navigation-drawer>
  </section>
</template>

<script>
export default {
    name: "AdminHeader",
    data(){
        return{
            menu: false,
            items: [
                {title: "View messages", link: "/admin/msgs", icon: "mdi-message"},
                {title: "View orders", link: "/", icon: "mdi-cart"},
                {title: "View sell requests", link: "/", icon: "mdi-cash-multiple"},
            ],
            colors: ["blue", "yellow", "green", "orange", "purple", "white", "red"]
        }
    },

    methods: {
        randomColor(){
            return this.colors[Math.floor(Math.random() * this.colors.length)]
        },
        reRoute(item){
            if(item.items == undefined){this.$router.push(item.link).catch(()=>{})}
        },
    }
}
</script>

<style lang="scss">
i.v-icon, .specify_color{
    color: rgb(40,40,40) !important;
}  
</style>