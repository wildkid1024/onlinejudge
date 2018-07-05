<script>
    $(function () {
        $("#problems").attr("href", "/contest/{{.contest.Cid}}");
        $("#status").attr("href", "/contest/{{.contest.Cid}}/status");
        $("#standings").text("Ranklist");
        $("#standings").attr("href", "/contest/{{.contest.Cid}}/ranklist");
        $("#submit").attr("href", "/contest/{{.contest.Cid}}/submit/{{.problem.Pid}}");
        $("#statistic").attr("href", "/contest/{{.contest.Cid}}/statistic/{{.problem.Pid}}");
    });
</script>