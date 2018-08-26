<div class="container">
    <div class="row">

        <table id="status-table" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th style="width: 6%">RunID</th>
                <th>Nick Name</th>
                <th style="width: 6%">Problem</th>
                <th style="width: 16%">Result</th>
                <th style="width: 8%">Time</th>
                <th style="width: 10%">Memory</th>
                <th style="width: 8%">Language</th>
                <th style="width: 8%">Code Len</th>
                <th style="width: 14%">Submission Time</th>
            </tr>
            </thead>
            <tbody>
            {{range $solution := .solutions}}
            <tr data-spj="0">
                <input value="40774" name="hid_uid" type="hidden">
                <td>{{$solution.Sid}}</td>
                <td class="nowrap-td">
                    <a href="/User/Show/{{$solution.Uid}}">
                        <span class="inline-right-text">{{$solution.User.Nickname}}</span>
                    </a>
                </td>
                <td><a href="/problem/{{$solution.Pid}}">{{$solution.Pid}}</a></td>
            {{if (eq $solution.Result 10)}}
                <td class="bold pe-text">Judgeing</td>
            {{else if (eq $solution.Result 1)}}
                <td class="bold accept-text">Accepted</td>
            {{else if (eq $solution.Result 2)}}
                <td class="bold wrong-text">Presentation Error</td>
            {{else if (eq $solution.Result 3)}}
                <td class="bold wrong-text">Wrong Answer</td>
            {{else if (eq $solution.Result 4)}}
                <td class="bold wrong-text">Time limit exceeded</td>
            {{else if (eq $solution.Result 5)}}
                <td class="bold wrong-text">Memory Limit Exceeded</td>
            {{else if (eq $solution.Result 6)}}
                <td class="bold wrong-text">Output Limit Exceeded</td>
            {{else if (eq $solution.Result 7)}}
                <td class="bold wrong-text">Runtime Error</td>
            {{else if (eq $solution.Result 8)}}
                <td class="bold wrong-text">Compile Error</td>
            {{else }}
                <td class="bold pe-text">Submited</td>
            {{end}}
                <td>{{$solution.TakeTime}}</td>
                <td>{{$solution.TakeMemory}}</td>
                <td><a href="/viewcode/{{$solution.Sid}}">{{$solution.ProgramLanguage}}</a></td>
                <td>{{$solution.Length}}</td>
                <td>{{dateformat $solution.DateCreated  "2006-01-02 15:04:05"}}</td>
            </tr>
            {{end}}
            </tbody>
        </table>
        <ul class="page"></ul>
    </div>
</div>

<script type="text/javascript">
    $(".page").bootstrapPaginator({
        currentPage: '{{.Page.PageNo}}',
        totalPages: '{{.Page.TotalPage}}',
        useBootstrapTooltip: 'true',
        bootstrapMajorVersion: 3,
        size: "small",
        onPageClicked: function (e, originalEvent, type, page) {
            window.location.href = "/status?p=" + page
        }
    });
    $(".pagination").css('margin', 0)
</script>


