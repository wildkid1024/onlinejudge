package controllers

import (
	"onlinejudge/models"
	"strconv"
	"github.com/astaxie/beego"
	"strings"
	"time"
	"fmt"
	"sort"
)

type ContestController struct {
	BaseController
}

func (c *ContestController) List() {
	name := c.GetString("name")
	typo, _ := c.GetInt("type")
	Contest := models.Contest{Name: name, Type: typo}
	Contests, _ := Contest.GetRecent()

	pageSize := 50;
	page, err := c.GetInt("p")
	totals := len(Contests)
	if nil != err {
		page = 1
	}
	c.Data["Page"] = models.PageUtil(totals, page, pageSize, models.ToSlice(Contests))
	c.Data["contests"] = Contests
	c.Data["title"] = "Contests "
	c.Layout = "layout.tpl";
	c.TplName = "contest/contests.tpl"
	c.LayoutSections = make(map[string]string)
}

func (c *ContestController) ContestById() {
	cid, _ := c.GetInt(":cid")
	contest := models.Contest{Cid: cid}
	ok := contest.GetbyId()
	if !ok {
		c.Abort("404")
		return
	}

	var problemList []models.Problem
	prostr := strings.Split(contest.Problems, ",")
	for _, v := range prostr {
		pid, _ := strconv.Atoi(v)
		problem := models.Problem{Pid: pid}
		problem.ContestGetByPid()
		problemList = append(problemList, problem)
	}

	now := time.Now().Unix()
	stTime := contest.StartTime.Unix()
	edTime := contest.EndTime.Unix()
	timeRemain := now - stTime
	c.Data["TimeRemain"] = fmt.Sprintf("%s:%s:%s", timeRemain/3600, (timeRemain/60)%60, timeRemain%60)
	c.Data["ContestStatus"] = "Running"
	if now < stTime {
		c.Data["TimeRemain"] = "Waiting"
		c.Data["ContestStatus"] = "Waiting"
	}
	if now > edTime {
		c.Data["TimeRemain"] = "Ended"
		c.Data["ContestStatus"] = "Ended"
	}
	c.Data["problems"] = problemList
	c.Data["title"] = "ProblemList "
	c.Data["contest"] = contest
	c.Layout = "layout.tpl"
	c.TplName = "contest/show.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["js"] = "contest/js.tpl"
}

func (c *ContestController) Edit() {
	if !c.loggedInCheck() {
		return
	}
	if !c.adminCheck() {
		return
	}
	cid, _ := c.GetInt(":cid")
	uid := c.GetSession("id")
	contest := models.Contest{Cid: cid}
	ok := contest.GetbyId()
	if c.Ctx.Input.IsPost() {
		start_time, end_time := c.GetString("start_time"), c.GetString("end_time")
		startTime, _ := beego.DateParse(start_time, "20060102150405")
		endTime, _ := beego.DateParse(end_time, "20060102150405")
		//problem_list := strings.Split(c.GetString("problems"), ",")
		Type, _ := c.GetInt("IsPublic")
		contest = models.Contest{
			Cid:         cid,
			Uid:         uid.(int),
			Name:        c.GetString("name"),
			Description: c.GetString("description"),
			StartTime:   startTime,
			EndTime:     endTime,
			Type:        Type,
			Problems:    c.GetString("problems"),
		}
		//fmt.Println(c.GetString("problems"))
		var noerr bool
		if ok {
			noerr = contest.Update()
		} else {
			var id int64
			id, noerr = contest.Create()
			cid = int(id)
		}
		if noerr {
			c.Redirect("/contest/"+strconv.Itoa(cid), 302)
			return
		}
	}
	if ok {
		c.Data["title"] = "UpdateContest "
	} else {
		c.Data["title"] = "AddContest "
	}
	c.Data["contest"] = contest
	c.Layout = "layout.tpl"
	c.TplName = "contest/edit.tpl"
}
func (c *ContestController) ContestProblem() {
	pid := c.GetString(":pid")
	cid, _ := c.GetInt(":cid")
	contest := models.Contest{Cid: cid}
	if !contest.GetbyId() {
		c.Abort("404")
	}
	problems := strings.Split(contest.Problems, ",")
	ok := func() bool {
		for _, v := range problems {
			if v == pid {
				return true
			}
		}
		return false
	}
	if !ok() {
		c.Abort("404")
	}
	id, _ := strconv.Atoi(pid)
	problem := models.Problem{Pid: id}
	if !problem.ContestGetByPid() {
		c.Abort("404")
	}
	c.Data["contest"] = contest
	c.Data["problem"] = problem
	c.Data["title"] = "Problem "
	c.Layout = "layout.tpl"
	c.TplName = "problem/show.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["js"] = "contest/js.tpl"
}

//需要检测题目是否在problems中
func (c *ContestController) ContestSubmit() {
	pid, _ := c.GetInt(":pid")
	cid, _ := c.GetInt(":cid")

	if !c.loggedInCheck() {
		return
	}
	contest := models.Contest{Cid: cid}
	if !contest.GetbyId() {
		c.Abort("404")
	}
	uid := c.GetSession("id").(int)
	user := models.User{Uid: uid}
	user.GetByUid()
	problem := models.Problem{Pid: pid}
	if !problem.ContestGetByPid() {
		c.Abort("404")
	}
	if c.Ctx.Input.IsPost() {
		code := c.GetString("code")
		solution := models.Solution{
			ProgramLanguage: c.GetString("lang"),
			Code:            code,
			Pid:             pid,
			Uid:             uid,
			Cid:             cid,
			User:            &user,
			Problem:         &problem,
			Result:          10,
		}
		if _, ok := solution.Create(); ok {
			c.Redirect("/contest/"+strconv.Itoa(cid)+"/status", 302)
			return
		}
	}
	c.Data["user"] = user
	c.Data["contest"] = contest
	c.Data["problem"] = problem
	c.Data["title"] = "Submit "
	c.Layout = "layout.tpl"
	c.TplName = "solution/submit.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["js"] = "contest/js.tpl"
}
func (c *ContestController) ContestStatus() {
	cid, _ := c.GetInt(":cid")
	contest := models.Contest{Cid: cid}
	if !contest.GetbyId() {
		c.Abort("404")
	}
	solution := models.Solution{Cid: cid}
	solutions, _ := solution.GetRecent()

	c.Data["solutions"] = solutions
	c.Data["contest"] = contest
	c.Data["title"] = "Status "
	c.Layout = "layout.tpl"
	c.TplName = "solution/solutions.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["js"] = "contest/js.tpl"
}

func (c *ContestController) ContestRank() {
	cid, _ := c.GetInt(":cid")

	contest := models.Contest{Cid: cid}
	if !contest.GetbyId() {
		c.Abort("404")
	}

	solution := models.Solution{Cid: cid}
	solutions, _ := solution.GetRecent()
	users, _ := solution.ContestUsers()

	//fmt.Println(solutions)
	//fmt.Println(users, userNum)

	type UserList []*models.ContestUser
	userList := UserList{}

	//初始化用户
	problems := strings.Split(contest.Problems, ",")
	for _, user := range users {
		contestUser := &models.ContestUser{
			Uid:      user.Uid,
			Nickname: user.User.Nickname,
			Solved:   0,
			UsedTime: 0,
		}
		for _, problem := range problems {
			pid, _ := strconv.Atoi(problem)
			contestProblem := models.ContestProblem{
				Pid:        pid,
				UsedTime:   0,
				Attempt:    0,
				FirstBlood: false,
			}
			contestUser.Problems = append(contestUser.Problems, contestProblem)
		}
		userList = append(userList, contestUser)
	}

	//处理用户排名逻辑
	for _, solution := range solutions {

		useTime := solution.DateCreated.Second() - contest.StartTime.Second()

		for i, user := range userList {
			if (solution.Uid == user.Uid) {
				for j, problem := range user.Problems {
					if (problem.Pid == solution.Pid) {
						if (solution.Result == 3) {
							problem.UsedTime = problem.Attempt*20 + useTime
							user.Solved++
						} else {
							problem.Attempt++
						}
						user.Problems[j] = problem
					}
				}
			}
			userList[i] = user
		}
	}

	sort.Slice(userList, func(i, j int) bool {
		if (userList[i].Solved == userList[j].Solved) {
			return userList[i].UsedTime < userList[j].UsedTime
		}
		return userList[i].Solved < userList[j].Solved
	})

	//for _, user := range userList {
	//	fmt.Println(user)
	//}

	c.Data["userlist"] = userList
	c.Data["contest"] = contest
	c.Data["title"] = "Rank"
	c.Layout = "layout.tpl"
	c.TplName = "contest/ranklist.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["js"] = "contest/js.tpl"
}
