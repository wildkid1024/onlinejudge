<link type="text/css" rel="stylesheet" href="/static/css/register.css">
<div class="register">
    <h2>OnlineJudge Register</h2>
        <form action="/User/Signup/submit" method="post" class="form-horizontal ">
            <div class="account-input">
                <input name="username" placeholder="Username（字母数字组合 3-20 个字符）" type="text">
            </div>
            <div class="account-input">
                <input name="password" placeholder="Password" type="password">
            </div>
            <div class="account-input">
                <input name="nickname" placeholder="Nickname（字母数字汉字组合 3-20 个字符）" type="text">
            </div>
            <div class="account-input">
                <input name="email" placeholder="Email" type="text">
            </div>
            <div class="account-input">
                <input name="school" placeholder="School" type="text">
            </div>
            <div class="account-input">
                <input name="college" placeholder="College" type="text">
            </div>
            <div class="account-input">
                <input name="major" placeholder="Major" type="text">
            </div>
            <div class="account-input">
                <input name="class" placeholder="Class" type="text">
            </div>

            <button type="submit">Register</button>
    </form>
</div>

	</div>