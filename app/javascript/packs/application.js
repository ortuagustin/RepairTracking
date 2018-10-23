import Vue from 'vue/dist/vue.esm.js';
import VueSweetalert2 from 'vue-sweetalert2';
import axios from 'axios';
import DeleteButton from '../DeleteButton';

Vue.use(VueSweetalert2);

window.axios = axios;

document.addEventListener('DOMContentLoaded', () => {
  window.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const app = new Vue({
    el: "#app",
    components: { DeleteButton }
  })
})
