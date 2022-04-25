const pay = () => {
  Payjp.setPublicKey("pk_test_d15bb1207eb3d546d07812dd");
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge_form")
  });
};

window.addEventListener("load", pay);