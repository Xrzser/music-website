using BLL.BLL;
using Model.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class share : System.Web.UI.Page
{
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string url = Request.Url.ToString();
            int musicId = 0;
            try
            {
                musicId = int.Parse(url.Split('?')[1].Split('=')[1]);
            }
            catch (Exception) { }
            ClientScript.RegisterStartupScript(Page.GetType(),"TestEvent", "<script>getmusic(" + musicId + ");</script>");
        }
    }
    protected void LinkButton_logout_Click(object sender, EventArgs e)
    {
        Session.Clear();
    }
    protected void LinkButton_aboutus_Click(object sender, EventArgs e)
    {
        Response.Redirect("aboutus.aspx");
    }

    [WebMethod]
    public static Modelmusicinfo getmusic(int id)
    {
        return bllmusicinfo.querymusicitem(id);
    }
}