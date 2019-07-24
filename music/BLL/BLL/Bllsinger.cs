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
    public class Bllsinger
    {
        static Dalsinger dalsinger = new Dalsinger();

        //查询歌手数量
        public int querySingerNum()
        {
            return dalsinger.querySingerNum();
        }
        //分页查询歌手列表
        public List<Modelsinger> pageQuerySingerList(int offset,int rows)
        {
            DataSet data = dalsinger.pageQuerySingerList(offset,rows);
            List<Modelsinger> singerlist = new List<Modelsinger>();
            int num = data.Tables[0].Rows.Count;
            for(int i=0;i<num;i++){
                Modelsinger singer = new Modelsinger();
                singer.singerId = (int)data.Tables[0].Rows[i].ItemArray[1];
                singer.singerName = data.Tables[0].Rows[i].ItemArray[2].ToString();
                singer.singerSex = (int)data.Tables[0].Rows[i].ItemArray[3];
                singer.singerImage = data.Tables[0].Rows[i].ItemArray[4].ToString();
                singer.singerContent = data.Tables[0].Rows[i].ItemArray[5].ToString();
                singer.singerVolume = (int)data.Tables[0].Rows[i].ItemArray[6];
                singerlist.Add(singer);
            }
            return singerlist;
        }
        //分页查询歌手热度排行
        public List<Modelsinger> pageQuerySingerListByhot(int offset, int rows)
        {
            DataSet data = dalsinger.pageQuerySingerListByhot(offset, rows);
            List<Modelsinger> singerlist = new List<Modelsinger>();
            int num = data.Tables[0].Rows.Count;
            for (int i = 0; i < num; i++)
            {
                Modelsinger singer = new Modelsinger();
                singer.singerHot = (long)data.Tables[0].Rows[i].ItemArray[0];
                singer.singerId = (int)data.Tables[0].Rows[i].ItemArray[1];
                singer.singerName = data.Tables[0].Rows[i].ItemArray[2].ToString();
                singer.singerSex = (int)data.Tables[0].Rows[i].ItemArray[3];
                singer.singerImage = data.Tables[0].Rows[i].ItemArray[4].ToString();
                singer.singerContent = data.Tables[0].Rows[i].ItemArray[5].ToString();
                singer.singerVolume = (int)data.Tables[0].Rows[i].ItemArray[6];
                singerlist.Add(singer);
            }
            return singerlist;
        }

        //通过singerName查询singerItem
        public  Modelsinger querySingerItemByName(String singerName)
        {
            Modelsinger singeritem = new Modelsinger();
            DataSet data = dalsinger.querySingerItemByName(singerName);
            if (data.Tables[0].Rows.Count == 0)
            {
                return null;
            }
            else
            {
                singeritem.singerId = (int)data.Tables[0].Rows[0].ItemArray[0];
                singeritem.singerName = data.Tables[0].Rows[0].ItemArray[1].ToString();
                singeritem.singerSex = (int)data.Tables[0].Rows[0].ItemArray[2];
                singeritem.singerImage = data.Tables[0].Rows[0].ItemArray[3].ToString();
                singeritem.singerContent = data.Tables[0].Rows[0].ItemArray[4].ToString();
                singeritem.singerVolume = (int)data.Tables[0].Rows[0].ItemArray[5];
                return singeritem;
            }
        }
        //编辑歌手
        public int editSinger(int singerId, string singerName, int singerSex, string singerContent)
        {
            return dalsinger.editSinger(singerId,singerName,singerSex,singerContent);
        }
        //删除歌手
        public int delSinger(int singerId)
        {
            return dalsinger.delSinger(singerId);
        }
        //添加歌手
        public int addSinger(string singerName, int singerSex, string singerContent,string singerImage)
        {
            return dalsinger.addSinger(singerName, singerSex, singerContent, singerImage);
        }
    }
}
