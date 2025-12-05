// document.addEventListener('DOMContentLoaded', () => {
//   const payjp = Payjp('pk_test_xxxxxxxxxxxxxxxxxxxxxx'); 
//   const elements = payjp.elements();

//   const numberElement = elements.create('cardNumber');
//   const expiryElement = elements.create('cardExpiry');
//   const cvcElement = elements.create('cardCvc');

//   numberElement.mount('#number-form');
//   expiryElement.mount('#expiry-form');
//   cvcElement.mount('#cvc-form');

//   const form = document.getElementById('charge-form');

//   form.addEventListener('submit', async (e) => {
//     e.preventDefault();

//     const { token, error } = await payjp.createToken(numberElement);

//     if (error) {
//       alert(error.message);
//       return;
//     }

//     const tokenObj = document.createElement('input');
//     tokenObj.setAttribute('type', 'hidden');
//     tokenObj.setAttribute('name', 'purchase_form[token]');
//     tokenObj.setAttribute('value', token.id);
//     form.appendChild(tokenObj);

//     numberElement.clear();
//     expiryElement.clear();
//     cvcElement.clear();

//     form.submit();
//   });
// });
