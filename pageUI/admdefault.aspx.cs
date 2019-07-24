using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.BLL;
using System.Data.SqlClient;
using System.Web.Services;
using Model.Model;

public partial class admdefault : System.Web.UI.Page
{
    static Blladministrators blladministrators = new Blladministrators();
    static HttpResponse response = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        response = Response;
        if (Session["administratorsId"] == null)
        {
            Response.Redirect("admlogin.aspx");
        }
        else
        {
            Session.Timeout = 30;
        }
    }

    protected void LinkButton_logout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("admlogin.aspx");
    }
    protected void LinkButton_aboutus_Click(object sender, EventArgs e)
    {
        Response.Redirect("aboutus.aspx");
        
    }

    [WebMethod]
    public static int updatepwd(string op,string np) {
        if (new admdefault().Session["administratorsId"] == null)
        {
            return -1;
        }
        else
        {
            int temp = blladministrators.newPwd(op, np, (int)new admdefault().Session["administratorsId"]);
            if (temp == 0)
            {
                new admdefault().Session.Clear();
            }
            return temp;
        }
    }

}