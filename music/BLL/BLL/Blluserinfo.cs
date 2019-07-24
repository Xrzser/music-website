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
    public class Blluserinfo
    {
        static Daluserinfo daluserinfo = new Daluserinfo();
        //加载用户详细信息
        public Modeluserinfo loaduserinfo(int id)
        {
            Modeluserinfo userinfo = new Modeluserinfo();
            //todo
            DataSet data = daluserinfo.QueryUsernfoById(id);
            userinfo.userId = id;
            userinfo.userSex = (int)data.Tables[0].Rows[0].ItemArray[1];
            userinfo.userLocation = data.Tables[0].Rows[0].ItemArray[2].ToString();
            userinfo.userSignature = data.Tables[0].Rows[0].ItemArray[3].ToString();
            userinfo.userRhythm = data.Tables[0].Rows[0].ItemArray[4].ToString();
            userinfo.userEmotion = data.Tables[0].Rows[0].ItemArray[5].ToString();
            userinfo.userType = data.Tables[0].Rows[0].ItemArray[6].ToString();
            userinfo.userLanguage = data.Tables[0].Rows[0].ItemArray[7].ToString();
            userinfo.userSinger = data.Tables[0].Rows[0].ItemArray[8].ToString();
            return userinfo;
        }

        //插入用户详细信息
        public int insertUserInfo(Modeluserinfo userinfo)
        {
            return daluserinfo.insertUserInfo(userinfo);
        }

        //修改用户详细信息
        public int updateUserInfo(Modeluserinfo userinfo)
        {
            return daluserinfo.updateUserInfo(userinfo);
        }
    }
}
