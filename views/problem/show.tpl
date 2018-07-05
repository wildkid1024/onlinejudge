{{with .problem}}
<div class="container">
    <div >
        <div class=""></div>
        <div class="block-content block-container istyle">
            <h3 class="problem-header">{{.Title}}</h3>
            <div class="prob-info">
                <span class="user-black">Time Limit:&nbsp;{{.TimeLimit}} ms</span>
                <span class="user-black" style="margin-left: 12px;">Memory Limit:&nbsp;{{.MemoryLimit}} KB</span>
            </div>
            <div class="form-group form-inline" align="center">
                <a href="/submit/{{.Pid}}" class="btn btn-default btn-sm" id="submit">Submit</a>
                <a href="/statistic/{{.Pid}}" class="btn btn-default btn-sm" id="statistic">Statistic</a>
            </div>
            <h4>Problem Description</h4>
            <div class="prob-content">
                <p>{{.Description}}</p>
            </div>
            <h4>Input</h4>
            <div class="prob-content">
                <p>{{.Input}}</p>
            </div>
            <h4>Output</h4>
            <div class="prob-content">
                <p>{{.Output}}</p>
            </div>
            <h4>Sample Input</h4>
            <div class="prob-content">
                <pre>{{.SampleInput}}</pre>
            </div>
            <h4>Sample Output</h4>
            <div class="prob-content">
                <pre>{{.SampleOutput}}</pre>
            </div>
            <h4>Hint</h4>
            <div class="prob-content">
           {{.Hint}}
            </div>
            <h4>Source</h4>
            <div class="prob-content">
                {{.Source}}				</div>
        </div>
    </div>
</div>

<script src="/static/js/MathJax.js"></script>

</div>
        {{end}}