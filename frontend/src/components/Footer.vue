<template>
  <v-footer
    dark
    padless
  >
    <v-card
      class="flex"
      flat
      tile
    >
      <v-card-title color="primary">
        <v-container class="d-flex flex-column" align="center" justify="center">
            <v-row>
                <v-col>
                    <strong :class="{'changed-subtitle': $vuetify.breakpoint.xs}">Get connected with us on social networks!</strong>
                </v-col>
            </v-row>
            <v-row>
                <v-col>
                    <div class="buttons">
                        <v-btn
                            v-for="icon in icons"
                            :key="icon"
                            dark
                            icon
                        >
                            <v-icon >
                                {{ icon }}
                            </v-icon>
                        </v-btn>
                    </div>
                </v-col>
            </v-row>
            
        </v-container>

        <v-spacer></v-spacer>

      </v-card-title>

      <v-card-text class="py-2 white--text text-center">
        {{ new Date().getFullYear() }} — <strong>Refashioned</strong>
      </v-card-text>
    </v-card>
  </v-footer>
</template>

<script>
export default {
    name: "Footer",
    data(){
        return{
            icons: [
                'mdi-facebook',
                'mdi-twitter',
                'mdi-linkedin',
                'mdi-instagram',
            ],
        }
    }
}
</script>

<style lang="scss" scoped>
    .buttons{
        width: 100%;
        display: flex;
        justify-content: space-around;
    }
</style>