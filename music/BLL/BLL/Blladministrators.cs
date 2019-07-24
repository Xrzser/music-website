using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Model;
using System.Data;
using DAL.DAL;

namespace BLL.BLL
{
    public class Blladministrators
    {
        static Daladministrators daladministrators = new Daladministrators();

        //管理员登陆
        public Modeladministrators admlogin(string userName,string userPwd){
            Modeladministrators adm = new Modeladministrators();
            DataSet set = daladministrators.getAdm(userName);
            if (set.Tables[0].Rows.Count == 0) { adm = null; }
            else if(userPwd.Equals(set.Tables[0].Rows[0].ItemArray[2].ToString()))
            {
                adm.administratorsId = (int)set.Tables[0].Rows[0].ItemArray[0];
                adm.administratorsName = userName;
                adm.administratorsLimit = set.Tables[0].Rows[0].ItemArray[3].ToString();
            }
            else
            {
                adm = null;
            }
            return adm;
        }

        //得到管理员列表（除超管）
        public List<Modeladministrators> getAlladmsinfo()
        {
            List<Modeladministrators> list=new List<Modeladministrators>();
            DataSet set = daladministrators.getAlladmsinfo();
            int nums = set.Tables[0].Rows.Count;
            for (int i = 0; i < nums; i++)
            {
                Modeladministrators adm = new Modeladministrators();
                adm.administratorsId = (int)set.Tables[0].Rows[i].ItemArray[0];
                adm.administratorsName = set.Tables[0].Rows[i].ItemArray[1].ToString();
                adm.administratorsLimit = set.Tables[0].Rows[i].ItemArray[2].ToString();
                list.Add(adm);
            }
            return list;
        }
        //添加管理员
        public int addAdm(string Name)
        {
            return daladministrators.insertAdm(Name);
        }
        //删除管理员
        public int deleteAdm(int id)
        {
            return daladministrators.deleteAdm(id);
        }
        //重置管理员密码
        public int resetAdmpwd(int id)
        {
            return daladministrators.resetAdmpwd(id);
        }
        //编辑管理员
        public int updateAdm(Modeladministrators adm)
        {
            return daladministrators.updateAdm(adm);
        }
        //更改密码
        public int newPwd(string op,string np,int id){
            if(daladministrators.getPwd(id).Equals(op)){
                daladministrators.setPwd(np,id);
                return 0;
            }
            else{
                return 1;
            }
        }
    }
}
