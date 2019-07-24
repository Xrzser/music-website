using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using BLL.BLL;
using Model.Model;

public partial class updateuserinfo : System.Web.UI.Page
{
    static Blluserinfo blluserinfo = new Blluserinfo();
    static Blluser blluser = new Blluser();

    protected void Page_Load(object sender, EventArgs e)
    {

    }



    //变更session中的用户名
    public void updateusername(string name){
        Session["username"]=name;
    }

    [WebMethod]
    public static int setUserInfo(string username, string userid, string usersex, string userlocation, string usersignature, string userrhythm, string useremotion, string usertype, string userlanguage, string usersinger){
        Modeluserinfo userinfo = new Modeluserinfo();
        userinfo.userId = int.Parse(userid);
        userinfo.userSex = int.Parse(usersex);
        userinfo.userLocation = userlocation;
        userinfo.userSignature = usersignature;
        userinfo.userRhythm = userrhythm;
        userinfo.userEmotion = useremotion;
        userinfo.userType = usertype;
        userinfo.userLanguage = userlanguage;
        userinfo.userSinger = usersinger;
        blluserinfo.updateUserInfo(userinfo);
        blluser.updateUserName(int.Parse(userid), username);
        new updateuserinfo().updateusername(username);
        return 1;
    }
    protected void upload_Click(object sender, EventArgs e)
    {
        string fileName = "p" + Session["userid"].ToString() + ".jpg";
        //获得上传文件大小
        int fileLength = this.uploadportrait.PostedFile.ContentLength;
        string filetype = this.uploadportrait.PostedFile.ContentType;
        if (fileLength == 0)
        {
            Response.Write("<script>alert('请选择有效的文件');</script>");
        }
        else if (filetype != "image/jpeg" && filetype != "image/png")
        {
            Response.Write("<script>alert('该系统目前仅支持JPEG(jpg)和png格式的图片，请重新上传');</script>");
        }
        else
        {
            if (fileLength < 104857600)
            {
                //把文件上传到服务器
                this.uploadportrait.SaveAs(Server.MapPath("\\images\\portrait\\" + fileName));
            }
            else
            {
                Response.Write("<script>alert('文件过大，超过系统限制。');</script>");
            }
        }
    }
}