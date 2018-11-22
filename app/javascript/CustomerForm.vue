<script>
export default {
  props: ["dataCustomer", "dataArtifactId", "dataErrors", "goToRepair", "customersUrl", "repairsUrl"],

  data() {
    return {
      errors: [],
      customer: null,
      artifactId: null,
    };
  },

  mounted() {
    this.customer = JSON.parse(this.dataCustomer);
    this.errors = JSON.parse(this.dataErrors);

    if (this.dataArtifactId != '') {
      this.artifactId = JSON.parse(this.dataArtifactId);
    }
  },

  methods: {
    submit() {
      axios[this.httpMethod()](this.url(), this.customer)
        .then(response => this.handleSuccess(response.data))
        .catch(response => this.errors = response.data);
    },

    httpMethod() {
      return this.isEditing() ? 'patch' : 'post';
    },

    url() {
      if (this.isEditing()) {
        return `${this.customersUrl}/${this.customer.id}.json`;
      }

      return `${this.customersUrl}.json`;
    },

    isEditing() {
      return this.customer.id != null;
    },

    handleSuccess(customerData) {
      if ((this.goToRepair) && (! this.isEditing())) {
        let newUrl = new URL(this.repairsUrl);

        newUrl.searchParams.append('go_to_repair', true);
        newUrl.searchParams.append('customer_id', customerData.id);

        if (this.artifactId) {
          newUrl.searchParams.append('artifact_id', this.artifactId);
        }

        location.href = newUrl.toString();
      } else {
        location.href = `${this.customersUrl}/${customerData.id}`;
      }
    },

    error(field) {
      const fieldErrors = this.errors[field];

      return (fieldErrors && this.errors[field][0]) || "";
    },

    hasError(field) {
      const fieldErrors = this.errors[field];

      return fieldErrors && fieldErrors.length > 0;
    },

    clearError(field) {
      this.errors[field] = "";
    },
  },
};
</script>
