package models

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)


func (problem *Problem) Create() (int, bool) {
	o := orm.NewOrm()
	id, err := o.Insert(problem)
	if err == nil {
		return int(id), true
	}
	beego.Error(err)
	return 0, false
}
func (problem *Problem) Update()(int,bool){
	o := orm.NewOrm()
	id, err := o.Update(problem)
	if err == nil {
		return int(id), true
	}
	beego.Error(err)
	return 0, false
}
func (problem *Problem) GetByPid() bool {
	o := orm.NewOrm()
	o.Using("default")
	err := o.QueryTable("problem").Filter("is_display",1).Filter("pid",problem.Pid).One(problem)
	if err == nil {
		return true
	}
	return false
}
func (problem *Problem) ContestGetByPid() bool {
	o := orm.NewOrm()
	o.Using("default")
	err := o.QueryTable("problem").Filter("pid",problem.Pid).One(problem)
	if err == nil {
		return true
	}
	return false
}

func (problem *Problem) GetRecent() ([]Problem, int64) {
	var problems []Problem
	o := orm.NewOrm()
	o.Using("default")
	count, err := o.QueryTable("problem").Filter("title__icontains", problem.Title).Filter("is_display",1).OrderBy("DateCreated").All(&problems)
	if err == nil {
		return problems, count
	}
	return nil, count
}

/*
func (problem *Problem) UpdateTestData(file multipart.File)(int64,bool){
	pid := strconv.Itoa(problem.Pid)
	f := File{File:file,FileName:"test_data_+"+pid+".zip"}
	f.CalcMD5()
	fid,ok := f.Create()
	if ok{
		f.SaveFile()
		return fid,true
	}
	return fid,false
}
*/

func (problem *Problem) GetByUid() ([]Problem, int64) {
	var problems []Problem
	o := orm.NewOrm()
	o.Using("default")
	count, err := o.QueryTable("problem").Filter("uid", problem.Uid,"is_display",1).All(&problems)
	if err == nil {
		return problems, count
	}
	return nil, count
}
