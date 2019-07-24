using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DAL.DAL
{
    public class Dalrecommend
    {
        static SqlConnection conn = Conn.getconn();//获取数据库连接

        //新用户注册时添加记录
        public int insertline(int userid)
        {
            string sql = "insert into tbrecommend (user_id,update_time,recommend_musicstr)values("+userid+",'','')";
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int temp = cmd.ExecuteNonQuery(); 
            conn.Close();
            return temp;
        }
        //更新用户推荐
        public void updateRecommendMucsic(DataTable table){
            int rows = table.Rows.Count;
            conn.Open();
            for (int i = 0; i < rows; i++)
            {
                StringBuilder sql = new StringBuilder();
                int userid = (int)table.Rows[i].ItemArray[0];
                string rhythmStr = table.Rows[i].ItemArray[1].ToString();
                string emotionStr = table.Rows[i].ItemArray[2].ToString();
                string typeStr = table.Rows[i].ItemArray[3].ToString();
                string languageStr = table.Rows[i].ItemArray[4].ToString();
                string singerStr = table.Rows[i].ItemArray[5].ToString();
                //转换为数组
                sql.Append("select top 12 music_id from tbmusicinfo where music_rhythm=" + 10);
                if (rhythmStr == "") { }
                else
                {
                    int[] rhythm = Array.ConvertAll(rhythmStr.Substring(0, rhythmStr.Length - 1).Split(','), int.Parse);
                    for (int j = 0; j < rhythm.Length; j++)
                    {
                        sql.Append(" or music_rhythm=" + rhythm[j]);
                    }
                }
                if (emotionStr == "") { }
                else
                {
                    int[] emotion = Array.ConvertAll(emotionStr.Substring(0, emotionStr.Length - 1).Split(','), int.Parse);
                    for (int k = 0; k < emotion.Length; k++)
                    {
                        sql.Append(" or music_emotion=" + emotion[k]);
                    }
                }
                if (typeStr == "") { }
                else
                {
                    int[] type = Array.ConvertAll(typeStr.Substring(0, typeStr.Length - 1).Split(','), int.Parse);
                    for (int l = 0; l < type.Length; l++)
                    {
                        sql.Append(" or music_type=" + type[l]);
                    }
                }
                if (languageStr == "") { }
                else
                {
                    int[] language = Array.ConvertAll(languageStr.Substring(0, languageStr.Length - 1).Split(','), int.Parse);
                    for (int m = 0; m < language.Length; m++)
                    {
                        sql.Append(" or music_language=" + language[m]);
                    }
                }
                if (singerStr == "") { }
                else
                {
                    string[] singer = singerStr.Substring(0, singerStr.Length - 1).Split(',');
                    for (int n = 0; n < singer.Length; n++)
                    {
                        sql.Append(" or music_singer='" + singer[n] + "'");
                    }
                }
                sql.Append(" order by newid()");
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = new SqlCommand(sql.ToString(), conn);
                DataSet dataset = new DataSet();
                da.Fill(dataset);
                //把查询到的结果转化为字符串存储在推荐表中
                int setrows = dataset.Tables[0].Rows.Count;
                StringBuilder sb = new StringBuilder();
                for(int s=0;s<setrows;s++)
                {
                    sb.Append(dataset.Tables[0].Rows[s].ItemArray[0] + ",");
                }
                DateTime time = DateTime.Now;
                string sql1 = "update tbrecommend set update_time='"+time.ToString()+"',recommend_musicstr='"+sb.ToString()+"' where user_id="+userid;
                SqlCommand cmd = new SqlCommand(sql1, conn);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        
        //查询用户推荐的音乐字符串
        public string queryRecommendMusicstr(int userId)
        {
            string sql = "select recommend_musicstr from tbrecommend where user_id =" + userId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            string musicstr = cmd.ExecuteScalar().ToString();
            conn.Close();
            if (musicstr == "") { return ""; }
            else
            {
                return musicstr.Substring(0, musicstr.Length - 1);
            }
        }
        
        //查询用户推荐的更新时间
        public string queryRecommendTime(int userId)
        {
            string sql = "select update_time from tbrecommend where user_id ="+userId;
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            string updatetime = cmd.ExecuteScalar().ToString();
            conn.Close();
            return updatetime;
        }
    }
}
