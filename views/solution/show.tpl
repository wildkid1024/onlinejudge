<link href="/static/css/amazeui.min.css" rel="stylesheet">
<script src="/static/js/amazeui.min.js"></script>
<link rel="stylesheet"
      href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/default.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
<div class="container">
    <div class="am-u-sm-12">
        <table class="am-table">
            <thead>
            <tr>
                <th>编号</th>
                <th>题目</th>
                <th>状态</th>
                <th>总时间</th>
                <th>总内存</th>
                <th>语言</th>
                <th>提交者</th>
                <th>提交时间</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>{{.solution.Sid}}</td>
                <td><a href="">{{.solution.Pid}}</a></td>
                <td>{{.solution.Result}}</td>
                <td>{{.solution.TakeTime}}</td>
                <td>{{.solution.TakeMemory}}</td>
                <td>{{.solution.ProgramLanguage}}</td>
                <td>{{.solution.Uid}}</td>
                <td>{{dateformat .solution.DateCreated "2006-01-02 15:04:05"}}</td>
                <td></td>
                <td></td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="am-u-sm-12">
        <pre><code class="C++">{{.solution.Code}}</code></pre>
    </div>
    <div class="am-u-sm-12">
        <pre><code></code></pre>
    </div>

</div>
