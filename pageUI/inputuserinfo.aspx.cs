using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Model.Model;
using System.Data;
using BLL.BLL;

public partial class inputuserinfo : System.Web.UI.Page
{
    static Blluserinfo blluserinfo = new Blluserinfo();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void upload_Click(object sender, EventArgs e)
    {
        string fileName = "p"+Session["id"].ToString()+".jpg";
        //获得上传文件大小
        int fileLength = this.uploadportrait.PostedFile.ContentLength;
        string filetype = this.uploadportrait.PostedFile.ContentType;
        if (fileLength == 0)
        {
            Response.Write("<script>alert('请选择有效的文件');</script>");
        }
        else if (filetype!="image/jpeg"&&filetype!="image/png")
        {
            Response.Write("<script>alert('该系统目前仅支持JPEG(jpg)和png格式的图片，请重新上传');</script>");
        }
        else
        {
            if (fileLength < 104857600)
            {
                //把文件上传到服务器
                this.uploadportrait.SaveAs(Server.MapPath("\\images\\portrait\\" + fileName));
                ClientScript.RegisterStartupScript(Page.GetType(), "test", "<script>showimage()</script>");
            }
            else
            {
                Response.Write("<script>alert('文件过大，超过系统限制。');</script>");
            }
        }
        
    }
    public int getId(){
        return (int)Session["id"];
    }
    [WebMethod]
    public static int setUserInfo(string location, string signature, string singer, int sex, string rhythm,string emotion,string type,string language)
    {
        Modeluserinfo userinfo=new Modeluserinfo();
        userinfo.userId = new inputuserinfo().getId();
        userinfo.userLocation=location;
        userinfo.userSignature=signature;
        userinfo.userSinger=singer;
        userinfo.userSex=sex;
        userinfo.userRhythm=rhythm;
        userinfo.userEmotion=emotion;
        userinfo.userType=type;
        userinfo.userLanguage=language;
        return blluserinfo.updateUserInfo(userinfo);
    }
}