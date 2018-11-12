<template>
  <a href="#!" @click.prevent="clicked" title="Cerrar Sesión">
    <i class="fas fa-sign-out-alt fa-lg"></i>
  </a>
</template>

<script>
export default {
  props: [ 'logoutUrl', 'redirectUrl' ],

  methods: {
    clicked() {
      axios
        .get(this.logoutUrl)
        .then(() => location.href = this.redirectUrl)
    }
  }
};
</script>