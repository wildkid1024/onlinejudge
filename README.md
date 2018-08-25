
## SDAU onlineJudge

--------

这是一个使用golang编写的onlinejudge系统，设计目的是为了给学弟学妹提供一个好的练习平台。

在UI上借用了[山东理工大学](http://acm.sdut.edu.cn/onlinejudge2)的前端模板，使用了Bootstarp和amazeui，在此向他们表示感谢。

在后台设计上，借鉴参考了[SyzOj](https://github.com/Zhengzhou-11-Highschool/syzoj)以及[Hustoj](https://github.com/freefcw/hustoj)，他们解决问题的思路给了我很多灵感，向开源作者致敬。


## 如何部署

如果你对如何编译生成golang程序一无所知，那么请直接下载onlinejudge.exe文件，直接运行它，就可以在localhost:8080端口看到应用程序。
ps：请保证你的机器上已经安装了golang环境和mysql数据库。

我更推荐你clone一份代码并编译它，这样你可以自定义你各种选项。

端口，判题token和上传目录在app.conf中修改。

连接数据库的操作在/models/Models.go文件中。

各个路由操作参考/routers/router.go文件。

## 问题及反馈

可以直接在issue中反馈你遇到的bug。

以下列表将展示我将要完成的功能：

- [ ] 提交判题结果到后台
- [ ] 集合配置到配置文件中
- [ ] 相关的数据API接口
- [ ] 当注册时发送注册邮件
- [ ] 注册和登录过滤









