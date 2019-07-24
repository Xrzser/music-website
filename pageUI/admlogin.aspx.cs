using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.BLL;
using Model.Model;

public partial class admlogin : System.Web.UI.Page
{
    static Blladministrators blladministrators = new Blladministrators();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void signin_Click(object sender, EventArgs e)
    {
        //管理员登录并跳转到首页
        Modeladministrators adm=blladministrators.admlogin(this.name.Text,this.password.Text);
        if (adm == null) { Response.Write("<script>alert('名字或密码错误');</script>");}
        else
        {
            Session.Add("administratorsId", adm.administratorsId);
            Session.Add("administratorsName",adm.administratorsName);
            Session.Add("administratorsLimit", adm.administratorsLimit);
            Response.Redirect("admdefault.aspx");
        }
    }
}