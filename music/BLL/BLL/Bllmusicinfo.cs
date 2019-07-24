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
    public class Bllmusicinfo
    {
        static Dalmusicinfo dalmusicinfo = new Dalmusicinfo();

        //上传音乐添加音乐信息
        public int uploadmusic(Modelmusicinfo musicinfo){
            return dalmusicinfo.insertMusicinfo(musicinfo);
        }

        //查询音乐条目数量
        public int getmusicnum(string singerName)
        {
            return dalmusicinfo.queryMusicnum(singerName);
        }

        //分页查询音乐信息 singerName=""表示查询乐库中所有歌曲，singerName="XXX"表示查询某XXX歌手的歌
        public  List<Modelmusicinfo> pagequerymusic(int offset,int rows,string singerName)
        {
            List<Modelmusicinfo> list = new List<Modelmusicinfo>();
            DataSet data;
            if(singerName=="")
            {
                 data= dalmusicinfo.pageQuery(offset, rows);
            }
            else
            {
                data = dalmusicinfo.pageQueryBySinger(offset,rows,singerName);
            }
            int nums = data.Tables[0].Rows.Count;
            for (int i = 0; i <nums; i++)
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
                musicinfo.musicVolume = (int)data.Tables[0].Rows[i].ItemArray[10];
                list.Add(musicinfo);
            }
            return list;
        }

        //分页查询音乐信息排行
        public List<Modelmusicinfo> pagequerymusicByhot(int offset, int rows)
        {
            List<Modelmusicinfo> list = new List<Modelmusicinfo>();
            DataSet data = dalmusicinfo.pageQueryByhot(offset, rows);
            int nums = data.Tables[0].Rows.Count;
            for (int i = 0; i < nums; i++)
            {
                Modelmusicinfo musicinfo = new Modelmusicinfo();
                musicinfo.musicHot = (long)data.Tables[0].Rows[i].ItemArray[0];
                musicinfo.musicId = (int)data.Tables[0].Rows[i].ItemArray[1];
                musicinfo.musicName = data.Tables[0].Rows[i].ItemArray[2].ToString();
                musicinfo.musicRhythm = (int)data.Tables[0].Rows[i].ItemArray[3];
                musicinfo.musicEmotion = (int)data.Tables[0].Rows[i].ItemArray[4];
                musicinfo.musicType = (int)data.Tables[0].Rows[i].ItemArray[5];
                musicinfo.musicLanguage = (int)data.Tables[0].Rows[i].ItemArray[6];
                musicinfo.musicSinger = data.Tables[0].Rows[i].ItemArray[7].ToString();
                musicinfo.musicPath = data.Tables[0].Rows[i].ItemArray[8].ToString();
                musicinfo.uploadUserId = (int)data.Tables[0].Rows[i].ItemArray[9];
                musicinfo.musicVolume = (int)data.Tables[0].Rows[i].ItemArray[10];
                list.Add(musicinfo);
            }
            return list;
        }
        //查询音乐item
        public Modelmusicinfo querymusicitem(int id)
        {
            Modelmusicinfo musicinfo = new Modelmusicinfo();
            DataSet data=dalmusicinfo.queryMusicItem(id);
            musicinfo.musicName = data.Tables[0].Rows[0].ItemArray[0].ToString();
            musicinfo.musicSinger = data.Tables[0].Rows[0].ItemArray[1].ToString();
            musicinfo.musicPath = data.Tables[0].Rows[0].ItemArray[2].ToString();
            musicinfo.musicId = id;
            return musicinfo;
        }
        //查询歌单中的歌曲
        public List<Modelmusicinfo> queryMusicListBysongsheetId(string listidstr)
        {
            if (listidstr == null) { return null; }
            DataSet data= dalmusicinfo.queryMusicList(listidstr);
            if (data == null) { return null; }
            else
            {
                List<Modelmusicinfo> list = new List<Modelmusicinfo>();
                int rows = data.Tables[0].Rows.Count;
                for (int i = 0; i < rows; i++)
                {
                    Modelmusicinfo musicinfo = new Modelmusicinfo();
                    musicinfo.musicId = (int)data.Tables[0].Rows[i].ItemArray[0];
                    musicinfo.musicName = data.Tables[0].Rows[i].ItemArray[1].ToString();
                    musicinfo.musicSinger = data.Tables[0].Rows[i].ItemArray[6].ToString();
                    musicinfo.musicPath = data.Tables[0].Rows[i].ItemArray[7].ToString();
                    musicinfo.uploadUserId = (int)data.Tables[0].Rows[i].ItemArray[8];
                    list.Add(musicinfo);
                }
                return list;
            }
        }

        //随机查询歌曲12首
        public List<Modelmusicinfo> getMusicbyNewid()
        {
            DataSet data = dalmusicinfo.queryMusicbyNewid();
            List<Modelmusicinfo> list = new List<Modelmusicinfo>();
            int rows = data.Tables[0].Rows.Count;
            for (int i = 0; i < rows; i++)
            {
                    Modelmusicinfo musicinfo = new Modelmusicinfo();
                    musicinfo.musicId = (int)data.Tables[0].Rows[i].ItemArray[0];
                    musicinfo.musicName = data.Tables[0].Rows[i].ItemArray[1].ToString();
                    musicinfo.musicSinger = data.Tables[0].Rows[i].ItemArray[6].ToString();
                    musicinfo.musicPath = data.Tables[0].Rows[i].ItemArray[7].ToString();
                    musicinfo.uploadUserId = (int)data.Tables[0].Rows[i].ItemArray[8];
                    list.Add(musicinfo);
            }
            return list;
        }

        //歌曲播放量+1
        public int addMusicvolume(int userId)
        {
            return dalmusicinfo.addMusicvolume(userId);
        }

        //编辑歌曲
        public int editMusic(string musicName, string musicSinger, int musicId)
        {
            return dalmusicinfo.editMusic(musicName, musicSinger, musicId);
        }
        //删除歌曲
        public int delMusic(int musicId)
        {
            return dalmusicinfo.delMusic(musicId);
        }

    }
}
