<link href="/static/css/amazeui.min.css" rel="stylesheet">
<div class="container">
    <div class="am-u-sm-12">
        <form class="am-form" action="" method="post">
        {{with .contest}}
            <div class="am-form-group">
                <label>比赛名称</label>
                <input type="text" name="name" value="{{.Name}}">
            </div>
            <div class="am-form-group">
                <label>试题列表，请用英文逗号(,)隔开题目编号，如：1,3,5</label>
                <input type="text" name="problems"
                       value="{{.Problems}}">
            </div>
            <div class="am-form-group">
                <label>比赛介绍</label>
                <textarea class="" rows="5" id="doc-ta-1" name="description"></textarea>
            </div>
            <div class="am-form-group">
                <label>开始时间</label>
                <input type="number" name="start_time" value="{{dateformat .StartTime "20060102150405"}}">
            </div>
            <div class="am-form-group">
                <label>结束时间</label>
                <input type="number" name="end_time" value="{{dateformat .EndTime "20060102150405"}}">
            </div>
            <div class="am-form-group">
                <label>公开：</label>
                <label class="am-radio-inline">
                    <input type="radio" value="1" name="IsPublic" checked> 是
                </label>
                <label class="am-radio-inline">
                    <input type="radio" value="2" name="IsPublic"> 否
                </label>
            </div>
            <button type="submit" class="am-btn am-btn-primary">提交</button>
        {{end}}
        </form>
    </div>
</div>
