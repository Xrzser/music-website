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
    public class Dalfavorite
    {
        static SqlConnection conn = Conn.getconn();

        //新建用户时插入空条目
        public int insertFavoriteinfo(int userId)
        {
            string sql = "insert into tbfavorite(user_id,favorite_songsid_list,favorite_songsheetsid_list)values("+userId+",'','')";
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //查询用户收藏的歌单
        public string queryFavoriteSongsheets(int userid)
        {
            string sql = "select favorite_songsheetsid_list from tbfavorite where user_id="+userid;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql,conn);
            object obj= cmd.ExecuteScalar();
            conn.Close();
            if(obj==null){
                return "";
            }
            else{
                string favorite_songsheetsid_list_str = obj.ToString();
                return favorite_songsheetsid_list_str;
            }
        }
       
        //查询用户收藏的曲目
        public string queryFavoriteMusic(int userid)
        {
            string sql = "select favorite_songsid_list from tbfavorite where user_id=" + userid;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql,conn);
            object obj= cmd.ExecuteScalar();
            conn.Close();
            if(obj==null){return "";}
            else
            {
                string favorite_songsid_list_str = obj.ToString();
                return favorite_songsid_list_str;
            }        
        }

        //添加用户收藏的歌曲
        public int addfavMusic(string musicId,int userId)
        {
            string sql = "update tbfavorite set favorite_songsid_list =CONCAT('"+musicId+",',favorite_songsid_list) where user_id="+userId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //删除用户收藏的歌曲
        public int deletefavMusic(string musicId, int userId)
        {
            string sql = "update tbfavorite set favorite_songsid_list =REPLACE(favorite_songsid_list,'" + musicId + ",','')  where user_id="+userId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //添加用户收藏的歌单
        public int addSongsheet(int userId, string songsheetId)
        { 
            conn.Open();
            string sql = "update tbfavorite set favorite_songsheetsid_list =CONCAT('"+songsheetId+",',favorite_songsheetsid_list) where user_id="+userId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

         //删除用户收藏的歌单
        public int deleteFavSongsheet(int userId, string songsheetId)
        {
            conn.Open();
            string sql = "update tbfavorite set favorite_songsheetsid_list=REPLACE(favorite_songsheetsid_list,'"+songsheetId+",','') where user_id="+userId;
            SqlCommand cmd = new SqlCommand(sql,conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
    }
}
