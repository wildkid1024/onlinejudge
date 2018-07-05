package models

import (
	_ "github.com/go-sql-driver/mysql"
	"time"
	"github.com/astaxie/beego/orm"
)

type User struct {
	Uid           int       `orm:"pk;auto"`
	Username      string    `orm:"unique"`
	Password      string    `json:"-"`
	Nickname      string
	School        string
	College       string
	Major         string
	Class         string
	Email         string
	Blog          string
	Photo         string
	Codeforces    string
	RegisterTime  time.Time `orm:"auto_now_add;type(datetime)"`
	LastLoginTime time.Time `orm:"auto_now;type(datetime)"`
	IsAdmin       int       `json:"-"`

	//Solution       []*Solution `orm:"reverse(many)"`
	SolutionsCount int `orm:"default(0);index"`
	AcceptsCount   int `orm:"default(0);index"`
	Radio          float64
	Rank           int
}

type Problem struct {
	Pid            int       `orm:"pk;auto;unique"`
	Uid            int
	Title          string
	TimeLimit      int
	MemoryLimit    int
	Description    string
	Input          string
	Output         string
	SampleInput    string
	SampleOutput   string
	Hint           string
	Source         string
	IsDisplay      bool      `orm:"default(True);index"`
	IsSpecialJudge bool      `orm:"default(False);index"`
	IsVjudge       bool
	DateCreated    time.Time `orm:"auto_now_add;type(datetime)"`
	DateUpdate     time.Time `orm:"auto_now";type(datetime):`

	SolutionsCount     int `orm:"default(0);index"`
	AcceptsCount       int `orm:"default(0);index"`
	SolutionUsersCount int `orm:"default(0);index"`
	AcceptUsersCount   int `orm:"default(0);index"`
}

type Contest struct {
	Cid         int `orm:"pk;auto"`
	Uid         int
	Name        string
	Description string
	StartTime   time.Time
	EndTime     time.Time
	Problems    string
	Type        int
}
type Solution struct {
	Sid             int       `orm:"pk"`
	Pid             int       `orm:"index;default(0)"` //检索使用
	Uid             int       `orm:"index;default(0)"json:"-"` //检索使用
	Cid             int       `orm:"index;default(0)"json:"-"` //必须保留
	Result          int       `orm:"index;default(0)"json:"-"`  //
	Length          int       `orm:"default(0)"json:"-"`
	TakeTime        int       `orm:"default(0)"json:"-"`
	TakeMemory      int       `orm:"default(0)"json:"-"`
	ProgramLanguage string    `orm:"index"`
	Code            string
	DateCreated     time.Time `orm:"auto_now;index"json:"-"`
	User            *User     `orm:"rel(fk)"` //排名时需要用户名
	//Contest         *Contest  `orm:"rel(fk)"`
	Problem *Problem `orm:"rel(fk)"` //需要知道题目的时空限制
}
type News struct {
	Nid         int       `orm:"pk;auto"`
	Uid         int
	Title       string
	Content     string
	DateCreated time.Time `orm:"type(datetime);auto_now_add"`
}

func init() {
	orm.RegisterDriver("mysql", orm.DRMySQL)
	orm.RegisterDataBase("default", "mysql", "root:root@/oj?loc=Local")
	orm.RegisterModel(new(User))
	orm.RegisterModel(new(Problem))
	orm.RegisterModel(new(Solution))
	orm.RegisterModel(new(News))
	orm.RegisterModel(new(Contest))
	orm.RunSyncdb("default", false, true)

}
