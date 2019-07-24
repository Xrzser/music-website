using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.DAL
{
    public class Conn
    {
        public static SqlConnection getconn()
        {
            String constr = ConfigurationManager.AppSettings["connstring"].ToString();
            SqlConnection myconn = new SqlConnection(constr);  
            return myconn;
        }
    }
}
