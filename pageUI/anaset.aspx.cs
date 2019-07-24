using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Model.Model;
using BLL.BLL;

public partial class anaset : System.Web.UI.Page
{
    static Bllsinger bllsinger = new Bllsinger();
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["administratorsId"] == null)
        {
            Response.Redirect("admlogin.aspx");
        } 
    }

    [WebMethod]
    public static List<Modelsinger> getSinger(int offset, int rows)
    {
        return bllsinger.pageQuerySingerListByhot(offset, rows);
    }
    [WebMethod]
    public static List<Modelmusicinfo> getMusic(int offset, int rows)
    {
        return bllmusicinfo.pagequerymusicByhot(offset, rows);
    }
}