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
    public class Daltools
    {
        static SqlConnection conn = Conn.getconn();

        //根据歌名或者歌手名搜索歌曲
        public DataSet querymusicByKeyword(int offset,int rows,string[] keyword)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append("select top "+rows+" o.* from (select ROW_NUMBER() over(order by music_id) as rownumber,* from (select * from tbmusicinfo where music_name LIKE '%"+keyword[0]+"%' or music_singer Like '%"+keyword[0]+"%'");
            for (int i = 1; i < keyword.Length; i++)
            {
                sql.Append("or  music_name LIKE '%" + keyword[i] + "%' or music_singer LIKE '%" + keyword[i] + "%'");
            }
            sql.Append(") as oo) as o where rownumber>"+offset);
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql.ToString(), conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //根据关键字查询搜索结果的条目
        public int queryresnum(string[] keyword)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append("select COUNT(1) from tbmusicinfo where music_name LIKE '%"+keyword[0]+"%' or music_singer Like '%"+keyword[0]+"%'");
            for (int i = 1; i < keyword.Length; i++)
            {
                sql.Append("or  music_name LIKE '%" + keyword[i] + "%' or music_singer LIKE '%" + keyword[i] + "%'");
            }
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql.ToString(), conn);
            int temp = (int)cmd.ExecuteScalar();
            conn.Close();
            return temp;
        }
        //根据歌单名搜索歌单
        public DataSet querySongsheetByKeyword(int offset, int rows, string[] keyword)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append("select top " + rows + " o.* from (select ROW_NUMBER() over(order by songsheet_id) as rownumber,* from (select songsheet_id,createuser_id,songsheet_name,songsheet_content,ispublic from tbsongsheets where songsheet_name like '%" + keyword[0] + "%'");
            for (int i = 1; i < keyword.Length; i++)
            {
                sql.Append("or songsheet_name like '%" + keyword[i] + "%'");
            }
            sql.Append(") as oo) as o where (rownumber>"+offset+" and ispublic=1)");
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(sql.ToString(), conn);
            DataSet dataset = new DataSet();
            da.Fill(dataset);
            conn.Close();
            return dataset;
        }
        //根据歌单名模糊搜索得到的歌单结果数量
        public int querysongsheetnum(string[] keyword)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append("select COUNT(1) from tbsongsheets where songsheet_name like '%"+keyword[0]+"%' ");
            for (int i = 1; i < keyword.Length; i++)
            {
                sql.Append("or songsheet_name like '%"+keyword[i]+"%'");
            }
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql.ToString(), conn);
            int temp = (int)cmd.ExecuteScalar();
            conn.Close();
            return temp;
        }
    }
}
