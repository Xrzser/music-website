<%@ Page Language="C#" AutoEventWireup="true" CodeFile="updateuserinfo.aspx.cs" Inherits="updateuserinfo" %>

<!DOCTYPE html>
<html lang="en" class="app">
<head>  
  <meta charset="utf-8" />
  <title>For Music | 更改个人信息</title>
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />  
  <link rel="stylesheet" href="js/datepicker/datepicker.css" type="text/css" />
  <link rel="stylesheet" href="js/slider/slider.css" type="text/css" />
  <link rel="stylesheet" href="js/chosen/chosen.css" type="text/css" />
  <script src="js/jquery.min.js"></script>
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
      function openfile() {
          $('#uploadportrait').click();
          $('#title').hide();
          $('#uploadportrait').show();
          $('#upload').show();
          $('#Button1').show();
      }
      //通过name获取checkbox选中的值
      function fun(name) {
          obj = document.getElementsByName(name);
          check_val = [];
          for (k in obj) {
              if (obj[k].checked) {
                  check_val.push(obj[k].value);
              }
          }
          if (check_val.length == 0) {
              return "";
          }
          else
          {
              return check_val.toString() + ",";
          }
      }

      function save() {
          //获取修改后的用户信息
          var username = $("#name").val();
          var userid = "<%=Session["userid"] %>";
          var usersex = $("input[name='sex']:checked").val();
          var userlocation = $("#location").val();
          var usersignature = $("#signature").val();
          var userrhythm = fun("rhythm");
          var useremotion = fun("emotion");
          var usertype = fun("type");
          var userlanguage = fun("language");
          var usersinger = $("#singer").val();
          // console.log("{'username':'" + username + "','userid':'" + userid + "','usersex':'" + usersex + "','userlocation':'" + userlocation + "','usersignature':'" + usersignature + "','userrhythm':'" + userrhythm + "','useremotion':'" + useremotion + "','usertype':'" + usertype + "','userlanguage':'" + userlanguage + "','usersinger':'" + usersinger + "'}");

          //通过ajax传递到后台
          $.ajax({
              url: 'updateuserinfo.aspx/setUserInfo',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'username':'" + username + "','userid':'" + userid + "','usersex':'" + usersex + "','userlocation':'" + userlocation + "','usersignature':'" + usersignature + "','userrhythm':'" + userrhythm + "','useremotion':'" + useremotion + "','usertype':'" + usertype + "','userlanguage':'" + userlanguage + "','usersinger':'"+usersinger+"'}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  if (data.d == 1) {
                      alert('你的信息变更成功');
                      
                  }
              }
          });
      }
      function cancel() {
          window.location.href = "profile.aspx";
      }
  </script>
</head>
<body class="">
  <section class="vbox">
    <section>
      <section class="hbox stretch">
        <!-- /.aside -->
        <section id="content">
          <section class="vbox">
            <section class="scrollable padder">
              <section class="panel panel-default">
                <header class="panel-heading font-bold">
                  更改个人信息
                </header>
                <div class="panel-body">
                    <!--表单-->
                    <form class="form-horizontal" runat="server" id="form">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">头像</label>
                            <div class="col-sm-10" >
                                <image src="images/portrait/p<%=Session["userid"] %>.jpg" style="width:auto;max-height:100px;border-radius:50%;cursor:pointer" onclick="openfile()" id="title"></image>
                                <asp:FileUpload ID="uploadportrait" runat="server"/>
                                <script>$('#uploadportrait').hide()</script>
                            </div>
                            <div class="col-sm-10">
                                <asp:Button ID="upload" runat="server" Text="上传" OnClick="upload_Click" />
                                <asp:Button ID="Button1" runat="server" Text="取消"  />
                                <script>$('#upload').hide(); $('#Button1').hide()</script>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-10">
                                <input class="input-s datepicker-input form-control"  type="text" id="name">
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="sex" id="sex1" value="1" >男
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="sex" id="sex0" value="0">女
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">地区</label>
                            <div class="col-sm-10">
                                <input class="input-s datepicker-input form-control"  type="text" id="location">
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">个性签名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="signature">
                                <span class="help-block m-b-none"><small>用一句简单的话彰显你的个性</small></span>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">喜欢的歌手</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="singer">
                                <span class="help-block m-b-none"><small>歌手之间用逗号隔开</small></span>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">喜欢的音乐节奏</label>
                            <div class="col-sm-10">
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="0" name="rhythm">快节奏
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="1" name="rhythm">慢节奏
                                </label>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">喜欢的音乐风格</label>
                            <div class="col-sm-10">
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="0" name="emotion">高兴
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="1" name="emotion">伤感
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="2" name="emotion">怀旧
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="3" name="emotion">爱情
                                </label>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">喜欢的音乐类型</label>
                            <div class="col-sm-10">
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="0" name="type">流行
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="1" name="type">纯音乐
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="2" name="type">民谣
                                </label>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">喜欢的音乐语言</label>
                            <div class="col-sm-10">
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="0" name="language">中文
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="1" name="language">英文
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="2" name="language">日语
                                </label>
                            </div>
                        </div>
                        <div class="line line-dashed b-b line-lg pull-in"></div>
                    </form>
                    <div class="col-sm-4 col-sm-offset-2">
                        <button class="btn btn-primary" onclick="save()">&nbsp;&nbsp;保   存&nbsp;&nbsp;</button>
                        <button class="btn btn-primary" onclick="cancel()">&nbsp;&nbsp;返   回&nbsp;&nbsp;</button>
                    </div>
                </div>
              </section>
            </section>
          </section>
        </section>
      </section>
    </section>    
  </section>
  
  <script>
      var obj = GetMsg();
      $('#name').attr("value", '<%=Session["username"]%>');
      $("input[name='sex'][value=" + obj.userSex + "]").attr("checked", true);
      $('#location').attr("value", obj.userLocation);
      $('#signature').attr("value", obj.userSignature);
      $('#singer').attr("value", obj.userSinger);
      var rhythmlist = obj.userRhythm.split(",");
      var emotionlist = obj.userEmotion.split(",");
      var typelist = obj.userType.split(",");
      var languagelist = obj.userLanguage.split(",");
      for (i = 0; i < rhythmlist.length - 1; i++) { $("input[name='rhythm'][value=" + rhythmlist[i] + "]").attr("checked", true); }
      for (i = 0; i < emotionlist.length - 1; i++) { $("input[name='emotion'][value=" + emotionlist[i] + "]").attr("checked", true); }
      for (i = 0; i < typelist.length - 1; i++) { $("input[name='type'][value=" + typelist[i] + "]").attr("checked", true); }
      for (i = 0; i < languagelist.length - 1; i++) { $("input[name='language'][value=" + languagelist[i] + "]").attr("checked", true);}
  </script>


  <!-- Bootstrap -->
  <script src="js/bootstrap.js"></script>
  <!-- App -->
  <script src="js/app.js"></script>  
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
  <!-- datepicker -->
  <script src="js/datepicker/bootstrap-datepicker.js"></script>
  <!-- slider -->
  <script src="js/slider/bootstrap-slider.js"></script>
  <!-- file input -->  
  <script src="js/file-input/bootstrap-filestyle.min.js"></script>
  <!-- wysiwyg -->
  <script src="js/wysiwyg/jquery.hotkeys.js"></script>
  <script src="js/wysiwyg/bootstrap-wysiwyg.js"></script>
  <script src="js/wysiwyg/demo.js"></script>
  <script src="js/chosen/chosen.jquery.min.js"></script>
</body>
</html>