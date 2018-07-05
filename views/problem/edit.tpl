<link href="/static/css/amazeui.min.css" rel="stylesheet">
<script src="/static/js/amazeui.min.js"></script>

<div class="container">
    <style type="text/css">
        .problem-header {
            text-align: center;
        }

        .am-panel-title {
            font-size: 1.6em;
        }
    </style>

{{ if (ne .problem.Title "")}}
    <h1>修改题目</h1>
{{ else }}
    <h1>添加题目</h1>
{{end}}
    <form class="am-form" method="post" action="">
        <div data-am-widget="tabs" class="am-tabs am-tabs-d2">
            <ul class="am-tabs-nav am-cf">
                <li class="am-active" id="edit">
                    <a href="#">编辑</a>
                </li>
                <li class="" id="preview">
                    <a href="#">预览</a>
                </li>
            </ul>
            <div class="am-tabs-bd" data-am-tabs="">
                <div class="am-tab-panel am-active" id="edit-panel">
                    <fieldset>
                    {{with .problem}}
                        <div class="am-form-group">
                            <label for="doc-ds-ipt-1">题目名称</label>
                            <input type="text" class="am-form-field" id="title" name="title"
                                   value="{{.Title}}">
                        </div>

                        <div class="am-form-group">
                            <label>题目描述</label>
                            <textarea class="" rows="5" id="description" name="description">{{.Description}}</textarea>
                        </div>

                        <div class="am-form-group">
                            <label>输入格式</label>
                            <textarea class="" rows="5" id="input" name="input">{{.Input}}</textarea>
                        </div>

                        <div class="am-form-group">
                            <label>输出格式</label>
                            <textarea class="" rows="5" id="output" name="output">{{.Output}}</textarea>
                        </div>

                        <div class="am-form-group">
                            <label>输入样例</label>
                            <textarea class="" rows="5" id="sample_input" name="sample_input">{{.SampleInput}}</textarea>
                        </div>

                        <div class="am-form-group">
                            <label>输出样例</label>
                            <textarea class="" rows="5" id="sample_output" name="sample_output">{{.SampleOutput}}</textarea>
                        </div>
                        <div class="am-form-group">
                            <label>提示</label>
                            <textarea class="" rows="5" id="hint" name="hint">{{.Hint}}</textarea>
                        </div>
                        <div class="am-form-group">
                            <label>公开：</label>
                            <label class="am-radio-inline">
                                <input type="radio"  value="1" name="IsDisplay" checked> 是
                            </label>
                            <label class="am-radio-inline">
                                <input type="radio" value="0" name="IsDisplay"> 否
                            </label>
                        </div>
                    {{end}}
                    </fieldset>
                </div>

                <div class="am-tab-panel" id="preview-panel">
                    <h1 class="problem-header" id="pv-title"></h1>

                    <div class="am-panel-hd"><h3 class="am-panel-title big">题目描述</h3></div>
                    <div class="am-panel-bd" id="pv-description"></div>
                    <div class="am-panel-hd"><h3 class="am-panel-title">输入格式</h3></div>
                    <div class="am-panel-bd" id="pv-input"></div>
                    <div class="am-panel-hd"><h3 class="am-panel-title">输出格式</h3></div>
                    <div class="am-panel-bd" id="pv-output"></div>
                    <div class="am-panel-hd"><h3 class="am-panel-title">输入样例</h3></div>
                    <div class="am-panel-bd" id="pv-sample-input"></div>
                    <div class="am-panel-hd"><h3 class="am-panel-title">输出样例</h3></div>
                    <div class="am-panel-bd" id="pv-sample-output"></div>
                    <div class="am-panel-hd"><h3 class="am-panel-title">提示</h3></div>
                    <div class="am-panel-bd" id="pv-hint"></div>
                </div>
            </div>
        </div>
        <button type="submit" class="am-btn am-btn-default">提交</button>
    </form>


    <!-- KaTex -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/KaTeX/0.3.0/katex.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/KaTeX/0.3.0/katex.min.js"></script>
    <!-- KaTex autoRender -->
    <script src="/static/js/auto-render.js"></script>

    <script src="/static/js/marked.js"></script>
    <script type="text/javascript">
        function render(output, input) {
            output.html(marked(input.val()));
        }

        $("#preview").click(function () {
            $("#pv-title").text($("#title").val());
            render($("#pv-description"), $("#description"));
            render($("#pv-input"), $("#input"));
            render($("#pv-output"), $("#output"));
            render($("#pv-sample-input"), $("#sample_input"));
            render($("#pv-sample-output"), $("#sample_output"));
            render($("#pv-hint"), $("#hint"));
            renderMathInElement(document.getElementById("preview-panel"));
        });
    </script>
</div>