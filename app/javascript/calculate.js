function commission() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener('keyup', () => {
      const itemCommission = Math.floor(itemPrice.value * 0.1);
      const userProfit = Math.floor(itemPrice.value - itemCommission);
      const addTaxPrice = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      addTaxPrice.innerHTML = itemCommission;
      profit.innerHTML = userProfit;
    });
};

window.addEventListener('load', commission);