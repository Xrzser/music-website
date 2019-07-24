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
    public class Daladministrators
    {
        static SqlConnection conn = Conn.getconn();

        //根据管理员用户名查询管理员
        public DataSet getAdm(string userName){
            conn.Open();
            string sql = "select * from tbadministrators where administrators_name='"+userName+"'";
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //查询所有管理员（除超管）
        public DataSet getAlladmsinfo()
        {
            conn.Open();
            string sql = "select administrators_id,administrators_name,administrators_limit from tbadministrators where administrators_id!=1";
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //插入管理员
        public int insertAdm(string Name)
        {
            string sql = "insert into tbadministrators(administrators_name) values('"+Name+"')";
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //删除管理员
        public int deleteAdm(int id)
        {
            string sql = "delete from tbadministrators where administrators_id="+id;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //重置管理员密码
        public int resetAdmpwd(int id)
        {
            string sql = "update tbadministrators set administrators_password='111111' where administrators_id=" + id;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //编辑管理员
        public int updateAdm(Modeladministrators adm)
        {
            string sql = "update tbadministrators set administrators_name='"+adm.administratorsName+"',administrators_limit='"+adm.administratorsLimit+"' where administrators_id="+adm.administratorsId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //查询管理员密码
        public string getPwd(int id)
        {
            string sql = "select administrators_password from tbadministrators where administrators_id="+id;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            string temp = cmd.ExecuteScalar().ToString();
            conn.Close();
            return temp;
        }
        //设置管理员密码
        public int setPwd(string np,int id)
        {
            string sql = "update tbadministrators set administrators_password='" + np + "' where administrators_id=" + id;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
    }
}
