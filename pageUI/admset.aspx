<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admset.aspx.cs" Inherits="admset" %>

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
  <link rel="stylesheet" href="css/app.css" type="text/css" />  
  <script src="js/jquery.min.js"></script>
  <script>
      //全局变量
      var admlistinfo;
      var id;
      //得到管理员列表
      function getadmsinfo() {
          var admlist;
          $.ajax({ 
              url: 'admset.aspx/getAlladmsinfo',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  admlist = data.d;
              }
          });
          return admlist;
      }
      //加载管理员列表
      function loadadminfo(adminfos) {
          if (adminfos == null) { alert('您没有此权限') }
          else
          {
              var innerstr = "";
              for (i = 0; i < adminfos.length; i++) {
                  var itemcheck = adminfos[i].administratorsLimit.split("");
                  var itemcheck1, itemcheck2, itemcheck3;
                  if (itemcheck[0] == "0") { itemcheck1 = "<i class='icon-ban'></i>" } else { itemcheck1 = "<i class='icon-check'></i>" }
                  if (itemcheck[1] == "0") { itemcheck2 = "<i class='icon-ban'></i>" } else { itemcheck2 = "<i class='icon-check'></i>" }
                  if (itemcheck[2] == "0") { itemcheck3 = "<i class='icon-ban'></i>" } else { itemcheck3 = "<i class='icon-check'></i>" }
                  var itemstr = "<tr id='" + adminfos[i].administratorsId + "'><td>" + adminfos[i].administratorsName + "</td><td>" + itemcheck1 + "</td><td>" + itemcheck2 + "</td><td>" + itemcheck3 + "</td><td class='text-right'> <a><i class='fa fa-pencil'></i></a></td></tr>";
                  innerstr += itemstr;
              }
              document.getElementById('table1').innerHTML = innerstr;
          }
      }
      //弹出窗口
      function outwindows(obj) { document.getElementById(obj).style.display = 'block'; }
      //关闭窗口
      function closewindows(obj) { document.getElementById(obj).style.display = 'none'; }
      //添加管理员
      function addnew() {
          $.ajax({
              url: 'admset.aspx/addAdm',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'Name':'" + $("#newadmname").val().toString()+ "'}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  if (data.d == 0) { alert('您没有此权限') }
                  else
                  {
                      alert("管理员添加成功");
                      window.location.href = 'admset.aspx';
                  }
              }
          });
      }
      //编辑管理员
      function editadm() {
          //得到修改后的管理员数据
          var name = $("#admname-val").val();
          var userset = $("input[name='userset']:checked").val();
          var musicset = $("input[name='musicset']:checked").val();
          var anaset = $("input[name='anaset']:checked").val();
          var limit = userset + '' + musicset + anaset;
          console.log(name + " " +limit);
          //请求后端保存数据
          $.ajax({
              url: 'admset.aspx/updateAdm',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'id':'"+id+"','name':'"+name+"','limit':'"+limit+"'}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  if (data.d == 0) { alert('您没有此权限') }
                  else
                  {
                      alert("更改已保存生效");
                      window.location.href = 'admset.aspx';
                  }
              }
          });
      }
      //重置密码
      function resetpwd() {
          $.ajax({
              url: 'admset.aspx/resetAdmpwd',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'id':" + id + "}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  if (data.d == 0) { alert('您没有此权限') }
                  else
                  {
                      alert("密码已重置为默认密码");
                      window.location.href = 'admset.aspx';
                  }
              }
          });
      }
      //删除该管理员
      function deladm() {
          $.ajax({
              url: 'admset.aspx/deleteAdm',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: false,
              data: "{'id':" + id + "}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  if (data.d == 0) { alert('您没有此权限') }
                  else
                  {
                      alert("该管理员已删除");
                      window.location.href = 'admset.aspx';
                  }
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
                                <h3 class="m-b-none">管理员设置</h3>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <section class="panel panel-default">
                                        <header class="panel-heading">
                                            <span class="label bg-danger pull-right m-t-xs">管理员设置是系统最高权限，请谨慎使用</span>
                                            &nbsp;
                                        </header>
                                        <table class="table table-striped m-b-none">
                                            <thead>
                                                <tr>
                                                    <th>管理员名称</th>
                                                    <th>用户管理权限</th>
                                                    <th>音乐管理权限</th>
                                                    <th>后台统计权限</th>
                                                    <th style="width: 70px;">编辑</th>
                                                </tr>
                                            </thead>
                                            <tbody id="table1">
                                            </tbody>
                                        </table>
                                        <script>
                                            //加载管理员列表
                                            admlistinfo = getadmsinfo();
                                            loadadminfo(admlistinfo);
                                        </script>
                                    </section>
                                    <button class="btn btn-primary" onclick="outwindows('addnew')">添加管理员</button>
                                </div>
                            </div>
                        </section>
                    </section>
                </section>
            </section>
        </section>
    </section>
    <div id="addnew" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 30%; height: 250px">
        <div class="h4 font-bold text-left">添加管理员</div>
        <br />
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">管理员名称</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="newadmname">
                </div>
            </div>
        </form>
        <br /><br /><br />
        <div>
            <button class="btn btn-primary" onclick="addnew()">&nbsp;&nbsp;添   加&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="closewindows('addnew')">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
        </div>
        <span class="label bg-danger m-t-xs">添加的管理员名称不能重复，默认密码为六个一，默认无任何权限</span>
    </div>
    <div id="editadm" class="bg-white-only table-bordered  padder-md padder-v" style="display: none; position: absolute; left: 34%; top: 15%; width: 32%; height: 350px;">
        <div class="h4 font-bold ">编辑管理员</div><br />
        <button class="btn-xs btn-warning" onclick="resetpwd()">&nbsp;&nbsp;重置密码&nbsp;&nbsp;</button>
        <button class="btn-xs btn-warning" onclick="deladm()">&nbsp;&nbsp;删除该管理员&nbsp;&nbsp;</button>
        <br /><br />
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label">管理员的名称</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="admname-val">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">用户管理权限</label>
                <div class="col-sm-4">
                    <div class="radio" style="float: left">
                        <label>
                            <input type="radio" name="userset" value="1">授予</label>
                    </div>
                    <div class="radio" style="float: right">
                        <label>
                            <input type="radio" name="userset" value="0">禁止</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">音乐管理权限</label>
                <div class="col-sm-4">
                    <div class="radio" style="float: left">
                        <label>
                            <input type="radio" name="musicset" value="1">授予</label>
                    </div>
                    <div class="radio" style="float: right">
                        <label>
                            <input type="radio" name="musicset" value="0">禁止</label>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">后台统计权限</label>
                <div class="col-sm-4">
                    <div class="radio" style="float: left">
                        <label>
                            <input type="radio" name="anaset" value="1">授予</label>
                    </div>
                    <div class="radio" style="float: right">
                        <label>
                            <input type="radio" name="anaset" value="0">禁止</label>
                    </div>
                </div>
            </div>
        </form>
        <br />
        <div class="pull-left">
            <button class="btn btn-primary" onclick="editadm()">&nbsp;&nbsp;保   存&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="closewindows('editadm')">&nbsp;&nbsp;返   回&nbsp;&nbsp;</button>
        </div>
    </div>
    <script>
        //点击编辑管理员
        $(document).on('click', '.fa-pencil', function (e) {
            //获得管理员id
            id = $(e.target).parent().parent().parent().attr('id');
            //重置编辑弹窗
            for (i = 0; i < admlistinfo.length; i++)
            {
                if (admlistinfo[i].administratorsId == id) {
                    $("#admname-val").attr("value", admlistinfo[i].administratorsName);
                    var itemcheck = admlistinfo[i].administratorsLimit.split('');
                    $("input[name='userset'][value=" + itemcheck[0] + "]").attr("checked", true);
                    $("input[name='musicset'][value=" + itemcheck[1] + "]").attr("checked", true);
                    $("input[name='anaset'][value=" + itemcheck[2] + "]").attr("checked", true);
                }
            }
            //弹出弹窗
            outwindows('editadm');
        })
    </script>
</body>
</html>