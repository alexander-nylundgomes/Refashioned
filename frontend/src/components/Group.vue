<template>
    <v-card
      class="ma-auto mt-5 cardCat"
    >
      <v-card-title>{{ title }}</v-card-title>
      <v-card-subtitle>{{ desc }}</v-card-subtitle>
      <v-img lazy :src="img_path" class="image"></v-img>
      <v-card-actions>
        <router-link class="link full-width" :to="link">
          <v-btn large depressed block color="primary" class="ma-0"
            >See products</v-btn
          >
        </router-link>
      </v-card-actions>
    </v-card>
</template>

<script>
export default {
    name: "Group",
    props: ['title', 'link', 'desc', 'img_path']
}
</script>

<style lang="scss" scoped>
.image {
  width: 90%;
  margin: 0 auto;
  height: 15rem;
}

.full-width {
  width: 100%;
}

.cardCat {
  height: fit-content;
  width: 90%;
}
</style>