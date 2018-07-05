<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>

    <title>{{.title}} | OnlineJudge</title>

    <link type="text/css" rel="stylesheet" href="/static/css/bootstrap.css"/>
    <script language="javascript" type="text/javascript" src="/static/js/jquery-3.js"></script>
    <script language="javascript" type="text/javascript" src="/static/js/bootstrap.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/css/home.css"/>
    <link type="text/css" rel="stylesheet" href="/static/css/base.css"/>

</head>
<body>
<div class="everything">
    <div class="banner">
        <div class="container">
        </div>
    </div>
    <nav class="navbar navbar-default" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#navbar-collapse"><span class="sr-only">Toggle navigation</span> <span
                        class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span></button>
                <a class="navbar-brand" href="/">Home</a>
            </div>
            <div class="collapse navbar-collapse" id="navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="/problems" id="problems">Problems</a></li>
                    <li><a href="/contests" id="contests">Contests</a></li>
                    <li><a href="/status" id="status">Status</a></li>
                    <li><a href="/standings" id="standings">Standings</a></li>
                    <li><a href="/news">News</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                {{ if .logged }}
                    <li><a href="/User/Show/{{.uid}}">{{.nickname}}</a></li>
                    <li><a href="/User/Logout">Logout</a></li>
                {{ else }}
                    <li><a href="/User/Login">Login</a></li>
                    <li><a href="/User/Signup">Register</a></li>
                {{ end }}

                </ul>
            </div>
        </div>
    </nav>
    <div class="main">
    {{ .LayoutContent }}
        <script language="javascript">

            var stime = "{{.now}}";

            function updatetime() {
                stime++;
                var etime = new Date(parseInt(stime) * 1000);
                $("#dt").html(etime.toString("Y-m-d H:i:s"));
            }

            setInterval(updatetime, 1000);
        </script>
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-sm-11 text-center">
                        developer :<a href="#"> wildkid1024</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-11 text-center">
                        <span id="dt"></span>
                        <br/>
                        <span>Copyright &copy; SDAUACM Team. All Rights Reserved.</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>