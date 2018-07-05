<div class="container">
    <div>
        <div class="col-md-6">

        </div>
        <div class="col-md-6 form-inline">
            <div class="pull-right pad">
                <form name="form">
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon">Title</span>
                        <input class="form-control" placeholder="Title Like" name="title" id="title" type="text">
                    </div>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-search"></i></span>
                        <input class="form-control" placeholder="Problem ID" name="pid" type="text" id="pid">
                    </div>
                    <button class="btn btn-default btn-sm" type="submit">GO</button>
                </form>
                <br>
            </div>
        </div>
        <script type="text/javascript">
            $("form").submit(function (e) {
                e.preventDefault();
                var $pid = $("#pid").val();
                var $title = $("#title").val();
                if ($pid != "") {
                    window.location.href = "/problem/" + $pid;
                    return;
                }
                if ($title != "") {
                    window.location.href = "/problems?title=" + $title;
                    return;
                }
            });
        </script>
    </div>
    <div class="row">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th class="col-md-1">Solved</th>
                <th class="col-md-5">Problem</th>
                <th class="col-md-2">AC / Total</th>
                <th class="col-md-1">Ratio</th>
                <th class="col-md-3">Source</th>
            </tr>
            </thead>
            <tbody>
            {{range $problem := .Page.List}}
            <tr>
                <td></td>
                <td><a href="/problem/{{$problem.Pid}}"> {{$problem.Pid}} - {{$problem.Title}}</a></td>
                <td>1/1</td>
                <td>100%</td>
                <td>{{$problem.Source }}</td>
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
            window.location.href = "/problems?p=" + page
        }
    });
    $(".pagination").css('margin', 0)
</script>
