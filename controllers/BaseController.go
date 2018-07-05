package controllers

import (
	"github.com/astaxie/beego"
	"onlinejudge/models"
	"time"
)

type BaseController struct {
	beego.Controller
}

func (this *BaseController) Prepare() {
	uname := this.GetSession("Uid")
	uid := this.GetSession("id")

	this.Data["logged"] = false
	this.Data["uid"] = 0
	if uname != nil {
		user := models.User{Uid: uid.(int), Username: uname.(string)}
		_ = user.GetByUid()
		this.Data["isEditor"] = false
		if user.IsAdmin == 1 {
			this.Data["isEditor"] = true
		}
		this.Data["uid"] = user.Uid
		this.Data["nickname"] = user.Nickname
		this.Data["logged"] = true
	}
	now :=  time.Now().Unix()
	this.Data["now"] = now
}

func (this *BaseController) loggedInCheck() bool{
	if this.GetSession("id") == nil {
		this.Redirect("/user/login", 302)
		return false
	}
	return true
}
func (this *BaseController) adminCheck() bool{
	id := this.GetSession("id")
	user := models.User{Uid:id.(int)}
	user.GetByUid()
	if user.IsAdmin != 1 {
		this.Redirect("/", 302)
		return false
	}
	return true
}
