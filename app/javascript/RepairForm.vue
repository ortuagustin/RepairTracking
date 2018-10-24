<script>
export default {
  props: ["data-repair", "dataErrors", "dataSelectedCustomer", "url"],

  data() {
    return {
      errors: [],
      repair: null
    };
  },

  mounted() {
    this.repair = JSON.parse(this.dataRepair);
    this.errors = JSON.parse(this.dataErrors);

    if (this.dataSelectedCustomer != '' ) {
      this.repair.customer = JSON.parse(this.dataSelectedCustomer);;
    }
  },

  methods: {
    submit() {
      axios
        .post(this.url + ".json", this.formData())
        .then(response => location.href = `${this.url}/${response.data.code}`)
        .catch(response => this.errors = response.data);
    },

    error(field) {
      return this.errors[field][0] || "";
    },

    hasError(field) {
      const fieldErrors = this.errors[field];

      return fieldErrors && fieldErrors.length > 0;
    },

    clearError(field) {
      this.errors[field] = "";
    },

    formData() {
      return {
        customer_id: this.selectedCustomer(),
        artifact_id: this.selectedArtifact(),
        estimated_days: this.repair.estimated_days
      };
    },

    selectedCustomer() {
      if (this.repair.customer) {
        return this.repair.customer.value;
      }

      return null;
    },

    selectedArtifact() {
      if (this.repair.artifact) {
        return this.repair.artifact.value;
      }

      return null;
    },
  }
};
</script>
