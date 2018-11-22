import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import vSelect from 'vue-select'
import axios from 'axios';
import DeleteButton from '../DeleteButton';
import LogoutButton from '../LogoutButton';
import RepairForm from '../RepairForm';
import CustomerForm from '../CustomerForm';
import ArtifactForm from '../ArtifactForm';
import SendMailButton from '../SendMailButton';

Vue.use(TurbolinksAdapter)
Vue.component('v-select', vSelect);

Vue.mixin({
  methods: {
    goBack() {
      history.back();
    },
  },
});

window.axios = axios;

document.addEventListener('turbolinks:load', () => {
  window.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  if (window.axios.interceptors.response.handlers.length == 0) {
    window.axios.interceptors.response.use(response => response, function (error) { return Promise.reject(error.response); });
  }

  new Vue({
    el: "#app",
    components: { DeleteButton, LogoutButton, RepairForm, CustomerForm, ArtifactForm, SendMailButton },
  })
})
