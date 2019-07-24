using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.Model;
using BLL.BLL;

public partial class signin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session.Clear();
        }
    }
    //正则表达式判断是否为邮箱邮箱
    public bool IsEmail(string value)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(value, @"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
    }
    protected void Email_TextChanged(object sender, EventArgs e)
    {
        //改变Email值且该控件失去焦点时后触发
    }

    protected void password_TextChanged(object sender, EventArgs e)
    {
        //改变password值且该控件失去焦点时后触发
    }
    protected void signin_Click(object sender, EventArgs e)
    {
        //用户登录并跳转到首页
        Modeluser user = new Modeluser();
        Blluser blluser = new Blluser();
        if (IsEmail(this.email.Text) == true)
        {
            user = blluser.signin(this.email.Text, this.password.Text);
            if (user == null)
            {
                Response.Write("<script>alert('邮箱或密码错误');</script>");
            }
            else
            {
                if (user.Id == 0) { Response.Write("<script>alert('没有该用户，请检查输入是否正确');</script>"); }
                else if (user.Id == -1) { Response.Write("<script>alert('该用户被封禁，请联系客服人员。');</script>"); }
                else
                {
                    Session.Add("userid", user.Id);
                    Session.Add("username", user.userName);
                    Session.Add("userpwd", user.userPwd);
                    Session.Add("useremail", user.userEmail);
                    Response.Redirect("default.aspx");
                }
            }
        }
        else
        {
            Response.Write("<script>alert('请输入有效的邮箱');</script>");
        }
    }
}