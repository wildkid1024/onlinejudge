<div class="container">
    <div class="row">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>News</th>
            </tr>
            </thead>
            <tbody>
            {{range $news := .news}}
            <tr>
                <td><a href="/news/{{$news.Nid}}">{{$news.Title}}</a></td>
            </tr>
            {{end}}
</tbody>
        </table>
    </div>
    <div class="row text-center">
        <div>    </div>		</div>
</div>

</div>