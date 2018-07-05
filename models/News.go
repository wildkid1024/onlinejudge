package models

import (
	"github.com/astaxie/beego/orm"
	"fmt"
)

func (c *News) GetRecent()([]News, int64) {
	var Newslist []News
	o := orm.NewOrm()
	o.Using("default")
	count,err := o.QueryTable("news").OrderBy("-DateCreated").All(&Newslist)
	fmt.Println(count)
	if err == nil{
		return Newslist,count
	}
	return nil,count
}
func (news *News) GetById() bool{
	o := orm.NewOrm()
	o.Using("default")
	err := o.Read(news)
	if nil == err{
		return true
	}
	return false
}
func (news *News) Create()(int64, bool){
	o := orm.NewOrm()
	o.Using("default")
	id,err := o.Insert(news)
	if nil == err{
		return id,true
	}
	return id,false
}
func (news *News)Update()(int64, bool)  {
	o := orm.NewOrm()
	o.Using("default")
	id,err := o.Update(news)
	if nil == err{
		return id,true
	}
	return 0,false
}