package controllers

type IndexController struct {
	BaseController
}

//Index
func (c *IndexController) Get() {
	c.Data["title"] = "Home "
	c.Data["daylist"] = ""
	c.Data["submitdata"] = ""

	c.Layout = "layout.tpl"
	c.TplName = "index.tpl"
	c.LayoutSections = make(map[string]string)
	c.LayoutSections["HtmlHead"] = ""

}
