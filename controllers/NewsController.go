package controllers

import (
	"onlinejudge/models"
	"strconv"
)

type NewsController struct {
	BaseController
}

func (c *NewsController) List(){
	News := models.News{}
	NewsList,_ := News.GetRecent()
	c.Data["news"] = NewsList
	c.Data["title"] = "NewsList "
	c.Layout = "layout.tpl"
	c.TplName = "news/list.tpl"

}

func (c *NewsController)NewsById(){
	_id := c.GetString(":id")
	id,err := strconv.Atoi(_id)
	if nil != err{
		c.Abort("404")
	}
	news := models.News{Nid:id}
	news.GetById()

	c.Data["title"] = news.Title
	c.Data["news"] = news
	c.Layout = "layout.tpl"
	c.TplName = "news/news.tpl"
}

func (c *NewsController) Create(){
	if !(c.loggedInCheck()&&c.adminCheck()){
		c.Abort("404")
		return
	}
	c.Data["title"] = "Create News "
	c.Layout = "layout.tpl"
	c.TplName = "news/edit.tpl"
}

func (c *NewsController) Save(){
	if !c.loggedInCheck() {
		c.Redirect("/user/login", 302)
		return
	}

	//Redirect if user doesnt hold editor rights
	id := c.GetSession("id")
	user := models.User{}
	user.Uid = id.(int)
	user.GetByUid()
	if user.IsAdmin != 1 {
		c.Redirect("/", 302)
		return
	}

	news := models.News{
		Title:   c.GetString("title"),
		Content: c.GetString("content"),
	}
	id, noerr := news.Create()
	pid := strconv.FormatInt(id.(int64),10)
	if noerr == true {
		c.Redirect("/news/"+pid, 302)
	}
	c.Create()
}
