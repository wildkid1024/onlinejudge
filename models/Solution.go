package models

import (
	"github.com/astaxie/beego/orm"
	"fmt"
)

func (solution *Solution) GetRecent() ([]Solution, int64) {
	o := orm.NewOrm()
	o.Using("default")
	var solutions []Solution
	qs := o.QueryTable("solution")
	qs = qs.Filter("Cid", solution.Cid)
	if solution.Uid != 0 {
		qs = qs.Filter("Uid", solution.Uid)
	}
	if solution.Pid != 0 {
		qs = qs.Filter("Pid", solution.Pid)
	}
	if solution.Result != 0 {
		qs = qs.Filter("result", solution.Result)
	}
	if solution.User != nil {
		qs = qs.Filter("User__Nickname__icontains", solution.User.Nickname)
	}
	count, err := qs.OrderBy("-DateCreated").RelatedSel().All(&solutions)

	if nil == err {
		return solutions, count
	}
	return nil, count
}
func (solution *Solution) UserGet() ([]Solution, int64) {
	o := orm.NewOrm()
	o.Using("default")
	var solutions []Solution
	qs := o.QueryTable("solution").Filter("Uid", solution.Uid).Filter("Cid", 0)
	count, err := qs.GroupBy("pid").All(&solutions)
	if nil == err {
		return solutions, count
	}
	return nil, 0
}
func (solution *Solution) GetFirst() (bool) {
	o := orm.NewOrm()
	o.Using("default")
	var solutions []Solution
	len, err := o.QueryTable("solution").Filter("Result", 9).OrderBy("Sid").RelatedSel().All(&solutions, "Sid", "Pid", "ProgramLanguage", "code", "Problem")
	if err == nil && len > 0 {
		//fmt.Println(solutions)
		*solution = solutions[len-1]
		return true
	}
	return false
}
func (solution *Solution) GetById() (bool) {
	o := orm.NewOrm()
	err := o.Read(solution)
	if err == nil {
		return true
	}
	return false
}

func (solution *Solution) Create() (int64, bool) {
	o := orm.NewOrm()
	o.Using("default")
	sid, err := o.Insert(solution)
	//fmt.Println(sid, err)
	if err != nil {
		return sid, false
	}
	return sid, true
}

func (solution *Solution) Update(para ...string) (int64, bool) {
	o := orm.NewOrm()
	sid, err := o.Update(solution, para...)
	if err != nil {
		fmt.Println(err)
		return sid, false
	}
	return sid, true
}

func (solution *Solution) ContestUsers() ([]Solution, int64) {
	o := orm.NewOrm()
	var solutions []Solution
	qs := o.QueryTable("solution")
	qs = qs.Filter("Cid", solution.Cid)
	count, err := qs.GroupBy("Uid").RelatedSel().All(&solutions,"Uid","User")
	if err == nil {
		return solutions, count
	}
	return nil, 0
}
