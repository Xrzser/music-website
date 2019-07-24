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

public partial class _Default : System.Web.UI.Page
{
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();
    static Bllsongsheets bllsongsheets = new Bllsongsheets();

    protected void Page_Load(object sender, EventArgs e)
    {
            Session.Timeout = 30;
    }

    protected void LinkButton_logout_Click(object sender, EventArgs e)
    {
        Session.Clear();
    }
    protected void LinkButton_aboutus_Click(object sender, EventArgs e)
    {
        Response.Redirect("aboutus.aspx");
    }

    //查询音乐item
    [WebMethod]
    public static Modelmusicinfo getmusicinfo(int musicid)
    {
        return bllmusicinfo.querymusicitem(musicid);
    }
    //单曲播放量加一
    [WebMethod]
    public static int addMusicvolume(int musicid)
    {
        return bllmusicinfo.addMusicvolume(musicid);
    }
    //歌单播放量+1
    [WebMethod]
    public static int addSongsheetvolume(int songsheetId)
    {
        return bllsongsheets.addSongsheetvolume(songsheetId);
    }
}