using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Model;
using System.Data;
using System.Data.SqlClient;


namespace DAL.DAL
{
    public class Daluserinfo
    {
        static SqlConnection conn = Conn.getconn();
        //通过id查询用户详细信息
        public DataSet QueryUsernfoById(int id)
        {
            conn.Open();
            string sql = "select * from tbuserinfo where user_id="+id;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //生成用户详细信息
        public int insertUserInfo(Modeluserinfo userinfo){
            conn.Open();
            string sql = "insert into tbuserinfo(user_id,user_sex,user_location,user_signature,user_rhythm,user_emotion,user_type,user_language,user_singer)values("+userinfo.userId+","+userinfo.userSex+",'"+userinfo.userLocation+"','"+userinfo.userSignature+"','"+userinfo.userRhythm+"','"+userinfo.userEmotion+"','"+userinfo.userType+"','"+userinfo.userLanguage+"','"+userinfo.userSinger+"')";
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp=cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //修改用户详细信息
        public int updateUserInfo(Modeluserinfo userinfo)
        {
            conn.Open();
            string sql = "update tbuserinfo SET user_sex="+userinfo.userSex+",user_location='"+userinfo.userLocation+"',user_signature='"+userinfo.userSignature+"',user_rhythm='"+userinfo.userRhythm+"',user_emotion='"+userinfo.userEmotion+"',user_type='"+userinfo.userType+"',user_language='"+userinfo.userLanguage+"',user_singer='"+userinfo.userSinger+"' where user_id="+userinfo.userId;
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //查询用户的偏好信息
        public DataSet queryuserliked()
        {
            conn.Open();
            string sql = "select user_id,user_rhythm,user_emotion,user_type,user_language,user_singer from tbuserinfo";
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

    }
}
