<div class="container">
    <div class="block block-info" style="padding-top:40px;"></div>
    <div class="row" style="margin-bottom: 45px;">
        <div class="col-md-12">
            <div class="col-md-4" style="text-align: center;">
                <a href="https://cn.gravatar.com/" target="_blank"> <img class="avatar avatar-lg"
                                                                         src="/static/img/photo.png">
                </a></div>
        <div class="col-md-4">
        {{with .user}}
            <h4 class="text-primary">User name:&nbsp;&nbsp;<small>{{.Username}}</small>
            </h4>
            <h4 class="text-warning">Nick name:&nbsp;&nbsp;<small>{{.Nickname}}</small>
            </h4>
            <h4 class="text-success">School:&nbsp;&nbsp;<small>{{.School}}</small>
            </h4>
            <h4 class="text-primary">College:&nbsp;&nbsp;<small>{{.College}}</small>
            </h4>
            <h4 class="text-info">Major:&nbsp;&nbsp;<small>{{.Major}}</small>
            </h4>
            <h4 class="text-success">Class:&nbsp;&nbsp;<small>{{.Class}}</small>
            </h4>
            <h4 class="text-success">Blog:&nbsp;&nbsp;<small>{{.Blog}}</small>
            </h4>
            <h4 class="text-success">CodeForces:&nbsp;&nbsp;<small>{{.Codeforces}}</small>
            </h4>
        </div>
        <div class="col-md-4">
            <h4 class="text-info">Solved:&nbsp;&nbsp;<small>{{.AcceptsCount}}</small>
            </h4>
            <h4 class="text-warning">Submissions:&nbsp;&nbsp;<small>{{.SolutionsCount}}</small>
            </h4>{{end}}
            <h4 class="text-danger">AC Ratio:&nbsp;&nbsp;<small>{{.user.Radio}} %</small>
            </h4>
            <h4 class="text-primary">Rank:&nbsp;&nbsp;<small>{{.user.Rank}}</small>
            </h4>
            <h4 class="text-warning">Email:&nbsp;&nbsp;<small>
            {{.user.Email}}                                                                            </small>
            </h4>
            <h4 class="text-muted">Register Time:&nbsp;&nbsp;<small>{{dateformat .user.RegisterTime "2006-01-02 15:04:05"  }}</small>
            </h4>
        </div>
            <div class="col-md-offset-4 col-md-8">
                <h4 id="linked-account-codeforces" class="text-muted hidden">Codeforces:&nbsp;&nbsp;<small
                        id="linked-account-codeforces-info"></small>
                </h4>
            </div>
        </div>
    </div>
{{ if (eq .user.Uid .uid )}}
    <div class="row">
        <div class="col-md-12 text-right" style="padding-top: 10px;padding-bottom: 10px;" id="user-op-buttons">

            <a tabindex="0" class="btn btn-default" role="button" data-toggle="popover" data-trigger="focus"
               data-html="true" data-placement="left"
               data-content="点击头像区域，在跳转的网站中注册并上传头像即可（注册邮箱需和 OJ 个人信息中的邮箱相同）。&lt;br/&gt;由于缓存，上传后可能存在数十分钟的更新延迟。&lt;br/&gt;&lt;br/&gt;如仍有疑问，请自行搜索如何注册 Gravatar 头像。"
               data-original-title="" title="">
                修改头像
            </a>
            <a class="btn btn-default" href="/User/UpdateInfo/{{.user.Uid}}">修改个人信息</a>
            <a class="btn btn-default" href="/User/UpdatePasswd/{{.user.Uid}}">修改密码</a>
        </div>
    </div>
{{end}}
    <div class="row">
        <div class="block">
            <div class="block-content">
                <div class="heading">Rating</div>
                <div class="inner" id="rating">
                    <span style="font-size: 16px; color: #999999;">【尚无评级】</span>
                    <span style="font-size: 22px;">0</span>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="block block-danger">
            <div class="block-content">
                <div class="heading">User's <span class="ce-text bold">submissions</span></div>
                <div class="inner problem_list">
                    <a href="/status?uid={{.uid}}">Submissions</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="block block-success">
            <div class="block-content">
                <div class="heading">List of <span class="accept-text bold">solved</span> problems</div>
                <div class="inner problem_list">
                {{range $solution := .solutions}}
                {{ if (eq $solution.Result 2) }}
                    <a href="/problem/{{$solution.Pid}}">{{$solution.Pid}}</a>
                {{end}}
                {{end}}
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="block block-warning">
            <div class="block-content">
                <div class="heading">List of <span class="wrong-text bold">unsolved</span> problems</div>
                <div class="inner problem_list">
                {{range $solution := .solutions}}
                {{ if (ne $solution.Result 2)}}
                    <a href="/problem/{{$solution.Pid}}">{{$solution.Pid}}</a>
                {{end}}
                {{end}}
                </div>
            </div>
        </div>
    </div>
</div>


<script src="Userinfo_files/user_info_rating.js"></script>


</div>