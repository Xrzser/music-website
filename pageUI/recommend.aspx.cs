using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Model.Model;
using BLL.BLL;

public partial class recommend : System.Web.UI.Page
{
    static Bllrecommend bllrecommend = new Bllrecommend();
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //得到用户推荐的音乐
    [WebMethod]
    public static List<Modelmusicinfo> getRecommendMusic(){
        if (new recommend().Session["userid"] == null) {
            return bllmusicinfo.getMusicbyNewid();
        }
        else
        {
            return bllrecommend.getRecommendMusic((int)new recommend().Session["userid"]);
        }
    }
    //得到用户推荐更新时间
    [WebMethod]
    public static string getRecommendTime()
    {
        if (new recommend().Session["userid"] == null) { return null; }
        else
        {
            return bllrecommend.getRecommendTime((int)new recommend().Session["userid"]);
        }
    }
}