using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using BLL.BLL;
using Model.Model;

public partial class mylist : System.Web.UI.Page
{
    static Bllsongsheets bllsongsheets = new Bllsongsheets();
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();
    static Bllfavorite bllfavorite = new Bllfavorite();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Response.Write("<script> parent.location.href='signin.aspx'</script>");
        }
    }
    //获取session
    public int getsession()
    {
        return (int)Session["userid"];
    }

    //创建歌单
    [WebMethod]
    public static int createSongsheet(string songsheetName,string songsheetContent,int ispublic)
    {
        bllsongsheets.createSongsheet(new mylist().getsession(),songsheetName,songsheetContent,ispublic);
        return 0;
    }
    //查询我创建的歌单简要信息
    [WebMethod]
    public static List<Modelsongsheets> querycreatedSongsheets()
    {
        return bllsongsheets.getSongsheetsByCreateuserid(new mylist().getsession());
    }

    //查询我收藏的歌单简要信息
    [WebMethod]
    public static List<Modelsongsheets> getFavoriteSongsheets()
    {
        return bllsongsheets.getSongsheetBystr(bllfavorite.getFavoriteSongsheets(new mylist().getsession()));
    }

    //查询我收藏的曲目
    [WebMethod]
    public static List<Modelmusicinfo> getFavoritedMusic()
    {
        string str=bllfavorite.getFavoriteMusic(new mylist().getsession());
        return bllmusicinfo.queryMusicListBysongsheetId(str);
    }

    //根据歌单id查询歌曲
    [WebMethod]
    public static List<Modelmusicinfo> getmusiclistBysongsheetId(int songsheetid)
    {
        return bllmusicinfo.queryMusicListBysongsheetId(bllsongsheets.getmusicidstr(songsheetid));
    }

    //删除歌单中的歌曲
    [WebMethod]
    public static int deleteMusic(string musicId, int songsheetId)
    {
        return bllsongsheets.deleteMusic(musicId, songsheetId);
    }

    //删除我的收藏中的音乐
    [WebMethod]
    public static int deletefavMusic(string musicId)
    {
        return bllfavorite.deletefavMusic(musicId, new mylist().getsession());
    }

    //设置用户创建的歌单无效
    [WebMethod]
    public static int setNoValid(int songsheetId)
    {
        return bllsongsheets.setNoVaild(songsheetId);
    }
    //删除收藏的歌单
    [WebMethod]
    public static int deleteFavsheet(string songsheetId)
    {
        return bllfavorite.deleteFavSongsheet((int)new mylist().Session["userid"],songsheetId);
    }
}