using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL.DAL;
using Model.Model;

namespace BLL.BLL
{
    public class Bllfavorite
    {
        static Dalfavorite dalfavorite = new Dalfavorite();


        //新建用户时插入空条目
        public int insertFavoriteinfo(int userId)
        {
            return dalfavorite.insertFavoriteinfo(userId);
        }

        //查询用户收藏的歌单
        public string getFavoriteSongsheets(int userid)
        {
            string liststr = dalfavorite.queryFavoriteSongsheets(userid);
            if (liststr == "") { return ""; }
            else{
                liststr = liststr.Substring(0, liststr.Length - 1);
                return liststr;
            }
        }

        //查询用户收藏的曲目
        public string getFavoriteMusic(int userid)
        {
            string liststr = dalfavorite.queryFavoriteMusic(userid);
            if (liststr == "") { return ""; }
            else
            {
                liststr = liststr.Substring(0, liststr.Length - 1);
                return liststr;
            }
        }

        //添加用户收藏歌曲
        public int addfavMusic(string musicId, int userId)
        {
            return dalfavorite.addfavMusic(musicId,userId);
        }

        //删除用户收藏歌曲
        public int deletefavMusic(string musicId, int userId)
        {
            return dalfavorite.deletefavMusic(musicId, userId);
        }

        //添加用户收藏的歌单
        public int favSongsheet(string songsheetId,int userId)
        {
            return dalfavorite.addSongsheet(userId,songsheetId);
        }
        //删除用户收藏的歌单
        public int deleteFavSongsheet(int userId, string songsheetId)
        {
            return dalfavorite.deleteFavSongsheet(userId, songsheetId);
        }
    }
}
