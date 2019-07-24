using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using BLL.BLL;

public partial class musicset : System.Web.UI.Page
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        //获得要保存的数据
        string singerName = this.TextBox1.Text;
        string singerContent = this.TextBox3.Text;
        int singerSex;
        if (this.RadioButton1.Checked == true) { singerSex = 1; } else { singerSex = 0; }
        //上传头像
        string fileName = ((DateTime.Now.ToUniversalTime().Ticks - 621355968000000000) / 10000)+new Random().Next()+".jpg";
        string singerImage = "\\images\\singer\\" + fileName;
        //获得上传文件大小
        int fileLength = this.FileUpload1.PostedFile.ContentLength;
        if (fileLength < 104857600)
        {
            //把文件上传到服务器
            this.FileUpload1.SaveAs(Server.MapPath("\\images\\singer\\" + fileName));
        }
        //保存歌手信息
        bllsinger.addSinger(singerName,singerSex,singerContent,singerImage);
        //返回提示
        Response.Write("<script>alert('歌手添加成功');</script>");
    }

    //编辑歌手
    [WebMethod]
    public static int editSinger(int singerId, string singerName, int singerSex, string singerContent)
    {
        return bllsinger.editSinger(singerId, singerName, singerSex, singerContent);
    }
    //删除歌手
    [WebMethod]
    public static int delSinger(int singerId)
    {
        return bllsinger.delSinger(singerId);
    }
    //编辑歌曲
    [WebMethod]
    public static int editMusic(string musicName, string musicSinger, int musicId)
    {
        return bllmusicinfo.editMusic(musicName, musicSinger, musicId);
    }
    //删除歌曲
    [WebMethod]
    public static int delMusic(int musicId)
    {
        return bllmusicinfo.delMusic(musicId);
    }
}