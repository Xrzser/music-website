using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using DAL.DAL;

namespace BLL.Server
{
    public class Mytimer
    {
        static Daltime daltime = new Daltime();
        static Timer tmr;
        public static void start()
        {
            tmr = new Timer(Tick, "tick...", 0 ,5000);            
        }
        static void Tick(object data)
        {
            DateTime date = DateTime.Now;
            daltime.insertTimenow(date.ToString());
        }
    }
}
