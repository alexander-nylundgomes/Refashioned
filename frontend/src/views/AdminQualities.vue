<template>
  <main class="qualities">
      <AdminQuality 
      :quality="quality" 
      v-for="quality of qualities" 
      :key="quality.id" 
      @destroy="destroyed($event)"
      @update="updated($event)"
       />
      <Snackbar :snackbar="snackbar" :snackbarText="snackbarText" @closeSnackbar="snackbar = false" />
  </main>
</template>

<script>
import Snackbar from "@/components/Snackbar.vue"
import AdminQuality from "@/components/AdminQuality.vue"
export default {
    name: "AdminQualities",

    data(){
        return{
            snackbar: false,
            snackbarText: "",
        }
    },

    methods: {
        destroyed(e){
            let q = this.qualities.find(q => q.id == e)
            let index = this.qualities.indexOf(q);
            this.qualities.splice(index, 1)

            this.snackbarText = "Quality was successfully deleted!"
            this.snackbar = true;
        },

        updated(e){
            this.snackbarText = "Quality was successfully updated!"
            this.snackbar = true;
            this.$store.commit("updateQualities", e)
        }
    },

    computed: {
        qualities(){
            return this.$store.getters.qualities;
        },
    },

    mounted(){
        console.log(this.qualities)
    },

    components: {
        AdminQuality,
        Snackbar
    }
}
</script>

<style lang="scss" scoped>

</style>