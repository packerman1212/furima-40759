function priceCalculation (){
  const priceInput = document.getElementById('item-price')
  // 入力イベント
  priceInput.addEventListener('input', () => {
    const priceValue = priceInput.value

    // 手数料計算
    const tax = Math.floor(priceValue * 0.1)
    // 利益計算
    const profit = Math.floor(priceValue - tax)

    // 結果を表示
    const addTaxPriceElement = document.getElementById('add-tax-price')
    addTaxPriceElement.textContent = tax

    const profitElement = document.getElementById('profit')
    profitElement.textContent = profit;
  })
  }

window.addEventListener('turbo:load', priceCalculation)
window.addEventListener('turbo:render', priceCalculation)