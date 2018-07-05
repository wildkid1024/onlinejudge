<div class="container">
<div class="" style="">
<h3 class="problem-header">{{with .contest }}{{.Name}}</h3>
    <div class="prob-info">
        <span class="user-black">Start time:&nbsp;{{dateformat .StartTime "2006-01-02 15:04:05"}}&nbsp;&nbsp;</span>
        <span class="user-black">End time:&nbsp;{{dateformat .EndTime "2006-01-02 15:04:05"}}</span>
    </div>
    <div class="prob-info">
        <span class="user-black">Contest type:&nbsp;{{if (eq .Type 0) }} Public&nbsp;{{else}} Private {{end}}&nbsp; </span>
        <span class="user-black">Contest status:&nbsp;{{$.ContestStatus}}</span>
    </div>
    <div align="center">
        <p>{{.Description}}&nbsp;</p>
    </div>
</div>
<div class="row">
<table class="table table-bordered table-hover">
    <thead>
    <tr>
        <th colspan="5" class="text-right">Time remaining: <span id="time-remaining">{{$.TimeRemain}}</span></th>
    </tr>
    <tr>
        <th class="col-md-1">Solved</th>
        <th class="col-md-7">Problem</th>
        <th class="col-md-2">Accepted</th>
        <th class="col-md-2">Total</th>
    </tr>
    </thead>
<tbody>
{{end}}
{{range $problem := .problems}}
<tr>
    <td></td>
    <td><a href="/contest/{{$.contest.Cid}}/problem/{{$problem.Pid}}">{{$problem.Title}}</a></td>
    <td><a href="/contest/{{$.contest.Cid}}/status?pid={{$problem.Pid}}&result=1">0</a></td>
    <td><a href="/contest/{{$.contest.Cid}}/status?pid={{$problem.Pid}}">0</a></td>
</tr>
{{end}}
</tbody>
</table>
</div>
</div>

<script>
    function preZeroFill(num, size) {
        if (num >= Math.pow(10, size)) {
            return num.toString();
        }
        else {
            var str = Array(size + 1).join('0') + num;
            return str.slice(str.length - size);
        }
    }

    function updateTime(total) {
        var h = parseInt(total / 3600);
        var m = parseInt(total % 3600 / 60);
        var s = parseInt(total % 60);
        $("#time-remaining").text(h + ":" + preZeroFill(m, 2) + ":" + preZeroFill(s, 2));
        if (total < 60)
            $("#time-remaining").css('color', 'red');
    }

    $(function () {
        var timeArr = $("#time-remaining").text().split(":");
        if (timeArr.length === 3) {
            var h = parseInt(timeArr[0]);
            var m = parseInt(timeArr[1]);
            var s = parseInt(timeArr[2]);
            total = parseInt(h * 3600 + m * 60 + s);
            updateTime(total);
            var timer = window.setInterval(function () {
                if (total === 0) {
                    window.clearInterval(timer);
                    window.location.reload();
                }
                else {
                    total--;
                    updateTime(total);
                }
            }, 1000);
        }
    });

</script>

</div>