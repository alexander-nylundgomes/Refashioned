<template>
  <main class="about">
    <h1 class="mb-3 mt-3">We are Refashioned.</h1>
    <p class="text">
      The Refashioned way is all about giving new life to used items. Our vision
      is to contribute to a sustainable future while simultaneously providing
      our customers with satisfying products.
    </p>

    <h2 class="section-text">Our core values</h2>
    <div class="cards">
      <v-card lazy>
        <v-card-title>Inclusiveness</v-card-title>
        <v-card-subtitle>For a more united tomorrow</v-card-subtitle>
        <v-card-text>
          We refer to the fit of our clothing in measurements together with the
          given size. Not categorizing our clothing into gender is an active
          choice. We believe that everyone should be able to wear whatever they
          want no matter who they are. By doing this we hope to progress in the
          fashion industry towards a more inclusive direction.
          <br /><br />Towards a more united tomorrow.
        </v-card-text>
      </v-card>

      <v-card lazy>
        <v-card-title>Ecological</v-card-title>
        <v-card-subtitle>For a more sustainable tomorrow</v-card-subtitle>
        <v-card-text>
          According to EPA office of Solid Waste US, it's estimated that we
          throw aray 30 kg of clothes a year, per person. The most common waste
          disposals of clothes are landfills in poor countries, abandoned or
          burnt. We want to change this. All of our clothes are second-hand
          items, ensuring full reclyment of clothes that instead would end up in
          landfills. All of the clothes that don't get sold, are given away to
          responsible charities.
          <br /><br />
          We inspect each item that goes through our warehouse, carefully and
          througly, for grime. Because our supplier ensures clean clothes, we
          only wash the items that not reach our high standards in order to save
          water and energy. When, however we do wash clothing, we do it with
          sustainable, non-toxic and allergy friendly washing detergent.
        </v-card-text>
      </v-card>

      <v-card lazy>
        <v-card-title>Authenticity</v-card-title>
        <v-card-subtitle>For a more original tomorrow</v-card-subtitle>
        <v-card-text>
          All of our clothes are checked twice in the supply chain. First, our
          supplier authenticates and quality checks our clothing. Then, one of
          our experts further inspects the clothing before the clothing is
          published on our website. With this procedure, we can always guarantee
          100% authenticity.
        </v-card-text>
      </v-card>
    </div>

    <h2 class="section-text">FAQ</h2>

    <v-expansion-panels focusable class="pa-3 pt-0">
      <v-expansion-panel v-for="qa in faq" :key="qa.q">
        <v-expansion-panel-header class="expansion-header-text">
          {{ qa.q }}
        </v-expansion-panel-header>
        <v-expansion-panel-content class="expansion-panel-text">
          {{ qa.a }}
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>

    <h2 class="section-text">Our policies</h2>
    <h4>Return policy</h4>
    <p class="policy">
      If an item should be not as described or faulty in any other way, you get
      your money back. In order to get a full refund, the tag must be intact and
      the clothing must also have retained its condition. The customer is also
      responsible for the shipping costs during returns.
    </p>

    <h4>Buying from us</h4>
    <p class="policy">
      Lorem ipsum dolor sit amet consectetur, adipisicing elit. Numquam, iusto error? Exercitationem corrupti doloremque, in non animi, alias recusandae maxime veritatis, itaque quos vitae nihil. Perferendis nesciunt unde animi pariatur!
    </p>

    <h4>Selling to us</h4>
    <p class="policy">
      Lorem ipsum, dolor sit amet consectetur adipisicing elit. Neque necessitatibus unde omnis! Laudantium quo, quia sequi consequuntur atque accusantium ut. A corrupti ad id quibusdam debitis mollitia autem esse labore!
    </p>
  </main>
</template>

<script>
export default {
  name: "About",
  data() {
    return {
      faq: [
        {
          q: "My shipment is lost in transit! What now?",
          a:
            "We rely on Postnord to ship you order to you. Therefore, when the package leaves our warehouse, it's in their hands. If the package is lost, please contact Postnord for resolving the issue."
        },
        {
          q: "My order is damaged/non-authentic! Can I get a refund?",
          a:
            "All of the clothes in our stock is expertly authenticated in two separate places of the supply chain: first at our supplier, and again by us. If however, a piece of clothing is damaged/non-authentic we do offer a full refund provided you still have the reciept. Please contact us either my our mail: , or by our contact page."
        },
        {
          q:
            "I'm sensitive towards laundry detergent. Can I safely buy from you?",
          a:
            "Yes! When we wash our clothing, we do it in non-toxic, enviroment friendly and allergy friendly laundry detergent. If, however, you are sensitive towards laundry detergent, we do recommend you washing it once again, in your standard washing routine."
        }
      ]
    };
  }
};
</script>

<style lang="scss">
main.about {
  padding: 0.5em;

  h1 {
    width: 100%;
    text-align: center;
  }

  h2.section-text {
    width: 100%;
    text-align: center;
    margin: 1em 0;
  }

  p.policy,
  h4 {
    padding: 0 0.5em;
  }

  p.policy {
    font-size: 0.75em;
  }

  p.text {
    width: 85%;
    margin: 0 auto;
    text-align: center;
  }

  .cards {
    width: 95%;
    margin: 1rem auto;

    > * {
      margin: 1rem 0;
    }
  }

  .expansion-header-text {
    line-height: 1.4;
    font-size: 0.75em;
  }

  .expansion-panel-text {
    font-size: 0.75em;
    padding-top: 1em;
  }
}
</style>
