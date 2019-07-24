using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using BLL.BLL;

public partial class updateuserpwd : System.Web.UI.Page
{
    
    static Blluser blluser=new Blluser();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    public int getId()
    {
        return (int)Session["userid"];
    }
    public void clearSession(){
        Session.Clear();
    }
    [WebMethod]
    public static int updateUserPwd(string opwd,string npwd)
    {
        if (blluser.updateUserPassword(new updateuserpwd().getId(), opwd, npwd)==1)
        {
            new updateuserpwd().clearSession();
            return 1;
        }
        else
        {
            return 0;
        }
    }
}