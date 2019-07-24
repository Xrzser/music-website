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
    public class Bllsongsheets
    {
        static Dalsongsheets dalsongsheets = new Dalsongsheets();
        
        //创建歌单
        public int createSongsheet(int userId, string songsheetName, string songsheetContent, int isPublic)
        {
            dalsongsheets.createSongsheet(userId, songsheetName, songsheetContent, isPublic);
            return 1;
        }
        //查询用户已经创建的歌单简要信息
        public List<Modelsongsheets> getSongsheetsByCreateuserid(int userid)
        {
            DataSet set = dalsongsheets.querySongsheetsByCreateuserid(userid);
            List<Modelsongsheets> list=new List<Modelsongsheets>();
            for (int i = 0; i < set.Tables[0].Rows.Count; i++)
            {
                Modelsongsheets songsheet = new Modelsongsheets();
                songsheet.songsheetId=(int)set.Tables[0].Rows[i].ItemArray[0];
                songsheet.songsheetName = set.Tables[0].Rows[i].ItemArray[1].ToString();
                songsheet.songsheetContent = set.Tables[0].Rows[i].ItemArray[2].ToString();
                songsheet.ispublic = (int)set.Tables[0].Rows[i].ItemArray[3];
                list.Add(songsheet);
            }
            return list;
        }

        //根据str查询歌单简要信息
        public List<Modelsongsheets> getSongsheetBystr(string str){
            DataSet set=dalsongsheets.querySongsheetBystr(str);
            if (set == null) { return null; }
            else
            {
                List<Modelsongsheets> list = new List<Modelsongsheets>();
                for (int i = 0; i < set.Tables[0].Rows.Count; i++)
                {
                    Modelsongsheets songsheet = new Modelsongsheets();
                    songsheet.songsheetId = (int)set.Tables[0].Rows[i].ItemArray[0];
                    songsheet.songsheetName = set.Tables[0].Rows[i].ItemArray[1].ToString();
                    songsheet.songsheetContent = set.Tables[0].Rows[i].ItemArray[2].ToString();
                    songsheet.ispublic = (int)set.Tables[0].Rows[i].ItemArray[3];
                    list.Add(songsheet);
                }
                return list;
            }
        }

        //查询歌单中的歌曲id字符串
        public string getmusicidstr(int songsheetid)
        {
            return dalsongsheets.querymusicidlistBySongsheetId(songsheetid);
        }

        //向歌单中添加歌曲
        public int addMusic(string musicId, int songsheetId)
        {
           return dalsongsheets.addMusic(musicId, songsheetId);  
        }

        //在歌单中删除歌曲
        public int deleteMusic(string musicId, int songsheetId)
        {
            return dalsongsheets.deleteMusic(musicId, songsheetId);
        }

        //设置歌单对创建者无效
        public int setNoVaild(int songsheetId)
        {
            return dalsongsheets.setNovalid(songsheetId);
        }
        //删除歌单
        public int deleteSongsheet(int songsheetId)
        {
            return dalsongsheets.deleteSongsheet(songsheetId);
        }
        //歌单播放量+1
        public int addSongsheetvolume(int songsheetId)
        {
            return dalsongsheets.addSongsheetvolume(songsheetId);
        }
    }
}
