using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.Model;
using BLL.BLL;

public partial class musicupload : System.Web.UI.Page
{
    static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Response.Write("<script> parent.location.href='signin.aspx'</script>");
        }
    }
    protected void upload_Click(object sender, EventArgs e)
    {
        Modelmusicinfo musicinfo = new Modelmusicinfo();
        //select rhythm
        if (kuai.Checked == true)
        {
            musicinfo.musicRhythm = 0;
        }
        else if (man.Checked == true)
        {
            musicinfo.musicRhythm = 1;
        }
        else
        {

        }
        //select emotion
        if (gaoxing.Checked == true)
        {
            musicinfo.musicEmotion = 0;
        }
        else if(shanggan.Checked==true)
        {
            musicinfo.musicEmotion = 1;
        }
        else if (huaijiu.Checked == true)
        {
            musicinfo.musicEmotion = 2;
        }
        else if (aiqing.Checked == true)
        {
            musicinfo.musicEmotion = 3;
        }
        else
        {

        }

        //select type
        if (liuxin.Checked == true)
        {
            musicinfo.musicType = 0;
        }
        else if (chunyinyue.Checked == true)
        {
            musicinfo.musicType = 1;
        }
        else if(mingyao.Checked==true)
        {
            musicinfo.musicType=2;
        }
        else
        {

        }

        //select language
        if(ch.Checked==true)
        {
            musicinfo.musicLanguage = 0;
        }
        else if(en.Checked==true){
            musicinfo.musicLanguage=1;
        }
        else
        {

        }
        musicinfo.musicName=musicname.Text;
        musicinfo.musicSinger = musicsinger.Text;
        if (musicinfo.musicName == "" || musicinfo.musicSinger == "")
        {
            Response.Write("<script>alert('歌曲名和歌手名为必填项');</script>");
        }
        else
        {
            //生成文件名字
            string fileName = ((DateTime.Now.ToUniversalTime().Ticks - 621355968000000000) / 10000) + new Random().Next() + ".mp3";
            //获得上传文件的完整路径
            string fullFileName = "\\music\\" + fileName;
            //获得上传文件大小
            int fileLength = this.Fileupload.PostedFile.ContentLength;
            string typestr = this.Fileupload.PostedFile.ContentType;
            if (fileLength == 0)
            {
                Response.Write("<script>alert('请选择要上传的音乐文件');</script>");
            }
            else if(typestr!="audio/mp3")
            {
                Response.Write("<script>alert('系统目前仅支持MP3格式的文件');</script>");
            }
            else
            {
                musicinfo.musicPath = fullFileName;
                musicinfo.uploadUserId = (int)Session["userid"];
                if (fileLength < 104857600)
                {
                    //把文件上传到服务器
                    Response.Write("<div id='list-table1' class='bg-white-only table-bordered padder-md padder-v' style='position: absolute; left: 30%; top: 15%; width: 30%; height: 300px;z-index:999'><h2>文件正在上传，请稍等，也不要刷新页面</h2></div>");
                    this.Fileupload.SaveAs(Server.MapPath("\\music\\" + fileName));
                    //把音乐信息存放在数据库
                    if (bllmusicinfo.uploadmusic(musicinfo) != 0)
                    {
                        Response.Write("<script>alert('歌曲上传成功');window.location.href='musicupload.aspx'</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('歌曲已经存在');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('文件过大，超过系统限制');</script>");
                }
            }
        }
          
    }
}