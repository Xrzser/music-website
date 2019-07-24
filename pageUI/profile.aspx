<%@ Page Language="C#" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>For Music|个人主页</title>
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" /> 
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script>
      function updateinfo() {
          window.location.href = "updateuserinfo.aspx";
      }
      function updatepwd() {
          window.location.href = "updateuserpwd.aspx";
      }
  </script>
</head>
<body>
    <script>
        function GetMsg() {
            var msg;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'profile.aspx/GetMsgByWeb',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    console.log(data.d);
                    msg = data.d;
                }
            });
            return msg;
          
        }
    </script>
    <form id="form1" runat="server">
    <div class="bg-light dk">
        <section id="content">
          <section class="vbox">
            <section class="scrollable">
              <section class="hbox stretch">
                <!--左边部分-->
                <aside class="aside-lg bg-light lter b-r">
                  <section class="vbox">
                    <section class="scrollable">
                      <div class="wrapper" style="height:auto">
                        <!--个人头像等基本信息-->
                        <div class="text-center m-b m-t">
                          <a href="#" class="thumb-lg">
                            <img src="images/portrait/p<%=Session["userid"] %>.jpg" class="img-circle"/>
                          </a>
                          <div>
                            <div class="h3 m-t-xs m-b-xs"><%=Session["username"]%> </div>
                            <small class="text-muted" id="location"><i class="fa fa-map-marker"></i> </small>
                          </div>  
                          <div>
                            <small class="text-muted" id="sex"> </small>
                          </div>            
                        </div>
                        <!--个性签名-->
                        <div class="panel wrapper" style="text-align:center" id="signature">
                          If we can only encounter each other rather than stay with each other ，then I wish we had never encountered. 
                        </div>
                        <!--偏好-->
                          <div class="panel wrapper" style="text-align: center" id="rhythm"></div>
                          <div class="panel wrapper" style="text-align:center" id="emotion"></div>
                          <div class="panel wrapper" style="text-align:center" id="type"></div>
                          <div class="panel wrapper" style="text-align:center" id="singer"></div>
                        <script>
                            var obj = GetMsg();
                            document.getElementById("location").innerHTML = obj.userLocation;
                            if (obj.userSex == 1) { document.getElementById("sex").innerHTML = "男" } else { document.getElementById("sex").innerHTML = "女" }
                            if (obj.userSignature == "") { document.getElementById("signature").innerHTML = "个性签名：" +"暂未设置"; }
                            else { document.getElementById("signature").innerHTML = "个性签名：" + obj.userSignature; }
                           

                            var str = "喜欢的音乐节奏：";
                            var rhythm = obj.userRhythm.split(',');
                            for (i = 0; i < rhythm.length-1; i++)
                            {
                                if (rhythm[i] == 0) {
                                    str = str + "/快节奏";
                                }
                                else
                                {
                                    str = str + "/慢节奏";
                                }
                            }
                            if (str == "喜欢的音乐节奏：") { document.getElementById("rhythm").innerHTML = str + "暂未选择" }
                            else { document.getElementById("rhythm").innerHTML = str; }

                            var str = "喜欢的音乐情感：";
                            var emotion = obj.userEmotion.split(',');
                            for (i = 0; i < emotion.length - 1; i++) {
                                if (emotion[i] == 0) {
                                    str = str + "/高兴";
                                }
                                else if (emotion[i] == 1)
                                {
                                    str = str + "/伤感";
                                }
                                else if (emotion[i] == 2) {
                                    str = str + "/怀旧";
                                }
                                else if (emotion[i] == 3) {
                                    str = str + "/爱情";
                                }
                            }
                            if (str == "喜欢的音乐情感：") { document.getElementById("emotion").innerHTML = str+"暂未选择" }
                            else { document.getElementById("emotion").innerHTML = str; }
                           


                            var str = "喜欢的音乐类型：";
                            var type = obj.userType.split(',');
                            for (i = 0; i < emotion.length - 1; i++) {
                                if (type[i] == 0) {
                                    str = str + "/流行";
                                }
                                else if (type[i] == 1) {
                                    str = str + "/纯音乐";
                                }
                                else if (type[i] == 2) {
                                    str = str + "/民谣";
                                }
                            }
                            if (str == "喜欢的音乐类型：") { document.getElementById("type").innerHTML = str + "暂未选择" }
                            else { document.getElementById("type").innerHTML = str; }

                            if (obj.userSinger == "") { document.getElementById("singer").innerHTML = "喜欢的歌手：" + "暂未设置"}
                            else { document.getElementById("singer").innerHTML = "喜欢的歌手：" + obj.userSinger; }
                            
                        </script>
                        <div class="btn-group btn-group-justified m-b" style="width:30%;position:relative;left: 35%;">
                          <a class="btn btn-success btn-rounded" data-toggle="button" onclick="updateinfo()">
                              修改个人信息
                          </a>
                          <a class="btn btn-dark btn-rounded" onclick="updatepwd()">
                             更改我的密码
                          </a>
                        </div>
                      </div>
                    </section>
                  </section>
                </aside>
              </section>
            </section>
          </section>
        </section>
    </div>
    </form>
</body>
</html>
