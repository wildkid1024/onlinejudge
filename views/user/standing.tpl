<div class="container">
    <div class="row">
        <table id="standings-table" class="table table-bordered table-hover">
            <thead>
            <tr>
                <th class="col-md-1">Rank</th>
                <th class="col-md-3">Username</th>
                <th class="col-md-4">Nickname</th>
                <th class="col-md-1">Solved</th>
                <th class="col-md-1">Submit</th>
                <th class="col-md-2">Ratio</th>
            </tr>
            </thead>
            <tbody>
            {{range $rank,$user := .users}}
            <tr>
                <input value="18947" name="hid_uid" type="hidden">
                <td class="rank"></td>
                <td><a href="/User/Show/{{$user.Uid}}">{{$user.Username}}</a></td>
                <td class="nowrap-td">
                    <a href="/User/Show/{{$user.Uid}}">
                        <!--<img class="avatar avatar-sm inline-left-img hidden" src="https://cdn.v2ex.com/gravatar/7e96c729f13dd869c9242be00df3d881?s=32&d=mm&r=g&_t=423437">--><span
                            class="inline-right-text">{{$user.Nickname}}</span>
                    </a>
                </td>
                <td>{{$user.AcceptsCount}}</td>
                <td>{{$user.SolutionsCount}}</td>
                <td>{{$user.Radio | printf "%.2f"}} %</td>
            </tr>
            <script>
                $(".rank").each(function (index, e) {
                    $(e).html(index + 1);
                });
            </script>
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
            window.location.href = "/standings?p=" + page
        }
    });
    $(".pagination").css('margin', 0)
</script>
