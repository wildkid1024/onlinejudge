package main

import (
	"net/http"
	"strings"
	"log"
	"fmt"
)

func main() {
	url := "http://localhost:8080/api/status?token=1234"
	postData := `
        {
       "touser":"OPENID",
          "msgtype":"text",
           "text":
          {
          "content":"THECONTENT"
          }
        }
        `
	data,err := http.Post(url,"application/json",strings.NewReader(postData))
	if err != nil{
		log.Fatal(err)
	}
	fmt.Println(data)

}
