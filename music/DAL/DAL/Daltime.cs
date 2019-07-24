using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Model.Model;

namespace DAL.DAL
{
    public class Daltime
    {
        static SqlConnection conn = Conn.getconn();

        //插入当前时间
        public int insertTimenow(string timestr)
        {
            conn.Open();
            string sql = "  insert into tbtime(time_str) values ('"+timestr+"')";
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

    }
}
