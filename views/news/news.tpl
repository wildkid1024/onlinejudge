<div class="container">
    <div class="block block-info"></div>
    <div class="row" style="margin-top: 30px;">
        <div class="col-md-offset-2 col-md-8">
            <h3 class="text-center" style="margin-top: 0; margin-bottom: 30px;">{{.news.Title}}</h3>
            <div><h1><strong></strong></h1>
                {{.news.Content | str2html }}
            </div>
        </div>
    </div>
</div>