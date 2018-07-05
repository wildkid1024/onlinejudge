package main

import (
	"net/http"
	"log"
	"fmt"
	"encoding/json"
	"io/ioutil"
)

type People struct {
	Name string
	Age  int
}
type PeopleSlice struct {
	Peoples []People
}

func getData() PeopleSlice {
	//f, e := os.Open("data.json")
	b, e := ioutil.ReadFile("./data.json")
	if e != nil {
		fmt.Println("打开文件失败")
	}
	var data PeopleSlice
	json.Unmarshal(b, &data)
	//fmt.Println(data)
	return data
}
func people(w http.ResponseWriter, r *http.Request) {
	r.ParseForm()
	name := r.Form["name"]
	data := getData()

	var tmp People
	for _, v := range data.Peoples {
		if v.Name == name[0] {
			tmp = v
			break
		}
	}
	json, _ := json.Marshal(tmp)
	w.Header().Set("Content-Type", "application/json;charset=utf-8")
	fmt.Fprintln(w, string(json))

	//fmt.Println(data)
}
func main() {
	http.HandleFunc("/people", people)
	err := http.ListenAndServe(":9090", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
