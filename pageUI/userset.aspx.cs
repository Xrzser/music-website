using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Model.Model;
using BLL.BLL;
using System.Data;

public partial class userset : System.Web.UI.Page
{
    static Blluser blluser = new Blluser();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["administratorsId"] == null)
        {
            Response.Redirect("admlogin.aspx");
        } 
    }

    //修改密码
    [WebMethod]
    public static int updateUserPassword(int userId, string oldPwd, string newPwd)
    {
        return blluser.updateUserPassword(userId, oldPwd, newPwd);
    }

    //分页查询用户
    [WebMethod]
    public static List<Modeluser> pageQueryuser(int offset, int rows)
    {
        return blluser.pageQueryuser(offset, rows);
    }

    //获得用户数量
    [WebMethod]
    public static int getUsernum()
    {
        return blluser.getUsernum();
    }

    //重置密码
    [WebMethod]
    public static int resetPwd(int userId)
    {
        return blluser.resetPwd(userId);
    }

    //保存修改后的用户信息
    [WebMethod]
    public static int save(int id,string name,int valid)
    {
        blluser.updateUserName(id, name);
        blluser.setNovalid(id, valid);
        return 0;
    }

}