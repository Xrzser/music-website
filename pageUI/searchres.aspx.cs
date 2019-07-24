using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Model.Model;
using BLL.BLL;

public partial class searchres : System.Web.UI.Page
{
    static Blltools blltools = new Blltools();
    static Bllfavorite bllfavorite = new Bllfavorite();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //关键字歌曲搜索
    [WebMethod]
    public static List<Modelmusicinfo>  searchMusic(int offset,int rows,string keywords)
    {
        return blltools.searchMusic(offset,rows,keywords);
    }

    //查询搜索结果的数目
    [WebMethod]
    public static int getresnum(string keywords)
    {
        return blltools.getresnum(keywords);
    }
    //关键字搜索歌单
    [WebMethod]
    public static List<Modelsongsheets> serarchSongsheet(int offset,int rows,string keywords){
        return blltools.searchSongsheet(offset, rows, keywords);
    }
    //关键字搜索歌单数量
    [WebMethod]
    public static int getSongsheetnum(string keywords)
    {
        return blltools.getSongsheetnum(keywords);
    }
    //收藏歌单
    [WebMethod]
    public static int favSongsheet(string songsheetId)
    {
        return bllfavorite.favSongsheet(songsheetId,(int)new searchres().Session["userid"]);
    }
}