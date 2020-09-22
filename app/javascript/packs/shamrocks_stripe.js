console.log("Load Shamrocks Stripe")
inititializeStripe = initStripe

function initStripe() {
  var keyHolder = document.getElementById('js-payment-data');
  if (keyHolder) {
    var publishableKey = keyHolder.dataset.publishableKey;
    if (!publishableKey) return;

    var stripe = Stripe(publishableKey);

    // Create an instance of Elements.
    var elements = stripe.elements();

    // Create the Card.
    var card = createCard(elements, stripe);

    handleFormSubmission(elements, card, stripe)
    console.log("Stripe is ready for business");
  }
}

function createCard(elements, stripe) {
  // Create an instance of the card Element.
  var card = elements.create('card', { style: style });

  // Add an instance of the card Element into the `card-element` <div>.
  card.mount('#card-element');

  // Handle real-time validation errors from the card Element.
  card.on('change', function (event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });

  return card;
}

function handleFormSubmission(elements, card, stripe) {
  // Handle form submission.
  var form = document.getElementById('new_registration');
  form.addEventListener('submit', function (event) {
    if (isMoneyOwed()) {
      event.preventDefault();

      stripe.createToken(card).then(function (result) {
        if (result.error) {
          // Inform the user if there was an error.
          var errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          // Send the token to your server.
          stripeTokenHandler(result.token);
        }
      });
    } else {
      form.submit();
    }
  });
}

function isMoneyOwed() {
  var gradeLevelSelector = document.getElementById('registration_grade_level');
  var rawGradeLevelMap = JSON.parse(document.getElementById('js-payment-data').dataset.gradeLevelMap);
  console.log("Grade Level Selector", gradeLevelSelector.value);
  if (gradeLevelSelector.value) {
    var gradeLevel = rawGradeLevelMap[gradeLevelSelector.value];
    console.log("Grade Level Amount", gradeLevel.amount);
    if (gradeLevel.amount > 0) {
      return true;
    }
  }

  var uniformCheckBox = document.getElementById('registration_need_uniform');
  console.log("Uniform check box", uniformCheckBox.value);
  if (uniformCheckBox.value == "1") {
    let jerseySelector = document.getElementById('registration_uniform_jersey_size');
    console.log("Jersey Selector", jerseySelector.value);
    if (jerseySelector.value && jerseySelector.value != '') {
      return true;
    }
    let shortSelector = document.getElementById('registration_uniform_short_size');
    console.log("Short Selector", shortSelector.value);
    if (shortSelector.value && shortSelector.value != '') {
      return true;
    }
  }

  return false;
}

// Submit the form with the token ID.
function stripeTokenHandler(token) {
  // Insert the token ID into the form so it gets submitted to the server
  var form = document.getElementById('new_registration');
  var hiddenInput = document.createElement('input');
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', 'stripeToken');
  hiddenInput.setAttribute('value', token.id);
  form.appendChild(hiddenInput);

  // Submit the form
  form.submit();
}

// Custom styling can be passed to options when creating an Element.
// (Note that this demo uses a wider set of styles than the guide below.)
var style = {
  base: {
    color: '#32325d',
    fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
    fontSmoothing: 'antialiased',
    fontSize: '16px',
    '::placeholder': {
      color: '#aab7c4'
    }
  },
  invalid: {
    color: '#fa755a',
    iconColor: '#fa755a'
  }
};
