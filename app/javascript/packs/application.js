import Vue from 'vue/dist/vue.esm.js';
import VueSweetalert2 from 'vue-sweetalert2';
import vSelect from 'vue-select'
import axios from 'axios';
import DeleteButton from '../DeleteButton';
import RepairForm from '../RepairForm';

Vue.use(VueSweetalert2);
Vue.component('v-select', vSelect);

window.axios = axios;

document.addEventListener('DOMContentLoaded', () => {
  window.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  window.axios.interceptors.response.use(response => response, function (error) { return Promise.reject(error.response); });

  new Vue({
    el: "#app",
    components: { DeleteButton, RepairForm }
  })
})
