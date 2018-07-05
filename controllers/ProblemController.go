package controllers

import (
	"onlinejudge/models"
	"strings"
	"strconv"
	"archive/zip"
	"os"
	"path/filepath"
	"io"
)

type ProblemController struct {
	BaseController
}

func (c *ProblemController) Create() {
	if !c.loggedInCheck() {
		c.Redirect("/user/login", 302)
		return
	}
	id := c.GetSession("id")
	user := models.User{Uid: id.(int)}
	user.GetByUid()
	if user.IsAdmin != 1 {
		c.Redirect("/", 302)
		return
	}
	pid, _ := c.GetInt(":pid")
	problem := models.Problem{Pid: pid}
	ok := problem.GetByPid()

	if c.Ctx.Input.IsPost() {
		sampleInput := strings.Replace(c.GetString("sample_input"), "\r", "", -1)
		sampleOutput := strings.Replace(c.GetString("sample_output"), "\r", "", -1)
		public, _ := c.GetBool("IsDisplay")
		problem.Title = c.GetString("title")
		problem.Description = c.GetString("description")
		problem.Input = c.GetString("input")
		problem.Output = c.GetString("output")
		problem.SampleInput = sampleInput
		problem.SampleOutput = sampleOutput
		problem.Hint = c.GetString("hint")
		problem.IsDisplay = public
		problem.Uid = id.(int)
		problem.TimeLimit = 1000
		problem.MemoryLimit = 65535
		var noerr bool
		if ok {
			problem.Update()
		} else {
			pid, noerr = problem.Create()
		}
		pid := strconv.Itoa(pid)
		if noerr == true {
			c.Redirect("/problem/"+pid, 302)
			return
		}
	}
	if !ok {
		c.Data["title"] = "Add Problem "
	} else {
		c.Data["title"] = "Edit Problem "
	}
	c.Data["problem"] = problem
	c.Layout = "layout.tpl"
	c.TplName = "problem/edit.tpl"
}
func (c *ProblemController) Upload() {
	if !(c.loggedInCheck() && c.adminCheck()) {
		return
	}
	pid, _ := c.GetInt(":pid")
	problem := models.Problem{Pid: pid}
	if !problem.GetByPid() {
		c.Abort("404")
		return
	}
	if c.Ctx.Input.IsPost() {
		timeLimit, _ := c.GetInt("time_limit")
		memoryLimit, _ := c.GetInt("memory_limit")
		problem.TimeLimit = timeLimit
		problem.MemoryLimit = memoryLimit
		problem.Update()
		f,h,_ := c.GetFile("testdata")
		defer f.Close()
		c.SaveToFile("testdata", "./static/upload/"+h.Filename)
	}
	c.Data["title"] = "Upload TestData "
	c.Data["problem"] = problem
	c.Layout = "layout.tpl"
	c.TplName = "problem/upload_testdata.tpl"
}

// problems like title
func (c *ProblemController) List() {
	title := c.GetString("title")
	problem := models.Problem{
		Title: title,
	}
	problems, _ := problem.GetRecent()

	pageSize := 50;
	page, err := c.GetInt("p")
	totals := len(problems)
	if nil != err {
		page = 1
	}
	c.Data["Page"] = models.PageUtil(totals, page, pageSize, models.ToSlice(problems))
	//c.Data["problems"] = problems
	c.Data["title"] = "Problems "
	c.Layout = "layout.tpl"
	c.TplName = "problem/problems.tpl"
}

func (c *ProblemController) ProblemById() {
	pid, _ := c.GetInt(":pid")
	p := models.Problem{Pid: pid}
	if !p.GetByPid() {
		c.Abort("404")
	}

	user := models.User{}
	user.Uid = p.Uid
	user.GetByUid()
	c.Data["title"] = p.Title
	c.Data["problem"] = p
	c.Data["Author"] = user.Username

	c.Layout = "layout.tpl"
	c.TplName = "problem/show.tpl"
}

func DeCompress(zipFile, dest_path string) error {
	reader, err := zip.OpenReader(zipFile)
	if err != nil {
		return err
	}
	defer reader.Close()
	DeCompress_to_dest := func(f *zip.File) error {
		rc, err := f.Open()
		if err != nil {
			return err
		}
		defer rc.Close()
		filename := dest_path + f.Name
		if err = os.MkdirAll(filepath.Dir(filename), 0755); err != nil {
			return err
		}
		w, err := os.Create(filename)
		if err != nil {
			return err
		}
		defer w.Close()
		_, err = io.Copy(w, rc)
		return err
	}
	for _, file := range reader.File {
		err := DeCompress_to_dest(file)
		if err != nil {
			return err
		}
	}
	return nil
}