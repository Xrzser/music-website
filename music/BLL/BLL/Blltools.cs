using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Model;
using DAL.DAL;
using System.Data;

namespace BLL.BLL
{
    public class Blltools
    {
        static Daltools daltools = new Daltools();

        //关键字搜索歌曲
        public List<Modelmusicinfo> searchMusic(int offset,int rows,string keyword)
        {
            string[] keywords = System.Text.RegularExpressions.Regex.Split(keyword, @"\s{1,}");
            DataSet data = daltools.querymusicByKeyword(offset, rows, keywords);
            List<Modelmusicinfo> list = new List<Modelmusicinfo>();
            int num = data.Tables[0].Rows.Count;
            for (int i = 0; i < num; i++)
            {
                Modelmusicinfo musicinfo = new Modelmusicinfo();
                musicinfo.musicId = (int)data.Tables[0].Rows[i].ItemArray[1];
                musicinfo.musicName = data.Tables[0].Rows[i].ItemArray[2].ToString();
                musicinfo.musicRhythm = (int)data.Tables[0].Rows[i].ItemArray[3];
                musicinfo.musicEmotion = (int)data.Tables[0].Rows[i].ItemArray[4];
                musicinfo.musicType = (int)data.Tables[0].Rows[i].ItemArray[5];
                musicinfo.musicLanguage = (int)data.Tables[0].Rows[i].ItemArray[6];
                musicinfo.musicSinger = data.Tables[0].Rows[i].ItemArray[7].ToString();
                musicinfo.musicPath = data.Tables[0].Rows[i].ItemArray[8].ToString();
                musicinfo.uploadUserId = (int)data.Tables[0].Rows[i].ItemArray[9];
                list.Add(musicinfo);
            }
            return list;
            
        }
        //查询关键字返回结果数目
        public int getresnum(string keyword)
        {
            string[] keywords = System.Text.RegularExpressions.Regex.Split(keyword, @"\s{1,}");
            return daltools.queryresnum(keywords);
        }
        //关键字搜索歌单简要信息
        public List<Modelsongsheets> searchSongsheet(int offset, int rows, string keyword)
        {
            string[] keywords = System.Text.RegularExpressions.Regex.Split(keyword, @"\s{1,}");
            List<Modelsongsheets> list = new List<Modelsongsheets>();
            DataSet data=daltools.querySongsheetByKeyword(offset,rows,keywords);
            int num = data.Tables[0].Rows.Count;
            for (int i = 0; i < num; i++)
            {
                Modelsongsheets songsheet = new Modelsongsheets();
                songsheet.songsheetId = (int)data.Tables[0].Rows[i].ItemArray[1];
                songsheet.createuserId = (int)data.Tables[0].Rows[i].ItemArray[2];
                songsheet.songsheetName = data.Tables[0].Rows[i].ItemArray[3].ToString();
                songsheet.songsheetContent = data.Tables[0].Rows[i].ItemArray[4].ToString();
                list.Add(songsheet);
            }
            return list;
        }

        //搜索到的歌单数量
        public int getSongsheetnum(string keyword)
        {
            string[] keywords = System.Text.RegularExpressions.Regex.Split(keyword, @"\s{1,}");
            return daltools.querysongsheetnum(keywords);
        }
    }
}
