//メニュー操作
//トグルリスナーを追加して、クリックをリッスンする
document.addEventListener("turbo:load",function(){
    let account = document.querySelector("#account");
    account.addEventListener("click", function(event){
        event.preventDefault();
        let menu = document.querySelector("$dropdown-menu");
        menu.classList.toggle("active");
    });
});

