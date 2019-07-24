using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Model
{
    public class Modeluser
    {
        public int Id { get;set; }
        public string userName { set; get; }
        public string userPwd { set; get; }
        public string userEmail { set; get; }
        public int userValid { set; get; }
    }
}
