<template>
  <button class="btn btn-outline-success" type="button" @click="clicked">
    <i class="fas fa-check-double"></i>
    <slot></slot>
  </button>
</template>

<script>
export default {
  props: {
    url: { type: String, required: true },
  },

  methods: {
    clicked() {
      swal({
        title: "Finalizar reparación?",
        type: "question",
        showCancelButton: true,
        confirmButtonText: "Si",
        cancelButtonText: "No",
      }).then(result => {
        if (result.value) {
          axios.post(this.url).then((data) => location.reload(true))
        }
      });
    }
  }
};
</script>