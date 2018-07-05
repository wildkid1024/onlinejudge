<div class="container">
    <div>
        <div class="form-inline">
            <div class="pull-right pad">
                <form name="form" method="get">
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon">Name</span>
                        <input class="form-control" name="name" type="text">
                    </div>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon">Type</span>
                        <select class="form-control" name="type">
                            <option value="" selected="selected">All</option>
                            <option class="bold accept-text" value="1">Public</option>
                            <option class="bold wrong-text" value="2">Private</option>
                        </select>
                    </div>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                        <input id="cid" class="form-control" placeholder="ID" name="cid" type="text">
                    </div>
                    <button class="btn btn-default btn-sm" type="submit">GO</button>
                </form>
                <br>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("form").submit(function (e) {
            var $cid = $("#cid").val();
            if ($cid != "") {
                e.preventDefault();
                window.location.href = "/contest/" + $cid;
                return;
            }
        });
    </script>
    <div class="row">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th style="width:3%">ID</th>
                <th style="width:43%">Name</th>
                <th style="width:12%">Start Time</th>
                <th style="width:12%">End Time</th>
                <th style="width:12%">Type</th>
                <th style="width:6%">Status</th>
            </tr>
            </thead>
            <tbody>

            {{range $contest := .contests }}
            <tr>
                <td>{{$contest.Cid}}</td>
                <td><a href="/contest/{{$contest.Cid}}">{{$contest.Name}}</a></td>
                <td>{{dateformat $contest.StartTime "2006-01-02 15:04:05" }}</td>
                <td>{{dateformat $contest.EndTime "2006-01-02 15:04:05"}}</td>
            {{if (eq $contest.Type 1) }}
                <td class="bold accept-text">Public</td>
            {{else if (eq $contest.Type 2) }}
                <td class="bold wrong-text">Private</td>
            {{end}}
                <td class="bold accept-text">Ended</td>
            {{end}}
            </tr>
            </tbody>
        </table>
        <ul class="page"></ul>
    </div>
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
            window.location.href = "/contests?p=" + page
        }
    });
    $(".pagination").css('margin', 0)
</script>
