package models

import "time"

type JudgeResult struct {
	Sid             int `json:"sid"`
	Result          int `json:"result"`
	Length          int
	TakeTime        int
	TakeMemory      int
	ProgramLanguage string
	Code            string
}

type RankUser [][]struct {
	IsAc     bool
	AcTime   time.Time
	Attempts int
}
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
