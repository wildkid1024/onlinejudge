package models

type APISolution struct {
	Sid             int    `orm:"pk"`
	Pid             int    `orm:"index;default(0)"`         //检索使用
	Result          int    `orm:"index;default(0)"json:"-"` //
	Length          int    `orm:"default(0)"json:"-"`
	ProgramLanguage string `orm:"index"`
	Code            string
	TimeLimit       int
	MemoryLimit     int
}
