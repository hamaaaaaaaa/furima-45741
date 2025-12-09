document.addEventListener('turbo:load', () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();

  // --- カード番号 --
  const numberElement = elements.create('cardNumber');
  numberElement.mount('#number-form');

  // --- 有効期限 ---
  const expiryElement = elements.create('cardExpiry');
  expiryElement.mount('#expiry-form');

  // --- CVC ---
  const cvcElement = elements.create('cardCvc');
  cvcElement.mount('#cvc-form');

  // --- フォーム取得 ---
  const form = document.getElementById('charge-form');

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    // トークン生成
    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error(response.error.message);
        return;
      }

      const token = response.id;

      // hidden_field に token をセット
      const tokenInput = document.createElement('input');
      tokenInput.setAttribute('type', 'hidden');
      tokenInput.setAttribute('name', 'token');
      tokenInput.setAttribute('value', token);

      form.appendChild(tokenInput);

      // フォーム送信
      form.submit();
    });
  });
});