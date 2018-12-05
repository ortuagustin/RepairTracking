<template>
  <a class="btn" :class="btnClass" :href="url">
    <slot></slot>
  </a>
</template>

<script>
export default {
  props: {
    url: { type: String, required: true },
  },

  methods: {
    currentUrl() {
      return new URL(location.href);
    },

    buttonUrl() {
      return new URL(this.url);
    },
  },

  computed: {
    btnClass: function() {
      if (location.href === this.url) {
        return "btn-primary";
      }

      return "btn-outline-primary";
    },
  },
};
</script>