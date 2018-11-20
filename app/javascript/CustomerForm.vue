<script>
export default {
  props: ["dataCustomer", "dataErrors", "goToRepair", "customersUrl", "repairsUrl"],

  data() {
    return {
      errors: [],
      customer: null
    };
  },

  mounted() {
    this.customer = JSON.parse(this.dataCustomer);
    this.errors = JSON.parse(this.dataErrors);
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
        location.href = `${this.repairsUrl}/?customer_id=${customerData.id}`
      } else {
        location.href = `${this.customersUrl}/${customerData.id}`;
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
  },
};
</script>
