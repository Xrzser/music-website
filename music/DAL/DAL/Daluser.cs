using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Model;

namespace DAL.DAL
{
    public class Daluser
    {
        static SqlConnection conn = Conn.getconn();//获取数据库连接
        
        //更新用户
        public int updateuser(Modeluser user)
        {
            conn.Open();
            string sql = "update tbuser SET user_name='"+user.userName+"',user_pwd='"+user.userPwd+"',user_email='"+user.userEmail+"' where user_id="+user.Id;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp=cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //加入用户
        public int insertuser(Modeluser user)
        {
            conn.Open();
            string sql = "insert into tbuser (user_name,user_pwd,user_email)values('"+user.userName+"','"+user.userPwd+"','"+user.userEmail+"')";
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //删除用户
        public int deleteuser(Modeluser user)
        {
            conn.Open();
            string sql="delete from tbuser where user_id="+user.Id;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //判断用户是否已经注册
        public bool is_signout(string email)
        {
            conn.Open();
            String sql = "select user_email from tbuser";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader reader = cmd.ExecuteReader();
            while(reader.Read())
            {
                if(reader[0].ToString().Equals(email))
                {
                    reader.Close();
                    conn.Close();
                    return true;
                }
            }
            reader.Close();
            conn.Close();
            return false;
        }
        //查询用户
        public DataSet queryUserbyEmail(string email)
        {
            conn.Open();
            string sql = "select * from tbuser where user_email='" + email+"'";
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

        //查询用户id
        public int queryUserIdByEmail(string email)
        {
            conn.Open();
            string sql = "select user_id from tbuser where user_email='" + email + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = (int)cmd.ExecuteScalar();
            conn.Close();
            return temp;
        }

        //更改用户名
        public int updateUserName(int userId,string userName)
        {
            conn.Open();
            string sql = "update tbuser set user_name='"+userName+"' where user_id ="+userId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //根据id查询密码
        public string queryUserPassword(int userId)
        {
            conn.Open();
            string sql = "select user_pwd from tbuser where user_id="+userId;
            SqlCommand cmd = new SqlCommand(sql,conn);
            string pwd = cmd.ExecuteScalar().ToString();
            conn.Close();
            return pwd;
        }

        //更改密码
        public int updateUserPassword(int userId,string userPassword)
        {
            conn.Open();
            string sql = "update tbuser set user_pwd='"+userPassword+"' where user_id ="+userId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //分页查询用户
        public DataSet pageQueryuser(int offset, int rows)
        {
            string sql = "select top "+rows+" o.* from (select ROW_NUMBER() over(order by user_id) as rownumber,* from (select * from tbuser) as oo) as o where rownumber>"+offset;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //封禁用户
        public int setNovalid(int userId,int valid)
        {
            string sql = "update tbuser set user_valid="+valid+" where user_id="+userId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //获得用户数量
        public int getUsernum()
        {
            string sql = "select count(1) from tbuser";
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp = (int)cmd.ExecuteScalar();
            conn.Close();
            return temp;
        }
        //重置密码
        public int resetPwd(int userId)
        {
            string sql = "update tbuser set user_pwd='123456' where user_id="+userId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
    }
}
