<template>
  <a v-if="! sending" class="m-2 btn btn-outline-info" href="#!" @click.prevent="enviarMail()">
    <i class="fas fa-at"></i>
    <span class="ml-1">Enviar por e-mail</span>
  </a>
  <div v-else class="m-2 btn btn-info disabled">
    <i class="fas fa-circle-notch fa-spin"></i>
    <span class="ml-1">Enviando</span>
  </div>
</template>

<script>
export default {
  data() {
    return {
      sending: false,
    }
  },

  methods: {
    enviarMail() {
      this.sending = true;

      setTimeout(() => this.sending = false, 3000);
    },
  },
};
</script>