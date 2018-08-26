package models

type APISolution struct {
	Sid             int
	Pid             int
	Result          int
	Length          int
	ProgramLanguage string
	Code            string
	TimeLimit       int
	MemoryLimit     int
	UsedTime        int
	UsedMemory      int
}
