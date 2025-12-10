function setupPayjp() {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');

  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');

  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  if (!form) return;

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error(response.error.message);
        return;
      }

      const token = response.id;

      const tokenInput = document.createElement('input');
      tokenInput.setAttribute('type', 'hidden');
      tokenInput.setAttribute('name', 'token');
      tokenInput.setAttribute('value', token);

      form.appendChild(tokenInput);
      form.submit();
    });
  });
}

// 初回読み込み
document.addEventListener('turbo:load', setupPayjp);
// エラー後に再描画された時
document.addEventListener('turbo:render', setupPayjp);