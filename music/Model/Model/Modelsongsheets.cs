using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Model
{
    public class Modelsongsheets
    {
        public int songsheetId { set; get; }
        public int createuserId { set; get; }
        public string songsheetName { set; get; }
        public string songsheetContent { set; get; }
        public string musicidList { set; get; }
        public int ispublic { set; get; }
    }
}
