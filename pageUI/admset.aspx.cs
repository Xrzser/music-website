using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Model.Model;
using BLL.BLL;

public partial class admset : System.Web.UI.Page
{
    static Blladministrators blladministrators = new Blladministrators();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["administratorsId"] == null)
        {
            Response.Redirect("admlogin.aspx");
        } 
    }

    //查询管理员列表
    [WebMethod]
    public static List<Modeladministrators> getAlladmsinfo()
    {
        if ((int)new admset().Session["administratorsId"] != 1) { return null; }
        return blladministrators.getAlladmsinfo();
    }
    //添加管理员
    [WebMethod]
    public static int addAdm(string Name)
    {
        if ((int)new admset().Session["administratorsId"] == 1)
        {
            return blladministrators.addAdm(Name);
        }
        else
        {
            return 0;
        }
    }
    //删除管理员
    [WebMethod]
    public static int deleteAdm(int id)
    {
        if ((int)new admset().Session["administratorsId"] == 1)
        {
            return blladministrators.deleteAdm(id);
        }
        else
        {
            return 0;
        }
        
    }
    //重置管理员密码
    [WebMethod]
    public static int resetAdmpwd(int id)
    {
        if ((int)new admset().Session["administratorsId"] == 1)
        {
            return blladministrators.resetAdmpwd(id);
        }
        else
        {
            return 0;
        }
        
    }
    //编辑管理员
    [WebMethod]
    public static int updateAdm(int id,string name,string limit)
    {
        if ((int)new admset().Session["administratorsId"] == 1)
        {
            Modeladministrators adm = new Modeladministrators();
            adm.administratorsId = id;
            adm.administratorsName = name;
            adm.administratorsLimit = limit;
            return blladministrators.updateAdm(adm);
        }
        else
        {
            return 0;
        } 
    }
}