<template>
  <a class="btn btn-outline-danger" :class="{ 'disabled' : ! filtered }" href="#!" title="Eliminar filtro" @click.prevent="clearFilter()">
    <i class="fas fa-times-circle"></i>
  </a>
</template>

<script>
export default {
  computed: {
    filtered: function() {
      if (! this.currentUrl().searchParams.has('q')) {
        return false;
      }

      return this.currentUrl().searchParams.get('q').length > 0;
    },
  },

  methods: {
    clearFilter() {
      let newUrl = this.currentUrl();
      newUrl.searchParams.delete('q');

      location.href = newUrl;
    },

    currentUrl() {
      return new URL(location.href);
    },
  }
}
</script>
