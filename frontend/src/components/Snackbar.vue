<template>
    <v-snackbar v-model="snackbar">
        {{ snackbarText }}
        <template v-slot:action="{ attrs }">
          <v-btn
            color="white"
            text
            v-bind="attrs"
            @click="$emit('closeSnackbar')"
            :class="{ 'changed-button-alert': $vuetify.breakpoint.xs }"
          >
            Close
          </v-btn>
        </template>
    </v-snackbar>
</template>

<script>
export default {
    name: "Snackbar",
    props: ['snackbar', 'snackbarText']
}
</script>

<style>

</style>