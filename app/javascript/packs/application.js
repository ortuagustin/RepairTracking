import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import VueSweetalert2 from 'vue-sweetalert2';
import axios from 'axios';
import DeleteButton from '../DeleteButton.vue';

Vue.use(TurbolinksAdapter);
Vue.use(VueSweetalert2);

window.axios = axios;

document.addEventListener('turbolinks:load', () => {
  window.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const app = new Vue({
    el: '#app',

    components: { DeleteButton }
  })
})