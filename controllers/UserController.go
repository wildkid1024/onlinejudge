package controllers

import (
	"onlinejudge/models"
	"strconv"
	"github.com/astaxie/beego"
	"fmt"
)

type UserController struct {
	BaseController
}

func (c *UserController) Login() {
	uid := c.GetSession("Uid")
	if uid != nil {
		c.Redirect("/", 302)
	}

	if c.Ctx.Input.Param("0") == "submit" {
		user := models.User{
			//Uid:uid.(int),
			Username: c.GetString("username"),
			Password: c.GetString("password"),
		}
		err := user.LoginVerify()
		if err != nil {
			flash := beego.NewFlash()
			flash.Error(err.Error())
			flash.Store(&c.Controller)
		}
		if user.Login() == true {
			c.SetSession("Uid", c.GetString("username"))
			user.GetByUid()
			c.SetSession("id", user.Uid)

			// store the user ID in the session
			c.Redirect("/", 302)
		}
		//If login failed, flash a relevent message
	}

	c.Data["title"] = "Login "
	c.Layout = "layout.tpl"
	c.TplName = "user/login.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["HtmlHead"] = ""
	c.LayoutSections["Sidebar"] = ""
	//c.LayoutSections["ErrorHead"] = "errorHead.tpl"
}

func (c *UserController) Logout() {
	c.DelSession("Uid")
	c.DelSession("id")
	c.Redirect("/", 302)
}

func (c *UserController) Signup() {

	uid := c.GetSession("Uid")
	if uid != nil {
		c.Redirect("/", 302)
	}

	if c.Ctx.Input.Param("0") == "submit" {

		user := models.User{
			Username: c.GetString("username"),
			Password: c.GetString("password"),
			Nickname: c.GetString("nickname"),
			School:   c.GetString("school"),
			College:  c.GetString("college"),
			Major:    c.GetString("major"),
			Class:    c.GetString("class"),
			Email:    c.GetString("email"),
		}
		// All the fields verified, as well checked if username and email are unique
		err := user.SignupVerify()
		if err != nil {
			flash := beego.NewFlash()
			flash.Error(err.Error())
			flash.Store(&c.Controller)
		}
		uid, done := user.Create()

		if done {
			c.SetSession("Uid", c.GetString("username"))
			c.SetSession("id", uid)
			c.Redirect("/", 302)
		}
		c.Redirect("/User/Signup", 302)
	}

	c.Data["title"] = "Register "

	c.Layout = "layout.tpl"
	c.TplName = "user/register.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["HtmlHead"] = ""
	c.LayoutSections["Sidebar"] = ""
}
func (c *UserController) Show() {
	if c.Ctx.Input.Param("0") == "" {
		c.Abort("404")
	}
	id, err := strconv.Atoi(c.Ctx.Input.Param("0"))
	if err != nil {
		c.Abort("404")
	}
	User := models.User{Uid: id}
	solution := models.Solution{Uid: id}
	solutions, _ := solution.UserGet()
	//radio := 0
	//if User.SolutionsCount > 0 {
	//	radio = User.AcceptsCount / User.SolutionsCount
	//}
	if User.GetByUid() {
		c.Data["user"] = User
		c.Data["title"] = "UserInfo"
		//c.Data["radio"] = radio
		c.Data["solutions"] = solutions

		c.Layout = "layout.tpl"
		c.TplName = "user/userinfo.tpl"

	} else {
		c.Abort("404")
	}
}

func (c *UserController) UpdateInfo() {
	uid, err := c.GetInt("0")
	if nil != err {
		c.Abort("404")
		return
	}
	_uid := c.GetSession("id")
	if !(_uid != nil && _uid == uid) {
		c.Redirect("/user/login", 302)
		return
	}
	user := models.User{Uid: uid}
	user.GetByUid()

	if c.Ctx.Input.IsPost() {
		user.Nickname = c.GetString("nickname")
		user.School = c.GetString("school")
		user.College = c.GetString("college")
		user.Blog = c.GetString("blog")
		user.Class = c.GetString("class")
		user.Major = c.GetString("major")
		user.Email = c.GetString("email")
		user.Codeforces = c.GetString("Codeforces")
		fmt.Println(user.Username)
		/*
		err := user.SignupVerify()
		if err != nil {
			flash := beego.NewFlash()
			flash.Error(err.Error())
			flash.Store(&c.Controller)
		}
		*/
		user.Update();
		c.Redirect("/user/show/"+strconv.Itoa(_uid.(int)), 302)
		return
	}

	c.Data["title"] = "UpdateInfo "
	c.Data["user"] = user
	c.Layout = "layout.tpl"
	c.TplName = "user/updateinfo.tpl"
}
func (c *UserController) UpdatePasswd() {
	uid, err := c.GetInt("0")
	if nil != err {
		c.Abort("404")
		return
	}
	_uid := c.GetSession("id")
	if !(_uid != nil && _uid == uid) {
		c.Redirect("/user/login", 302)
		return
	}
	user := models.User{Uid: uid}
	user.GetByUid()
	if c.Ctx.Input.IsPost() {
		user.Password = c.GetString("opassword")
		newPassword := c.GetString("npassword")
		rePassword := c.GetString("rpassword")
		msg := ""
		if !user.Login() {
			msg = "请输入正确的旧密码！"
		}
		if newPassword != rePassword {
			msg = "请输入一致的新密码！"
		}
		c.Data["msg"] = msg
		if msg == "" {
			user.ChangePassword(newPassword)
			c.Redirect("/user/show/"+strconv.Itoa(_uid.(int)), 302)
			return
		}
	}
	c.Data["title"] = "UpdatePass "
	c.Layout = "layout.tpl"
	c.TplName = "user/updatepass.tpl"
}

func (c *UserController) Sort() {
	user := models.User{}
	users := user.Sort()

	pageSize := 50;
	page, err := c.GetInt("p")
	totals := len(users)
	if nil != err {
		page = 1
	}
	c.Data["Page"] = models.PageUtil(totals, page, pageSize, models.ToSlice(users))
	c.Data["title"] = "Standing "
	c.Data["users"] = users
	c.Layout = "layout.tpl"
	c.TplName = "user/standing.tpl"
}
