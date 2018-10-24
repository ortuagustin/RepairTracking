import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import vSelect from 'vue-select'
import axios from 'axios';
import DeleteButton from '../DeleteButton';
import RepairForm from '../RepairForm';

Vue.use(TurbolinksAdapter)
Vue.component('v-select', vSelect);

window.axios = axios;

document.addEventListener('turbolinks:load', () => {
  window.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  window.axios.interceptors.response.use(response => response, function (error) { return Promise.reject(error.response); });

  new Vue({
    el: "#app",
    components: { DeleteButton, RepairForm }
  })
})
