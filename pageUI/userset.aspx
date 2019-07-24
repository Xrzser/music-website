<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userset.aspx.cs" Inherits="userset" %>

<!DOCTYPE html>
<html lang="en" class="app">
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
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css">
  <link rel="stylesheet" href="css/app.css" type="text/css" />  
  <script src="js/jquery.min.js"></script>
  <script>
      //全局变量
      var rows=5;
      var fengzi;
      var fengmu;
      var num;
      var userdata;
      var id;
      //弹出窗口
      function outwindows(obj) { document.getElementById(obj).style.display = 'block'; }
      //关闭窗口
      function closewindows(obj) { document.getElementById(obj).style.display = 'none'; }
      //查询用户数量
      function getusernum() {
          var num;
          $.ajax({
              url: 'userset.aspx/getUsernum',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  num = data.d;
              }
          });
          return num;
      }
      //获得用户的分页数据
      function getPageuser(offset, rows) {
          var list;
          $.ajax({
              url: 'userset.aspx/pageQueryuser',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'offset':"+offset+",'rows':"+rows+"}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  list = data.d;
                  console.log(data.d);
              }
          });
          return list;
      }
      //加载管理员列表
      function loaduserdata(data) {
          var innerstr = "";
          var temp;
              for (i = 0; i < data.length; i++) {
                  if (data[i].userValid == 0) { temp = '封禁' } else { temp='正常'}
                  var itemstr = "<tr id='" + data[i].Id + "'><td>" + data[i].userEmail + "</td><td>" + data[i].userName + "</td><td>" + temp + "</td><td class='text-right'> <a><i class='fa fa-pencil'></i></a></td></tr>";
                  innerstr += itemstr;
              }
              document.getElementById('tableuser').innerHTML = innerstr;
              document.getElementById('pagenum').innerHTML = fengzi + '/' + fengmu;
      }
      //分页逻辑
      fengzi=1;
      num=getusernum();
      fengmu = Math.ceil(num / rows);
      function pre() {
          if (fengzi > 1) {
              fengzi = fengzi - 1;
              userdata = getPageuser(rows * (fengzi - 1), rows);
              loaduserdata(userdata);
          }
      }
      function next() {
          if (fengzi < fengmu) {
              userdata = getPageuser(rows * fengzi, rows);
              fengzi  = fengzi + 1;
              loaduserdata(userdata);
          }
      }
      //重置密码
      function resetpwd() {
          $.ajax({
              url: 'userset.aspx/resetPwd',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'userId':"+id+"}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  alert('密码已重置');
              }
          });
      }
      //编辑用户
      function save() {
          //获取更改后的数据
          var name = $("#username-val").val();
          var valid = $("input[name='valid']:checked").val();
          $.ajax({
              url: 'userset.aspx/save',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'id':"+id+",'name':'"+name+"','valid':"+valid+"}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  alert('用户信息已经修改');
                  userdata = getPageuser(rows * (fengzi-1), rows);
                  loaduserdata(userdata);
                  closewindows('editadm');
              }
          });
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
                            <div class="m-b-md">
                                <h3 class="m-b-none">用户管理 </h3>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <section class="panel panel-default">
                                        <header class="panel-heading">
                                            <span class="label bg-danger pull-right m-t-xs">用户管理是系统较高权限，请谨慎使用</span>
                                            &nbsp;
                                        </header>
                                        <table class="table table-striped m-b-none">
                                            <thead>
                                                <tr>
                                                    <th>用户邮箱</th>
                                                    <th>用户名</th>
                                                    <th>用户状态</th>
                                                    <th style="width: 70px;">编辑</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableuser">
                                            </tbody>
                                        </table>
                                        <div class=" padder-md padder-v">
                                            <div>
                                                <button onclick="pre()">上一页</button>
                                                <span id="pagenum"></span>
                                                <script>
                                                    //初始化加载第一页数据
                                                    document.getElementById('pagenum').innerHTML = fengzi + '/' + fengmu;
                                                    loaduserdata(getPageuser(0, rows));
                                                </script>
                                                <button onclick="next()">下一页</button>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </section>
                    </section>
                </section>
            </section>
        </section>
    </section>
    <div id="editadm" class="bg-white-only table-bordered  padder-md padder-v" style="display: none; position: absolute; left: 36%; top: 15%; width: 28%; height: 260px;">
        <div class="h4 font-bold ">编辑用户</div><br />
        <button class="btn-xs btn-warning" onclick="resetpwd()">&nbsp;&nbsp;重置密码&nbsp;&nbsp;</button>
        <br /><br />
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">名称</label>
                <div class="col-sm-4">
                    <input class="input-s datepicker-input form-control" type="text" id="username-val">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">状态</label>
                <div class="col-sm-4">
                    <div class="radio" style="float: left">
                        <label>
                            <input type="radio" name="valid" value="0">封禁</label>
                    </div>
                    <div class="radio" style="float: right">
                        <label>
                            <input type="radio" name="valid" value="1">正常</label>
                    </div>
                </div>
            </div>
        </form>
        <br />
        <div class="pull-left">
            <button class="btn btn-primary" onclick="save()">&nbsp;&nbsp;保   存&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="closewindows('editadm')">&nbsp;&nbsp;返   回&nbsp;&nbsp;</button>
        </div>
    </div>
    <script>
        //点击编辑用户
        $(document).on('click', '.fa-pencil', function (e) {
            //获得用户id
            id = $(e.target).parent().parent().parent().attr('id');
            var valid=1;
            //重置编辑弹窗
            $("#username-val").attr("value", $(e.target).parent().parent().parent().children(0)[1].innerHTML);
            if ($(e.target).parent().parent().parent().children(0)[2].innerHTML == '封禁') { valid = 0;}
            $("input[name='valid'][value=" + valid+ "]").attr("checked", true)
            //弹出弹窗
            outwindows('editadm');
        })
    </script>
</body>
</html>
