<div class="container">
    <form action="/User/UpdateInfo/{{.user.Uid}}" method="post">
    <div class="block block-info" style="padding-top:40px;"></div>
    <div class="row" style="margin-bottom: 45px;">
        <div class="col-md-12">
            <div class="col-md-4" style="text-align: center;">
                                </div>
        <div class="col-md-4">
        {{with .user}}
            <h4 class="text-primary">User name:&nbsp;&nbsp;<small>{{.Username}}</small></h4></h4>
            <h4 class="text-warning">Nick name:&nbsp;&nbsp;<small><input name="nickname" value="{{.Nickname}}" ></small></h4>
            <h4 class="text-success">School:&nbsp;&nbsp;<small><input name="school"  value="{{.School}}"></small></h4>
            <h4 class="text-primary">College:&nbsp;&nbsp;<small><input value="{{.College}}" name="college"  ></small></h4>
            <h4 class="text-info">Major:&nbsp;&nbsp;<small><input value="{{.Major}}" name="major"> </small></h4>
            <h4 class="text-success">Class:&nbsp;&nbsp;<small><input value="{{.Class}}" name="class" ></small></h4>
            <h4 class="text-success">Blog:&nbsp;&nbsp;<small><input value="{{.Blog}}" name="blog" ></small></h4>
            <h4 class="text-success">CodeForces:&nbsp;&nbsp;<small><input value="{{.Codeforces}}" name="Codeforces" ></small></h4>
        </div>
        <div class="col-md-4">
            <h4 class="text-info">Solved:&nbsp;&nbsp;<small>{{.AcceptsCount}}</small></h4>
            <h4 class="text-warning">Submissions:&nbsp;&nbsp;<small>{{.SolutionsCount}}</small></h4>{{end}}
            <h4 class="text-danger">AC Ratio:&nbsp;&nbsp;<small>{{.radio}}</small></h4>
            <h4 class="text-primary">Rank:&nbsp;&nbsp;<small>{{.user.Rank}}</small></h4>
            <h4 class="text-warning">Email:&nbsp;&nbsp;<small>
            {{.user.Email}}																			</small></h4>
            <h4 class="text-muted">Register Time:&nbsp;&nbsp;<small>{{dateformat .user.RegisterTime "2006-01-02 15:04:05"  }}</small></h4>
        </div>
            <div class="col-md-offset-4 col-md-8">
                <h4 id="linked-account-codeforces" class="text-muted hidden">Codeforces:&nbsp;&nbsp;<small id="linked-account-codeforces-info"></small></h4>
            </div>            </div>


    </div>

    <div class="row">
        <div class="col-md-12 text-right" style="padding-top: 10px;padding-bottom: 10px;" id="user-op-buttons">
            <button class="btn btn-default" type="submit">提交修改</button>
            <a class="btn btn-default" href="/User/UpdatePasswd/{{.user.Uid}}">修改密码</a>
        </div>
    </div>

<script>

</script>
    </form>
</div>
