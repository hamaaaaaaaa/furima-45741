// price という関数を定義
const price = () => {
  // 価格入力欄を取得
  const priceInput = document.getElementById("item-price");
  // 販売手数料表示欄を取得
  const addTaxDom = document.getElementById("add-tax-price");
  // 利益表示欄を取得
  const profitDom = document.getElementById("profit");

  // priceInput が存在する場合のみイベント追加
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;

      if (!isNaN(inputValue) && inputValue > 0) {
        const addTax = Math.floor(inputValue * 0.1);
        const profit = Math.floor(inputValue - addTax);

        addTaxDom.innerHTML = addTax;
        profitDom.innerHTML = profit;
      } else {
        addTaxDom.innerHTML = "";
        profitDom.innerHTML = "";
      }
    });
  }
};

// turbo:load と turbo:render の両方で price 関数を発火
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);