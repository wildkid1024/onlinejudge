<div class="container">
    <div class="block block-success"></div>
    <div class="block-content">
        <div class="block-container form-horizontal">
            <form action="" method="post" id="submitform">
                <div class="form-group form-group-sm">
                    <label class="col-sm-2 control-label">Problem</label>
                    <div class="col-sm-10 form-inline">
                        <p class="form-control-static">{{.problem.Pid}}</p>
                        <input name="pid" value="{{.problem.Pid}}" type="text" hidden>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <label class="col-sm-2 control-label">Language</label>
                    <div class="col-sm-10 form-inline">
                        <select name="lang" class="form-control input-sm">
                            <option value="gcc">gcc</option><option value="g++" selected="selected">g++</option><option value="java">java</option><option value="python2">python2</option><option value="python3">python3</option><option value="c#">c#</option>							</select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Source Code</label>
                    <div class="col-sm-7">
                        <textarea name="code" rows="25" class="form-control"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-7">
                        <button type="submit" class="btn btn-primary btn-bg">Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

