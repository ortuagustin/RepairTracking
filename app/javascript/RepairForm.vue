<script>
export default {
  props: ["dataRepair", "dataErrors", "dataSelectedCustomer", "dataSelectedArtifact", "repairsUrl"],

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
      this.repair.customer = JSON.parse(this.dataSelectedCustomer);
    }

    if (this.dataSelectedArtifact != '' ) {
      this.repair.artifact = JSON.parse(this.dataSelectedArtifact);
    }
  },

  methods: {
    submit() {
      axios
        axios[this.httpMethod()](this.url(), this.formData())
        .then(response => this.handleSuccess(response.data))
        .catch(response => this.errors = response.data);
    },

    httpMethod() {
      return this.isEditing() ? 'patch' : 'post';
    },

    url() {
      if (this.isEditing()) {
        return `${this.repairsUrl}/${this.repair.id}.json`;
      }

      return `${this.repairsUrl}.json`;
    },

    isEditing() {
      return this.repair.id != null;
    },

    handleSuccess(repairData) {
      if (this.isEditing()) {
        location.href = `http://localhost:3000/customers/${this.repair.customer_id}`;
      } else {
        location.href = `${this.repairsUrl}/${repairData.code}`
      }
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
