<%@ Page Language="C#" AutoEventWireup="true" CodeFile="musicupload.aspx.cs" Inherits="musicupload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>For Music|音乐上传</title>
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" /> 
  <script type="text/javascript" src="js/jquery.min.js"></script>
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
                    msg = data.d;
                }
            });
            return msg;
        }
    </script>
    <form id="form1" runat="server">
    <div>
        <div class="bg-light dk">
        <section id="content">
          <section class="vbox">
            <section class="scrollable">
              <section class="hbox stretch">
                <!--左边部分-->
                <aside class="aside-lg bg-light lter b-r ">
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
                          <div class="panel wrapper" style="text-align:center" id="loved"></div>
                         <div class="panel wrapper" style="text-align:center" id="singer"></div>
                        <script>
                            var obj = GetMsg();
                            document.getElementById("location").innerHTML = obj.userLocation;
                            if (obj.userSex == 0) { document.getElementById("sex").innerHTML = "男" } else { document.getElementById("sex").innerHTML = "女" }
                            document.getElementById("signature").innerHTML = "个性签名：" + obj.userSignature;

                            var str = "音乐品味：";
                            var userRhythm = obj.userRhythm.split(",");
                            var userEmotion = obj.userEmotion.split(",");
                            var userType = obj.userType.split(",");
                            var userLanguage = obj.userLanguage.split(",");
                            
                            for(i=0;i<userRhythm.length-1;i++){
                                if (userRhythm[i] == 0) { str += " 快节奏" }
                                if (userRhythm[i] == 1) { str += " 慢节奏" }
                            }
                            for (i = 0; i < userEmotion.length - 1; i++) {
                                if (userEmotion[i] == 0) { str += " 高兴" }
                                if (userEmotion[i] == 1) { str += " 伤感" }
                                if (userEmotion[i] == 2) { str += " 怀旧" }
                                if (userEmotion[i] == 3) { str += " 爱情" }
                            }
                            for (i = 0; i < userType.length - 1; i++) {
                                if (userType[i] == 0) { str += " 流行" }
                                if (userType[i] == 0) { str += " 纯音乐" }
                                if (userType[i] == 0) { str += " 民谣" }
                            }
                            for (i = 0; i < userLanguage.length - 1; i++) {
                                if (userLanguage[i] == 0) { str += " 中文" }
                                if (userLanguage[i] == 1) { str += " 英文" }
                            }
                            document.getElementById("loved").innerHTML = str;

                            document.getElementById("singer").innerHTML = "喜欢的歌手：" + obj.userSinger;
                        </script>
                        
                      </div>
                    </section>
                  </section>
                </aside>
                <div class="padder-md padder-v">
                    <aside class="wrapper">
                    <asp:Label runat="server" CssClass="h4">歌曲名:</asp:Label> <asp:TextBox runat="server" ID="musicname" Width="228px"></asp:TextBox><br /><br />
                    <asp:Label runat="server"  CssClass="h4">歌手名:</asp:Label> <asp:TextBox runat="server" ID="musicsinger" Width="228px"></asp:TextBox><br /><br />
                    <asp:Panel ID="Panel1" runat="server">
                    <asp:Label runat="server" Text="" CssClass="h4">音乐节奏：</asp:Label>
                    <asp:RadioButton ID="kuai" runat="server" Text="快" GroupName="Panel1" CssClass=" radio-inline"/>
                    <asp:RadioButton ID="man" runat="server" Text="慢"  GroupName="Panel1" CssClass=" radio-inline"/>
                    </asp:Panel><br />

                    <asp:Panel ID="Panel2" runat="server">
                    <asp:Label runat="server" Text="" CssClass="h4">音乐表达：</asp:Label>
                    <asp:RadioButton ID="gaoxing" runat="server" Text="高兴"  GroupName="Panel2" CssClass=" radio-inline"/>
                    <asp:RadioButton ID="shanggan" runat="server" Text="伤感" GroupName="Panel2"  CssClass=" radio-inline"/>
                    <asp:RadioButton ID="huaijiu" runat="server" Text="怀旧" GroupName="Panel2" CssClass=" radio-inline"/>
                    <asp:RadioButton ID="aiqing" runat="server" Text="爱情" GroupName="Panel2" CssClass=" radio-inline"/>
                    </asp:Panel><br />

                    <asp:Panel ID="Panel3" runat="server">
                    <asp:Label runat="server" Text="" CssClass="h4">音乐类型：</asp:Label>
                    <asp:RadioButton ID="liuxin" runat="server" Text="流行" GroupName="Panel3" CssClass=" radio-inline"/>
                    <asp:RadioButton ID="chunyinyue" runat="server" Text="纯音乐"  GroupName="Panel3" CssClass=" radio-inline"/>
                    <asp:RadioButton ID="mingyao" runat="server" Text="民谣" GroupName="Panel3" CssClass=" radio-inline"/>
                    </asp:Panel><br />

                    <asp:Panel ID="Panel4" runat="server">
                    <asp:Label runat="server" Text="" CssClass="h4">音乐语种：</asp:Label>
                    <asp:RadioButton ID="ch" runat="server" Text="中文"  GroupName="Panel4" CssClass=" radio-inline"/>
                    <asp:RadioButton ID="en" runat="server" Text="英文"  GroupName="Panel4" CssClass=" radio-inline"/>
                    </asp:Panel><br />

                    <asp:FileUpload ID="Fileupload" runat="server" /><br />
                    <asp:Button ID="upload" runat="server" Text="上传" OnClick="upload_Click" CssClass="btn btn-primary"/>

                </aside>
                </div>
              </section>
            </section>
          </section>
        </section>
    </div>
    </div>
    <div class="footer">
                        <h4 class="font-thin padder">For Music</h4>
                        <ul class="list-group">
                          <li class="list-group-item">
                              <p>欢迎向For Music 平台上传优质歌曲，我们致上诚挚的谢意。</p>
                              <sm class="block text-muted"> 西安电子科技大学<br>&copy; 2019</sm  all>
                          </li>
                             <br /><br /><br /><br />
                        </ul>       
     </div>
    </form>
</body>
</html>
