<link type="text/css" rel="stylesheet" href="/static/css/login.css">
<div class="login">
    <h2 class="text-center">密码修改</h2>
    <form action="/User/UpdatePasswd/{{.uid}}" method="post">
        <div class="account-input">
            <input name="opassword" id="password" placeholder="旧密码" type="password">
        </div>
        <div class="account-input">
            <input name="npassword" id="password" placeholder="新密码" type="password">
        </div>
        <div class="account-input">
            <input name="rpassword" id="password" placeholder="重复密码" type="password">
        </div>
        <p>{{.msg}}</p>
        <button type="submit">修改</button>
    </form>
</div>

</div>