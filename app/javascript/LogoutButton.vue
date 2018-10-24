<template>
  <a href="#!" @click.prevent="clicked">
    <slot></slot>
  </a>
</template>

<script>
export default {
  props: ['url', 'title', 'text', 'type', 'confirm-button', 'cancel-button'],

  methods: {
    clicked() {
      swal({
        title: this.title,
        type: this.type,
        showCancelButton: true,
        // confirmButtonColor: "#3085d6",
        // cancelButtonColor: "#d33",
        confirmButtonText: this.confirmButton,
        cancelButtonText: this.cancelButton,
      }).then(result => {
        if (result.value) {
          axios.get(this.url).then((data) => location.href = 'http://localhost:3000')
        }
      });
    }
  }
};
</script>