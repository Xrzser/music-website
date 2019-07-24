using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using DAL.DAL;
using System.Data;

namespace BLL.Server
{
    public class Updaterecommend
    {

        static Daluserinfo daluserinfo = new Daluserinfo();
        static Dalrecommend dalrecommend = new Dalrecommend();

        static Timer tmr;
        public static void start()
        {
            tmr = new Timer(Tick, "tick...", 200, 60000);//启动后一分钟开始自动执行，时间间隔为一分钟
        }

        //更新音乐推荐
        static void Tick(object data)
        {
            //查询用户偏好信息
            DataSet set=daluserinfo.queryuserliked();
            //得到用户偏好数据
            DataTable table = set.Tables[0];
            dalrecommend.updateRecommendMucsic(table);
        }
    }
}
