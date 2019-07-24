using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using DAL.DAL;

namespace BLL.Server
{
    public class UpdateVolume
    {
        static Dalmusicinfo dalmusicinfo = new Dalmusicinfo();
        static Dalsinger dalsinger = new Dalsinger();

        static Timer tmr;
        public static void start()
        {
            tmr = new Timer(Tick, "tick...", 60000, 60000);//启动后一分钟开始自动执行，时间间隔为一分钟
        }

        //更新歌手播放量
        static void Tick(object data)
        {
            dalsinger.updateSingersVolumes(dalmusicinfo.querySingersVolumes());
        }
    }
}
