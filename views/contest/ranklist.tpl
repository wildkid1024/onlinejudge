<link type="text/css" rel="stylesheet" href="/static/css/ranklist.css"/>
<div class="container">
    <div id="head" class="row">
    {{with .contest}}
        <h3 class="text-center contest-title">{{.Name}}</h3>
    <div id="ranklist">
        <div class="unidiv toolbar">
            <div class="pull-right toolbar-tips">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="sample-result">
                            <span class="sample-result-color accepted"></span>
                            <span>Accepted</span>
                        </div>
                        <div class="sample-result">
                            <span class="sample-result-color fb"></span>
                            <span>First Blood</span>
                        </div>
                        <div class="sample-result">
                            <span class="sample-result-color rejected"></span>
                            <span>Rejected</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {{end}}
        <div class="clearfix"></div>

        <div id="ranklist-table" class="unidiv">
            <table class="table table-bordered text-center">
                <thead>
                <tr>
                    <th class="single-rank" rowspan="2">Rank</th>
                    <th class="single-name text-left" rowspan="2">Nickname</th>
                    <th class="single-solved" rowspan="2">Solved</th>
                    <th class="single-time" rowspan="2">Time</th>
                    <th class="single-prob thead-top">A</th>
                    <th class="single-prob thead-top">B</th>
                    <th class="single-prob thead-top">C</th>

                </tr>
                <tr>

                    <th class="thead-bottom text-mid-bold">3 / 7</th>
                    <th class="thead-bottom text-mid-bold">2 / 8</th>
                    <th class="thead-bottom text-mid-bold">3 / 4</th>

                </tr>
                </thead>
                <tbody>
                {{range $index,$r := .rank}}
                <tr>
                    <input value="32356" name="hid_uid" type="hidden">
                    <td>{{$index}}</td>
                    <td class="text-left nowrap-td">
                        <a href="/User/info/uid/32356.html">
                            <span class="inline-right-text">{{.}}</span>
                        </a>
                    </td>
                    <td>
                        <a href="http://sdutacm.cn/onlinejudge2/index.php/Home/Contest/conteststatus/cid/2485/uid/32356.html">7</a>
                    </td>
                    <td>{{.UsedTime}}</td>
                    <td data-subm-total="0"><p class="detail-time"><br></p>
                        <p class="detail-rj-count"><br></p></td>
                    <td data-subm-total="0"><p class="detail-time"><br></p>
                        <p class="detail-rj-count"><br></p></td>
                    <td data-subm-total="0"><p class="detail-time"><br></p>
                        <p class="detail-rj-count"><br></p>
                    </td>
                </tr>
                {{end}}
                </tbody>
            </table>
        </div>
    </div>

    </div>
</div>

<script>
    cid = 2485;
</script>

<script src="Ranklist_files/jquery_002.js"></script>
<script src="Ranklist_files/jquery.js"></script>
<script src="/static/js/xlsx.js"></script>
<script src="Ranklist_files/Blob.js"></script>
<script src="Ranklist_files/FileSaver.js"></script>
<script src="Ranklist_files/tableexport.js"></script>
<script src="Ranklist_files/ranklist_redesign.js"></script>

<script src="Ranklist_files/ranklist.html"></script>

<script>
    initContest();
</script>

</div>