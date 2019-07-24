using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.Model;
using BLL.BLL;

public partial class signup : System.Web.UI.Page
{
    //加载页面
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    //正则表达式判断是否为邮箱邮箱
    public bool IsEmail(string value)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(value, @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
    }

    //正则表达式判断是否为数字字母下划线组成的字符串
    public bool Iscan(string value)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(value, @"^[0-9a-zA-Z_]{1,}$");
    }

    //点击注册按钮
    protected void sign_up_Click(object sender, EventArgs e)
    {
        Modeluser user = new Modeluser();
        Blluser blluser=new Blluser();
        
        //判断是否选中了复选框同意条款
        if(!this.CheckBox1.Checked)
        {
            Response.Write("<script>alert('请同意并勾选隐私条款');</script>");
        }
        else
        {
            //获取Textbox中的值
            user.userName = this.name.Text;
            user.userPwd = this.Password.Text;
            user.userEmail = this.Email.Text;
            if(user.userName.Equals("")||user.userPwd.Equals("")||user.userEmail.Equals(""))
            {
                this.name.Focus();
                Response.Write("<script>alert('注册信息不能存在空值');</script>");
            }
            else if(!IsEmail(user.userEmail)){
                this.Email.Focus();
                Response.Write("<script>alert('请输入有效的邮箱');</script>");
            }
            else if(!Iscan(user.userPwd)){
                this.Password.Focus();
                Response.Write("<script>alert('密码只能由数字字母和下划线组成');</script>");
            }
            else if(user.userName.Length>12){
                this.name.Focus();
                Response.Write("<script>alert('用户名过长');</script>");
            }
            else
            {
                //注册该用户
                if( !blluser.signup(user))//用户已经注册过
                {
                    Response.Write("<script>alert('该邮箱已注册，您可以使用该邮箱登录');</script>");       
                }
                else
                {
                    //跳转到添加个人信息页面
                    user.Id = blluser.queryUserIdByEmail(user.userEmail);
                    Session.Add("id", user.Id);
                    Response.Redirect("inputuserinfo.aspx");
                }
                
            }    
        }        
    }

}