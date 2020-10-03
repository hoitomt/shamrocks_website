// Used ths blog post to configure:
// https://medium.com/@coorasse/goodbye-sprockets-welcome-webpacker-3-0-ff877fb8fa79

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start();

require("packs/shamrocks_stripe")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

import 'jquery';
import 'popper.js';
import 'bootstrap/dist/js/bootstrap';
import 'bootstrap-autocomplete';

$(function () {
  let checkboxValue = $('#registration_need_uniform').val();
  if (checkboxValue == "1") {
    $('#js-uniform-info').show();
  } else {
    $('#js-uniform-info').hide();
  }

  $('#registration_need_uniform').on('change', function () {
    if (this.checked) {
      $('#js-uniform-info').show();
    } else {
      $('#js-uniform-info').hide();
    }
  });

  $('.basicAutoComplete').autoComplete({
    resolverSettings: {
      url: '/registrations/search'
    },
    preventEnter: true,
  });
  $('.basicAutoComplete').on('autocomplete.select', function (evt, item) {
    console.log('Evt', item);
    console.log("Select", item);
    $('#registration_id').val(item.value);
  });
})
