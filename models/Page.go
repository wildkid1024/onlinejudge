package models

import (
	"reflect"
)

type Page struct {
	PageNo     int
	PageSize   int
	TotalPage  int
	TotalCount int
	FirstPage  bool
	LastPage   bool
	List       interface{}
}
func PageUtil(count int, pageNo int, pageSize int, list []interface{}) Page {
	tp := count / pageSize
	if count % pageSize > 0 {
		tp = count / pageSize + 1
	}
	if  pageNo < 1 || pageNo * pageSize >= count+pageSize{
		pageNo = 1
	}

	st,end := pageSize*(pageNo-1),pageSize*(pageNo)
	if st > count || st < 0{
		st = 0;
	}
	if end > count || end < 0 {
		end = count
	}
	pageList := list[st:end]
	return Page{PageNo: pageNo, PageSize: pageSize, TotalPage: tp, TotalCount: count, FirstPage: pageNo == 1, LastPage: pageNo == tp, List: pageList}
}

func ToSlice(arr interface{}) []interface{} {
	v := reflect.ValueOf(arr)
	if v.Kind() != reflect.Slice {
		panic("toslice arr not slice")
	}
	l := v.Len()
	ret := make([]interface{}, l)
	for i := 0; i < l; i++ {
		ret[i] = v.Index(i).Interface()
	}
	return ret
}
