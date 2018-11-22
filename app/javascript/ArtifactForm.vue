<script>
export default {
  props: ["dataArtifact", "dataCustomerId", "dataErrors", "goToRepair", "artifactsUrl", "repairsUrl"],

  data() {
    return {
      errors: [],
      artifact: null,
      customerId: null,
    };
  },

  mounted() {
    this.artifact = JSON.parse(this.dataArtifact);
    this.errors = JSON.parse(this.dataErrors);

    if (this.dataCustomerId != '') {
      this.customerId = JSON.parse(this.dataCustomerId);
    }
  },

  methods: {
    submit() {
      console.log(this.url());

      axios[this.httpMethod()](this.url(), this.artifact)
        .then(response => this.handleSuccess(response.data))
        .catch(response => this.errors = response.data);
    },

    httpMethod() {
      return this.isEditing() ? 'patch' : 'post';
    },

    url() {
      if (this.isEditing()) {
        return `${this.artifactsUrl}/${this.artifact.id}.json`;
      }

      return `${this.artifactsUrl}.json`;
    },

    isEditing() {
      return this.artifact.id != null;
    },

    handleSuccess(artifactData) {
      if ((this.goToRepair) && (! this.isEditing())) {
        let newUrl = new URL(this.repairsUrl);

        newUrl.searchParams.append('go_to_repair', true);
        newUrl.searchParams.append('artifact_id', artifactData.id);

        if (this.customerId) {
          newUrl.searchParams.append('customer_id', this.customerId);
        }

        location.href = newUrl.toString();
      } else {
        location.href = this.artifactsUrl;
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
