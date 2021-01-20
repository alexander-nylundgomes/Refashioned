<template>
    <v-img 
      class="section" 
      spect-ratio="1"
      :src="section.img_path"
      :key="section.link"
      >
      <div class="overlay">
        <h1>{{ section.text }}</h1>

        <router-link class="link" :to="section.link">
          <div class="btn-holder">
            <v-btn
              color="rgba(240,240,240,0.9)"
              depressed
              block
              large
            >See all</v-btn>
          </div>
        </router-link>
      </div>
    </v-img>
</template>

<script>
export default {
    name: "BulkComponent",
    props: ["section"]
}
</script>

<style lang="scss" scoped>
.section {
    width: calc(100% - 1em);
    height: 27rem;
    margin-top: 0.5em;
    background-size: cover;
    background-position: center;

    h1{
      padding: 0.25em;
      font-size: 5rem;
      line-height: 1.2;
      font-weight: 800;
      color: rgba(240,240,240,0.6);
    }
}

.btn-holder{
    width: 90%;
    margin: 1em auto;
}

.overlay{
    background-color: rgb(0,0,0,0.35);
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: space-between;
    flex-direction: column;
}
</style>