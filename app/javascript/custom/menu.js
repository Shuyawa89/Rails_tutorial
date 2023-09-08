//メニュー操作

//トグルリスナーを追加する
const addToggleListener = (selected_id, menu_id, toggle_class) => {
    let selected_element = document.querySelector(`#${selected_id}`);
    selected_element.addEventListener("click", (event) => {
        event.preventDefault();
        let menu = document.querySelector(`#${menu_id}`);
        menu.classList.toggle(toggle_class);
    });
}

//クリックをリッスンするトグルリスナーを追加する
document.addEventListener("turbo:load", () => {
    addToggleListener("hamburger", "navbar-menu", "collapse");
    addToggleListener("account", "dropdown-menu", "active");
});

//トグルリスナーを追加して、クリックをリッスンする
// document.addEventListener("turbo:load", function () {
//     let hamburger = document.querySelector("#hamburger");
//     hamburger.addEventListener("click", function (event) {
//         event.preventDefault();
//         let menu = document.querySelector("#navbar-menu");
//         menu.classList.toggle("collapse")
//     })

//     let account = document.querySelector("#account");
//     account.addEventListener("click", function (event) {
//         event.preventDefault();
//         let menu = document.querySelector("#dropdown-menu");
//         menu.classList.toggle("active");
//     });
// });


