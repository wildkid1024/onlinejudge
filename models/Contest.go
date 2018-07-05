package models

import (
	"github.com/astaxie/beego/orm"
	"strconv"
)

func (contest *Contest) GetbyId() bool{
	o := orm.NewOrm()
	o.Using("default")
	err := o.Read(contest)
	if err == nil{
		return true
	}
	return false
}
func (contest *Contest) GetRecent()([]Contest, int64) {
	var contests []Contest
	o := orm.NewOrm()
	o.Using("default")
	count,err := o.QueryTable("contest").Filter("name__icontains", contest.Name).Filter("type",contest.Type).OrderBy("cid").All(&contests)
	if err == nil{
		return contests,count
	}
	return nil,count
}
func (contest *Contest) Update()bool{
	o := orm.NewOrm()
	o.Using("default")
	_,err := o.Update(contest)
	if err == nil{
		return true
	}
	return false
}
func (contest *Contest) Create()(int64, bool) {
	o := orm.NewOrm()
	o.Using("default")
	cid,err := o.Insert(contest)
	if err == nil{
		return cid,true
	}
	return cid,false
}
func (contest *Contest) SetProblems(problemList []string)( bool) {
	o := orm.NewOrm()
	var problems  []*Problem
	for _,v := range problemList{
		id,err := strconv.Atoi(v)
		if err != nil{
			return false
		}
		problem := Problem{Pid:id}
		err =  o.Read(&problem)
		if nil != err {
			return false
		}
		//problem.Contest = contest
		problems = append(problems, &problem)
	}
	//fmt.Println(problems[0])
	//contest.ProblemList = problems[:]
	return true
}
