using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.Model;
using BLL.BLL;
using System.Web.Services;

public partial class profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    public Modeluserinfo getuserinfo()
    {
        Blluserinfo blluserinfo = new Blluserinfo();
        Modeluserinfo userinfo = blluserinfo.loaduserinfo((int)Session["userid"]);
        return userinfo;
    }
    //通过WebMethod的静态方法，访问自己cs后面的方法
    [WebMethod]
    public static Modeluserinfo GetMsgByWeb()
    {
        return new profile().getuserinfo();
    }
}