package models

/*
import (
	"github.com/astaxie/beego/orm"
	"crypto/md5"
	"io"
	"encoding/hex"
)
func (file *File)SaveFile(){
	//path := beego.AppConfig.String("uploadPath")

}

func (file *File) CalcMD5() {
	md5hash := md5.New()
	io.Copy(md5hash,file.File)
	file.MD5 = hex.EncodeToString(md5hash.Sum(nil))
}
func (file *File) Create()(int64,bool) {
	o := orm.NewOrm()
	o.Using("default")
	fid,err := o.InsertOrUpdate(file)
	if nil == err{
		return fid,true
	}
	return fid,false
}
*/