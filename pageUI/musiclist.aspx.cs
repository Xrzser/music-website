using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.BLL;
using Model.Model;
using System.Web.Services;

public partial class musiclist : System.Web.UI.Page
{
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();
    static Bllsinger bllsinger = new Bllsinger();
    static Bllsongsheets bllsongsheets = new Bllsongsheets();
    static Bllfavorite bllfavorite = new Bllfavorite();

    //获得用户id
    public int getUserId()
    {
        return (int)Session["userid"];
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }

    [WebMethod]
    public static List<Modelsinger> getSinger(int offset, int rows)
    {
        return bllsinger.pageQuerySingerList(offset, rows);
    }

    [WebMethod]
    public static int getSingerNum()
    {
        return bllsinger.querySingerNum();
    }

    [WebMethod]
    public static List<Modelmusicinfo>  Getmusic(int offset,int rows,string singerName)
    {
        return bllmusicinfo.pagequerymusic(offset,rows,singerName);
    }

    [WebMethod]
    public static int getmusicnum(string singerName)
    {
        return bllmusicinfo.getmusicnum(singerName);
    }

    [WebMethod]
    public static Modelsinger getSingerItem(string singerName)
    {
        return bllsinger.querySingerItemByName(singerName);
    }

    //向歌单中添加歌曲
    [WebMethod]
    public static int addmusictosheet(string checkedmusicid, int itemchecked) 
    {
        if (itemchecked == 0)
        {
            return bllfavorite.addfavMusic(checkedmusicid,new musiclist().getUserId());
        }
        else
        {
            return bllsongsheets.addMusic(checkedmusicid, itemchecked);
        }
    }


}