using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.DAL;
using Model.Model;
using System.Data;

namespace BLL.BLL
{
    public class Bllrecommend
    {
        static Dalrecommend dalrecommend = new Dalrecommend();
        static Dalmusicinfo dalmusicinfo = new Dalmusicinfo();
        static Bllmusicinfo bllmusicinfo = new Bllmusicinfo();
        
        //得到推荐给用户的音乐
        public List<Modelmusicinfo> getRecommendMusic(int userId)
        {
            string musicstr = dalrecommend.queryRecommendMusicstr(userId);
            if (musicstr == "") { return bllmusicinfo.getMusicbyNewid(); }
            else
            {
                DataSet set = dalmusicinfo.queryMusicList(musicstr);
                int nums = set.Tables[0].Rows.Count;
                List<Modelmusicinfo> list = new List<Modelmusicinfo>();
                for (int i = 0; i < nums; i++)
                {
                    Modelmusicinfo musicinfo = new Modelmusicinfo();
                    musicinfo.musicId = (int)set.Tables[0].Rows[i].ItemArray[0];
                    musicinfo.musicName = set.Tables[0].Rows[i].ItemArray[1].ToString();
                    musicinfo.musicSinger = set.Tables[0].Rows[i].ItemArray[6].ToString();
                    musicinfo.musicPath = set.Tables[0].Rows[i].ItemArray[7].ToString();
                    musicinfo.uploadUserId = (int)set.Tables[0].Rows[i].ItemArray[8];
                    list.Add(musicinfo);
                }
                return list;
            }
        }
        //得到推荐更新时间
        public string getRecommendTime(int userId)
        {
            return dalrecommend.queryRecommendTime(userId);
        }
        //新用户注册时添加记录
        public int insertline(int userid)
        {
            return dalrecommend.insertline(userid);
        }
    }
}
