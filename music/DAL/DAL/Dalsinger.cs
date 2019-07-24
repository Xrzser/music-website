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
    public class Dalsinger
    {
        static SqlConnection conn = Conn.getconn();//获取数据库连接

        //查询歌数量
        public int querySingerNum()
        {
            conn.Open();
            string sql = "select count(1) from tbsinger ";
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = (int)cmd.ExecuteScalar();
            conn.Close();
            return temp;
        }

        //分页查询歌手列表
        public DataSet pageQuerySingerList(int offset,int rows)
        {
            conn.Open();
            string sql = "select top " + rows + " o.* from (select ROW_NUMBER() over(order by singer_id) as rownumber,* from (select * from tbsinger)as oo) as o where rownumber>" + offset;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //分页查询歌手热度排行
        public DataSet pageQuerySingerListByhot(int offset, int rows)
        { 
            conn.Open();
            string sql = "select top " + rows + " o.* from (select ROW_NUMBER() over(order by singer_volume desc) as rownumber,* from (select * from tbsinger)as oo) as o where rownumber>" + offset;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }

        //通过singerName查询歌手item
        public DataSet querySingerItemByName(string singerName)
        {
            string sql = "select * from tbsinger where singer_name='"+singerName+"'";
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql, conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //更新歌手的播放量
        public int updateSingersVolumes(DataSet set)
        {
            conn.Open();
            int num=set.Tables[0].Rows.Count;
            for (int i = 0; i < num; i++)
            {
                string sql = "update tbsinger set singer_volume=" + (int)set.Tables[0].Rows[i].ItemArray[1] + " where singer_name='" + set.Tables[0].Rows[i].ItemArray[0].ToString() + "'";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
            return 0;
        }
        //编辑歌手
        public int editSinger(int singerId,string singerName,int singerSex,string singerContent)
        {
            conn.Open();
            string sql = "update tbsinger set singer_name='" + singerName + "',singer_sex=" + singerSex + ",singer_content='" + singerContent + "' where singer_id="+singerId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //删除歌手
        public int delSinger(int singerId)
        {
            conn.Open();
            string sql = "delete from tbsinger where singer_id=" + singerId;
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
        //添加歌手
        public int addSinger(string singerName,int singerSex,string singerContent,string singerImage)
        {
            conn.Open();
            string sql = "insert into tbsinger(singer_name,singer_sex,singer_content,singer_image)values('"+singerName+"',"+singerSex+",'"+singerContent+"','"+singerImage+"')";
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery();
            conn.Close();
            return temp;
        }
    }
}