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
    public class Dalmusicinfo
    {
        static SqlConnection conn = Conn.getconn();

        //保存音乐信息
        public int insertMusicinfo(Modelmusicinfo musicinfo)
        {
            string sql = "insert into tbmusicinfo (music_name,music_rhythm,music_emotion,music_type,music_language,music_singer,music_path,upload_user_id)values('" + musicinfo.musicName + "'," + musicinfo.musicRhythm + "," + musicinfo.musicEmotion + "," + musicinfo.musicType + "," + musicinfo.musicLanguage + ",'" + musicinfo.musicSinger + "','" + musicinfo.musicPath + "',"+musicinfo.uploadUserId+")";
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //查询歌曲数目 参数singerName=""时查找所有，singerName="XXX"时查找XXX歌手的歌曲数量
        public int queryMusicnum(string singerName)
        {
            string sql1 = "select COUNT(1) from tbmusicinfo";
            string sql2 = "select COUNT(1) from tbmusicinfo where music_singer='"+singerName+"'";
            conn.Open();
            SqlCommand cmd;
            if (singerName == "")
            {
                cmd = new SqlCommand(sql1, conn);
            }
            else
            {
                cmd = new SqlCommand(sql2, conn);
            }
            int num = (int)cmd.ExecuteScalar();
            conn.Close();
            return num;
        }

        //从音乐信息中分页查询所有歌曲
        public DataSet pageQuery(int offset, int rows)
        {
            //todo
            string sql = "select top "+rows+" o.* from (select ROW_NUMBER() over(order by music_id) as rownumber,* from (select * from tbmusicinfo) as oo) as o where rownumber>"+offset;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //从音乐信息中分页查询所有歌曲(播放量为排行)
        public DataSet pageQueryByhot(int offset, int rows)
        {
            //todo
            string sql = "select top " + rows + " o.* from (select ROW_NUMBER() over(order by music_volume desc) as rownumber,* from (select * from tbmusicinfo) as oo) as o where rownumber>" + offset;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

        //分页查询某歌手的歌曲
        public DataSet pageQueryBySinger(int offset, int rows,string singerName)
        {
            //todo
            string sql = "select top " + rows + " o.* from (select ROW_NUMBER() over (order by music_id)as rownumber,* from (select * from tbmusicinfo where music_singer='" + singerName + "')as oo)as o where rownumber>"+offset;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

        //随机查询12首歌曲
        public DataSet queryMusicbyNewid()
        {
            string sql = "select top 12 * from tbmusicinfo order by NEWID()";
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

        //查询音乐item
        public DataSet queryMusicItem(int id)
        {
            string sql = "select music_name,music_singer,music_path from tbmusicinfo where music_id="+id;
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //根据歌曲id字符串查询某歌单歌曲
        public DataSet queryMusicList(string musicidstr)
        {
            if (musicidstr == "") { return null; }
            else
            {
                conn.Open();
                string sql = "select * from tbmusicinfo where music_id in(" + musicidstr + ")";
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = new SqlCommand(sql, conn);
                DataSet dataset = new DataSet();
                da.Fill(dataset);
                conn.Close();
                return dataset;
            }
        }
        //增加歌曲播放量
        public int addMusicvolume(int musicId)
        {
            string sql = "update tbmusicinfo set music_volume=music_volume+1 where music_id="+musicId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp=cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }

        //查询歌手以及其播放量
        public DataSet querySingersVolumes()
        {
            string sql = "select music_singer as singer_name,SUM(music_volume) as singer_volume from tbmusicinfo group by music_singer";
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //编辑歌曲
        public int editMusic(string musicName,string musicSinger,int musicId)
        {
            string sql = "update tbmusicinfo set music_name='"+musicName+"',music_singer='"+musicSinger+"' where music_id="+musicId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //删除歌曲
        public int delMusic(int musicId)
        { 
            string sql = "delete from tbmusicinfo where music_id=" + musicId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
    }
}
