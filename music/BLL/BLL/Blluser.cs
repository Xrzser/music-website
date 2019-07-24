using DAL.DAL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Model;
using System.Data;

namespace BLL.BLL
{
    public class Blluser
    {
        static Daluser daluser = new Daluser();
        static Bllfavorite bllfavorite = new Bllfavorite();
        static Blluserinfo blluserinfo = new Blluserinfo();
        static Bllrecommend bllrecommend = new Bllrecommend();

        //用户注册
        public bool signup(Modeluser user)
        {
            //判断该用户是否已经注册
            if (daluser.is_signout(user.userEmail))
            {
                return false; 
            }
            else
            {
                daluser.insertuser(user);
                //查询用户注册后的id
                int userid = daluser.queryUserIdByEmail(user.userEmail);

                //根据id插入userinfo,favoriteinfo和recommend
                bllfavorite.insertFavoriteinfo(userid);
                Modeluserinfo userinfo = new Modeluserinfo();
                userinfo.userId = userid;
                blluserinfo.insertUserInfo(userinfo);
                bllrecommend.insertline(userid);
                return true;
            }  
        }

        //用户登录
        public Modeluser signin(string email,string password)
        {
            Modeluser user = new Modeluser();
            DataSet data= daluser.queryUserbyEmail(email);
            if(data.Tables[0].Rows.Count==0)
            {
                Modeluser empty=new Modeluser();
                empty.Id=0;
                return empty;
            }
            if (0 == (int)data.Tables[0].Rows[0].ItemArray[4])
            {
                Modeluser empty = new Modeluser();
                empty.Id = -1;
                return empty;
            }
            user.Id= (int)data.Tables[0].Rows[0].ItemArray[0];
            user.userName=data.Tables[0].Rows[0].ItemArray[1].ToString();
            user.userPwd = data.Tables[0].Rows[0].ItemArray[2].ToString();
            user.userEmail = data.Tables[0].Rows[0].ItemArray[3].ToString();
            if (user.userPwd.Equals(password))
            {
                //密码验证成功，返回user对象
                return user;
            }
            else
            {
                return null;
            }
        }

        //查询用户id
        public int queryUserIdByEmail(string email)
        {
            return daluser.queryUserIdByEmail(email);
        }

        //修改密码
        public int  updateUserPassword(int userId,string oldPwd,string newPwd)
        {
            if (oldPwd.Equals(daluser.queryUserPassword(userId)))
            {
                daluser.updateUserPassword(userId, newPwd);
                return 1;
            }
            else
            {
                return 0;
            }
        }
        //修改用户名
        public int updateUserName(int userId, string userName)
        {
            return daluser.updateUserName(userId, userName);
        }

        //分页查询用户
        public List<Modeluser> pageQueryuser(int offset, int rows)
        {
            List<Modeluser> list = new List<Modeluser>();            
            DataSet set=daluser.pageQueryuser(offset, rows);
            int num=set.Tables[0].Rows.Count;
            for (int i = 0; i < num; i++)
            {
                Modeluser user = new Modeluser();
                user.Id = (int)set.Tables[0].Rows[i].ItemArray[1];
                user.userName = set.Tables[0].Rows[i].ItemArray[2].ToString();
                user.userEmail=set.Tables[0].Rows[i].ItemArray[4].ToString();
                user.userValid = (int)set.Tables[0].Rows[i].ItemArray[5];
                list.Add(user);
            }
            return list;
        }
        //封禁用户
        public int setNovalid(int userId,int valid)
        {
            return daluser.setNovalid(userId,valid);
        }
        //获得用户数量
        public int getUsernum()
        {
            return daluser.getUsernum();
        }
        //重置密码
        public int resetPwd(int userId)
        {
            return daluser.resetPwd(userId);
        }
    }
}
