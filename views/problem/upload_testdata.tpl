<link href="/static/css/amazeui.min.css" rel="stylesheet">
<script src="/static/js/amazeui.min.js"></script>
<div class="container">
    <div class="am-u-sm-6">
    {{/*{% if problem.testdata %}*/}}
    {{/*<p>数据包:{{problem.testdata.filename}}</p>*/}}
    {{/*{% set ok,list=parse(problem.testdata) %}*/}}
    {{/*{% if ok %}*/}}
        <h3>你已经上传了测试数据，并且已经解析出以下数据点</h3>
        <table class="am-table">
            <thead>
            <tr>
                <th>输入文件</th>
                <th>输出文件</th>
            </tr>
            </thead>
            <tbody>
            {{/*{% for case in list %}*/}}
            <tr>
                <td></td>
                <td></td>
            </tr>
            </tbody>
        </table>
    {{/*{% else %}*/}}
    {{/*<h3>你已经上传了测试数据，但是数据包出现错误{{list}}</h3>*/}}
    {{/*{% endif %}*/}}
    {{/*{% else %}*/}}
    {{/*<h3>你还没有上传数据</h3>*/}}
    {{/*{% endif %}*/}}
    </div>
{{with .problem}}
    <div class="am-u-sm-6">
        <form class="am-form" action="" method="post"
              enctype="multipart/form-data">
            <div class="am-form-group">
                <label for="doc-ds-ipt-1">时间限制(单位:ms)</label>
                <input type="number" name="time_limit" value="{{.TimeLimit}}">
            </div>
            <div class="am-form-group">
                <label for="doc-ds-ipt-1">内存限制(单位:KB)</label>
                <input type="number" name="memory_limit" value="{{.MemoryLimit}}">
            </div>
            <div class="am-form-group">
                <label for="doc-ipt-file-1">测试数据</label>
                <input type="file" name="testdata">
                <p class="am-form-help">数据格式请看...</p>
            </div>
            <button type="submit" class="am-btn am-btn-primary">提交</button>
        </form>
    </div>
{{end}}
</div>