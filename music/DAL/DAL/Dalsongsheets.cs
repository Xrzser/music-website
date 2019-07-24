using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Model;
using System.Data;


namespace DAL.DAL
{
    public class Dalsongsheets
    {
        static SqlConnection conn = Conn.getconn();//获取数据库连接

        //创建歌单
        public int createSongsheet(int userId,string songsheetName,string songsheetContent,int isPublic)
        {
            conn.Open();
            string sql = "insert into tbsongsheets (createuser_id,songsheet_name,songsheet_content,musicid_list,ispublic) values ("+userId+",'"+songsheetName+"','"+songsheetContent+"','',"+isPublic+");";
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //删除歌单
        public int deleteSongsheet(int songsheetId)
        {
            conn.Open();
            string sql = "delete from tbsongsheets where songsheet_id=" + songsheetId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //设置歌单对创建者无效
        public int setNovalid(int songsheetId)
        {
            conn.Open();
            string sql = "update tbsongsheets set isvalid=0 where songsheet_id="+songsheetId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //向歌单中添加歌曲
        public int addMusic(string musicId,int songsheetId)
        {
            conn.Open();
            string sql = "update tbsongsheets set musicid_list =CONCAT('"+musicId+",',musicid_list) where songsheet_id="+songsheetId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //在歌单中删除歌曲
        public int deleteMusic(string musicId,int songsheetId)
        {
            conn.Open();
            string sql = "update tbsongsheets set musicid_list =REPLACE(musicid_list,'"+musicId+",','')  where songsheet_id="+songsheetId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //根据创建者id查询该用户创建的歌单简要信息
        public DataSet querySongsheetsByCreateuserid(int createuserid)
        {
            conn.Open();
            string sql = "select songsheet_id,songsheet_name,songsheet_content,ispublic from tbsongsheets where createuser_id="+createuserid+" and isvalid=1";
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

        //根据歌单id查询歌曲id字符串
        public string querymusicidlistBySongsheetId(int songsheetid)
        {
            conn.Open();
            string sql = "select musicid_list from tbsongsheets where songsheet_id="+songsheetid;
            SqlCommand cmd = new SqlCommand(sql, conn);
            string musiclist = cmd.ExecuteScalar().ToString();
            conn.Close();
            if (musiclist == "")
            {
                return null;
            }
            else
            {
                musiclist = musiclist.Substring(0, musiclist.Length - 1);
                return musiclist;
            }
        }

        //根据str查询歌单简要信息
        public DataSet querySongsheetBystr(string str){
            if (str == "") { return null; }
            else
            {
                conn.Open();
                string sql = "select songsheet_id,songsheet_name,songsheet_content,ispublic from tbsongsheets where songsheet_id in(" + str + ")";
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = new SqlCommand(sql, conn);
                DataSet dataset = new DataSet();
                da.Fill(dataset);
                conn.Close();
                return dataset;
            }
        }
        
        //歌单播放量+1
        public int addSongsheetvolume(int songsheetId)
        {
            conn.Open();
            string sql = "update tbsongsheets set songsheet_volume=songsheet_volume+1 where songsheet_id="+songsheetId;
            SqlCommand cmd=new SqlCommand(sql,conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
    }
}
