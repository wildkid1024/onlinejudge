package controllers

import (
	"encoding/json"
	"github.com/astaxie/beego"
	"onlinejudge/models"
)

type SolutionController struct {
	BaseController
}

func (c *SolutionController) List() {
	uid, _ := c.GetInt("uid")
	pid, _ := c.GetInt("pid")
	result, _ := c.GetInt("result")
	nickname := c.GetString("nickname")

	Solution := models.Solution{Uid: uid, Pid: pid, Result: result, User: &models.User{Nickname: nickname}}
	Solutions, _ := Solution.GetRecent()

	pageSize := 50
	page, err := c.GetInt("p")
	totals := len(Solutions)
	if nil != err {
		page = 1
	}
	c.Data["Page"] = models.PageUtil(totals, page, pageSize, models.ToSlice(Solutions))
	c.Data["solutions"] = Solutions
	c.Data["title"] = "Status "
	c.Layout = "layout.tpl"
	c.TplName = "solution/solutions.tpl"
	c.LayoutSections = make(map[string]string)
}

func (c *SolutionController) Submit() {
	if !c.loggedInCheck() {
		return
	}
	uid := c.GetSession("id").(int)
	pid, _ := c.GetInt(":pid")
	user := models.User{Uid: uid}
	user.GetByUid()
	problem := models.Problem{Pid: pid}
	if !problem.GetByPid() {
		c.Abort("404")
	}
	if c.Ctx.Input.IsPost() {
		code := c.GetString("code")
		solution := models.Solution{
			ProgramLanguage: c.GetString("lang"),
			Code:            code,
			Result:          9,
			Pid:             pid,
			Uid:             uid,
			User:            &user,
			Problem:         &problem,
		}
		_, st := solution.Create()
		if st {
			c.Redirect("/status", 302)
			return
		}
	}
	c.Data["user"] = user
	c.Data["problem"] = problem
	c.Data["title"] = "Submit "
	c.Layout = "layout.tpl"
	c.TplName = "solution/submit.tpl"
}
func (c *SolutionController) ViewCode() {
	sid, _ := c.GetInt(":sid")
	solution := models.Solution{Sid: sid}
	if !solution.GetById() {
		c.Abort("404")
	}
	//fmt.Println(solution)
	if uid := c.GetSession("id"); uid != solution.Uid {
		//fmt.Println(uid)
		c.Abort("404")
	}
	c.Data["title"] = "ViewCode"
	c.Data["solution"] = solution
	c.Layout = "layout.tpl"
	c.TplName = "solution/show.tpl"
}

func (c *SolutionController) APIGet() {
	solution := models.Solution{}

	Token := c.GetString("token")
	if Token != beego.AppConfig.String("token") {
		c.Abort("404")
	}
	solution.GetFirst()
	json := models.APISolution{
		Sid:             solution.Sid,
		Pid:             solution.Pid,
		ProgramLanguage: solution.ProgramLanguage,
		Code:            solution.Code,
	}
	if solution.Problem != nil {
		json.MemoryLimit = solution.Problem.MemoryLimit
		json.TimeLimit = solution.Problem.TimeLimit
	}

	s := models.Solution{Sid: solution.Sid}
	s.Result = 10
	s.Update("Result")

	c.Data["json"] = json
	c.Data["title"] = "API"
	c.ServeJSON()
}

/**
接收判题机的结果
格式:
{
  "sid":12,
  "pid":1,
  "result":1,
  "usedtime":100,
  "usedmemory":1569
}
*/
func (c *SolutionController) APIPost() {
	solution := &models.APISolution{}

	Token := c.GetString("token")
	if Token != beego.AppConfig.String("token") {
		c.Abort("404")
	}

	jsonStr := c.GetString("data")
	if err := json.Unmarshal([]byte(jsonStr), &solution); err != nil {
		c.Abort("404")
	}
	sol := &models.Solution{Sid: solution.Sid}
	sol.GetById()
	sol.Result = solution.Result
	sol.TakeMemory = solution.UsedMemory
	sol.TakeTime = solution.UsedTime

	data := ""
	if _, ok := sol.Update("Result", "TakeTime", "TakeMemory"); ok == true {
		data = `{"status":0,"msg":"","data":""}`
	} else {
		data = `{"status":1,"msg":"发生错误","data":""}`
	}

	c.Data["title"] = "API"
	c.Ctx.Output.ContentType("json")
	c.Ctx.Output.Body([]byte(data))

}
