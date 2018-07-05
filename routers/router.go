package routers

import (
	"github.com/astaxie/beego"
	"onlinejudge/controllers"
)

func init() {
	//index
	beego.Router("/", &controllers.IndexController{})

	//user
	beego.AutoRouter(&controllers.UserController{})
	beego.Router("/standings", &controllers.UserController{}, "*:Sort")

	//problems
	beego.Router("/problems", &controllers.ProblemController{}, "*:List")
	beego.Router("/problem/:pid", &controllers.ProblemController{}, "*:ProblemById")
	beego.Router("/problem/:pid/edit", &controllers.ProblemController{}, "*:Create")
	beego.Router("/problem/:pid/upload", &controllers.ProblemController{}, "*:Upload")

	//contests
	beego.Router("/contests", &controllers.ContestController{}, "*:List")
	beego.Router("/contest/:cid", &controllers.ContestController{}, "*:ContestById")
	beego.Router("/contest/:cid/edit", &controllers.ContestController{}, "*:Edit")
	beego.Router("/contest/:cid/problem/:pid", &controllers.ContestController{}, "*:ContestProblem")
	beego.Router("/contest/:cid/submit/:pid", &controllers.ContestController{}, "*:ContestSubmit")
	beego.Router("/contest/:cid/status", &controllers.ContestController{}, "*:ContestStatus")
	beego.Router("/contest/:cid/ranklist", &controllers.ContestController{}, "*:ContestRank")

	//status
	beego.Router("/status", &controllers.SolutionController{}, "*:List")
	beego.Router("/viewcode/:sid", &controllers.SolutionController{}, "*:ViewCode")
	beego.Router("/submit/:pid", &controllers.SolutionController{}, "*:Submit")
	beego.Router("/api/status", &controllers.SolutionController{}, "get:APIGet;post:APIPost")

	//news
	beego.Router("/news", &controllers.NewsController{}, "*:List")
	beego.Router("/news/:id", &controllers.NewsController{}, "*:NewsById")
	beego.Router("/news/add", &controllers.NewsController{}, "*:Create;post:Save")

}
