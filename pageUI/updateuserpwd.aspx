<%@ Page Language="C#" AutoEventWireup="true" CodeFile="updateuserpwd.aspx.cs" Inherits="updateuserpwd" %>

<!DOCTYPE html>
<html lang="en" class=" ">
<head>  
  <meta charset="utf-8" />
  <title>Musik | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />  
  <script src="js/jquery.min.js"></script>
  <script>
      function update() {
          var opwd = $('#opwd').val();
          var npwd1 = $('#npwd1').val();
          var npwd2 = $('#npwd2').val();
          if (npwd1!= npwd2) {
              alert('你两次输入的新密码不一致，请重新输入');
              $('#npwd1').val("");
              $('#npwd2').val("");
              $('#npwd1')[0].focus();
          }
          else
          {
              $.ajax({
                  url: 'updateuserpwd.aspx/updateUserPwd',
                  type: 'post',
                  contentType: "application/json",
                  dataType: 'json',
                  data: "{'opwd':'" + opwd + "','npwd':'" + npwd1 + "'}",
                  async: false,
                  success: function (data) {//这边返回的是个对象
                      if(data.d==1)
                      {
                          alert('密码修改成功,请重新登陆');
                          window.location.href = 'signin.aspx';

                      }
                      else {
                          alert('原密码输入错误，密码修改失败');
                      }
                  },
                  error: function (err) {
                      alert('error');
                  }
              })
          }
          
      }
  </script>
</head>
<body class="container">
  <section class="vbox">
    <section>
      <section class="hbox stretch">
        <!-- /.aside -->
        <section id="content">
          <section class="wrapper">
          <div class="m-b">
              <a class="navbar-brand block"><span class="h3 font-thin"><i class="i i-arrow-left3"></i> 请输入修改密码所必须的信息</span> </a>
              <div style="height:100px"></div>
          </div>
          <section class="wrapper">
                  <div class="container aside-xl">
                      <section class="m-b-lg">
                              <div class="form-group">
                                  <input type="password" id="opwd" placeholder="原密码" class="form-control rounded input-lg text-center no-border">
                              </div>
                              <div class="form-group">
                                  <input type="password" id="npwd1" placeholder="新密码" class="form-control rounded input-lg text-center no-border">
                              </div>
                              <div class="form-group">
                                  <input type="password" id="npwd2" placeholder="重复输入新密码" class="form-control rounded input-lg text-center no-border">
                              </div>
                              <div style="height:110px"></div>
                              <p class="text-muted text-center"><small> 改密后你需重新登陆</small></p>
                              <button  class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded" onclick="update()"><i class="icon-arrow-right pull-right"></i><span class="m-r-n-lg">确认</span></button>
                              <div class="line line-dashed"></div>
                              <p class="text-muted text-center"><small>放弃修改，请点击返回</small></p>
                              <a href="profile.aspx" class="btn btn-lg btn-info btn-block btn-rounded">返回</a>
                      </section>
                  </div>
          </section>
          </section>
        </section>
      </section>
    </section>    
  </section>

</body>
</html>
