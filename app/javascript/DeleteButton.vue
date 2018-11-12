<template>
  <p class="btn btn-outline-danger" title="Eliminar" @click.prevent="clicked">
    <i class="fas fa-trash-alt"></i>
  </p>
</template>

<script>
export default {
  props: ['url', 'title', 'text', 'type', 'confirm-button', 'cancel-button'],

  methods: {
    clicked() {
      swal({
        title: this.title,
        html: this.text,
        type: this.type,
        showCancelButton: true,
        // confirmButtonColor: "#3085d6",
        // cancelButtonColor: "#d33",
        confirmButtonText: this.confirmButton,
        cancelButtonText: this.cancelButton,
      }).then(result => {
        if (result.value) {
          axios.delete(this.url).then((data) => location.reload(true))
        }
      });
    }
  }
};
</script>