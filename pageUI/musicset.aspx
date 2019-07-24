<%@ Page Language="C#" AutoEventWireup="true" CodeFile="musicset.aspx.cs" Inherits="musicset" %>

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
      var id;
      var rows1 = 10;
      var rows2 = 10;
      var fengzi1;
      var fengmu1;
      var num1;
      var num2;
      var singerdata;
      var musicdata;
      //弹出窗口
      function outwindows(obj) { document.getElementById(obj).style.display = 'block'; }
      //关闭窗口
      function closewindows(obj) { document.getElementById(obj).style.display = 'none'; }
      //查询歌手数量
      function getsingernum() {
          var num;
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musiclist.aspx/getSingerNum',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  num = data.d;
              },
              error: function (err) {
                  alert('err');
              }
          });
          return num;
      }
      //查询歌曲数量
      function getmusicnum() {
          var num;
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musiclist.aspx/getmusicnum',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'singerName':''}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  num = data.d;
              },
              error: function (err) {
                  alert('err');
              }
          });
          return num;
      }
      //获得歌手的分页数据
      function getSinger(offset, rows) {
          $.ajax({
              url: 'musiclist.aspx/getSinger',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'offset':" + offset + ",'rows':" + rows + "}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  singerdata = data.d;
              },
              error: function (err) {
                  alert('err');
              }
          })
          return singerdata;
      }
      //获得歌曲的分页数据
      function Getmusic(offset, rows) {
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musiclist.aspx/Getmusic',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'offset':" + offset + ",'rows':" + rows + ",'singerName':''}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  musicdata = data.d;
              },
              error: function (err) {
                  alert('err');
              }
          });
          return musicdata;
      }
      //加载歌手列表
      function loadsingerdata(data) {
          var innerstr = "";
          for (i = 0; i < data.length; i++) {
              var temp = "男";
              if (data[i].singerSex == 0) { temp='女'}
              var itemstr = "<tr id='" + data[i].singerId + "'><td>" + data[i].singerName + "</td><td>" + temp + "</td><td>" + data[i].singerContent + "</td><td class='text-right'> <a><i class='fa fa-pencil editsinger'></i></a></td></tr>";
              innerstr += itemstr;
          }
          document.getElementById('tablesinger').innerHTML = innerstr;
          document.getElementById('singerpagenum').innerHTML = fengzi1 + '/' + fengmu1;
      }
      //加载歌曲列表
      function loadmusicdata(data) {
          var innerstr = "";
          for (i = 0; i < data.length; i++) {
              var itemstr = "<tr id='" + data[i].musicId + "'><td>" + data[i].musicName + "</td><td>" + data[i].musicSinger + "</td><td>" + data[i].musicVolume + "</td><td class='text-right'> <a><i class='fa fa-pencil editmusic'></i></a></td></tr>";
              innerstr += itemstr;
          }
          document.getElementById('tablemusic').innerHTML = innerstr;
          document.getElementById('musicpagenum').innerHTML = fengzi2 + '/' + fengmu2;
      }
      //歌手分页逻辑
      fengzi1 = 1;
      num1 = getsingernum();
      fengmu1 = Math.ceil(num1 / rows1);
      function singerpre() {
          if (fengzi1 > 1) {
              fengzi1 = fengzi1 - 1;
              singerdata = getSinger(rows1 * (fengzi1 - 1), rows1);
              loadsingerdata(singerdata);
          }
      }
      function singernext() {
          if (fengzi1 < fengmu1) {
              singerdata = getSinger(rows1 * fengzi1, rows1);
              fengzi1 = fengzi1 + 1;
              loadsingerdata(singerdata);
          }
      }
      //歌曲分页逻辑
      fengzi2 = 1;
      num2 = getmusicnum();
      fengmu2 = Math.ceil(num2 / rows2);
      function musicpre() {
          if (fengzi2 > 1) {
              fengzi2 = fengzi2 - 1;
              musicdata = Getmusic(rows2 * (fengzi2 - 1), rows2);
              loadmusicdata(musicdata);
          }
      }
      function musicnext() {
          if (fengzi2 < fengmu2) {
              musicdata = Getmusic(rows2 * fengzi2, rows2);
              fengzi2 = fengzi2 + 1;
              loadmusicdata(musicdata);
          }
      }
      //编辑歌手
      function editsinger() {
          var name = $("#singername").val();
          var content = $("#singercontent").val();
          var sex = $("input[name='singersex']:checked").val();
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musicset.aspx/editSinger',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'singerId':" + id + ",'singerName':'" + name + "','singerSex':" + sex + ",'singerContent':'" + content + "'}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  alert("保存成功");
                  closewindows('editsinger');
                  singerdata = getSinger(rows1 * (fengzi1 - 1), rows1);
                  loadsingerdata(singerdata);
              },
              error: function (err) {
                  alert('err');
              }
          });
      }
      //删除歌手
      function delsinger() {
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musicset.aspx/delSinger',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'singerId':" + id + "}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  alert("删除成功");
                  closewindows('editsinger');
                  singerdata = getSinger(rows1 * (fengzi1 - 1), rows1);
                  loadsingerdata(singerdata);
              },
              error: function (err) {
                  alert('err');
              }
          });
      }
      //添加歌手
      function addsinger() {
          outwindows('addsinger');
      }
      //编辑歌曲
      function editmusic() {
          var name = $("#musicname").val();
          var singer = $("#musicsinger").val();
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musicset.aspx/editMusic',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'musicName':'"+name+"','musicSinger':'"+singer+"','musicId':" + id + "}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  alert("更改已保存");
                  closewindows('editmusic');
                  musicdata = Getmusic(rows2 * (fengzi2 - 1), rows2);
                  loadmusicdata(musicdata);
              },
              error: function (err) {
                  alert('err');
              }
          });
      }
      //删除歌曲
      function delmusic() {
          $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
              url: 'musicset.aspx/delMusic',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'musicId':" + id + "}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  alert("歌曲已删除");
                  closewindows('editmusic');
                  musicdata = Getmusic(rows2 * (fengzi2 - 1), rows2);
                  loadmusicdata(musicdata);
              },
              error: function (err) {
                  alert('err');
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
                                <h3 class="m-b-none">歌手和音乐管理 </h3>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <!--歌手管理-->
                                    <section class="panel panel-default">
                                        <header class="panel-heading">
                                            <span class="label bg-danger pull-right m-t-xs">歌手管理是系统较高权限，请谨慎使用</span>
                                            <h4>歌手管理</h4>
                                        </header>
                                        <table class="table table-striped m-b-none">
                                            <thead>
                                                <tr>
                                                    <th>歌手名字</th>
                                                    <th>歌手性别</th>
                                                    <th>歌手描述</th>
                                                    <th style="width: 70px;">编辑</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tablesinger">
                                            </tbody>
                                        </table>
                                        <div class=" padder-md padder-v">
                                            <div>
                                                <button onclick="singerpre()">上一页</button>
                                                <span id="singerpagenum"></span>
                                                <script>
                                                    //初始化加载第一页数据
                                                    document.getElementById('singerpagenum').innerHTML = fengzi1 + '/' + fengmu1;
                                                    loadsingerdata(getSinger(0, rows1));
                                                </script>
                                                <button onclick="singernext()">下一页</button>
                                                <button class="pull-right" onclick="addsinger()">添加歌手</button>
                                            </div>
                                        </div>
                                    </section>
                                    <!--歌曲管理-->
                                    <section class="panel panel-default">
                                        <header class="panel-heading">
                                            <span class="label bg-danger pull-right m-t-xs">用户管理是系统较高权限，请谨慎使用</span>
                                            <h4>歌曲管理</h4>
                                        </header>
                                        <table class="table table-striped m-b-none">
                                            <thead>
                                                <tr>
                                                    <th>歌曲名称</th>
                                                    <th>歌手</th>
                                                    <th>播放量</th>
                                                    <th style="width: 70px;">编辑</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tablemusic">
                                            </tbody>
                                        </table>
                                        <div class=" padder-md padder-v">
                                            <div>
                                                <button onclick="musicpre()">上一页</button>
                                                <span id="musicpagenum"></span>
                                                <script>
                                                    //初始化加载第一页数据
                                                    document.getElementById('musicpagenum').innerHTML = fengzi2 + '/' + fengmu2;
                                                    loadmusicdata(Getmusic(0, rows2));
                                                </script>
                                                <button onclick="musicnext()">下一页</button>
                                            </div>
                                        </div>
                                    </section>
                                    <div style="height: 80px"></div>
                                </div>
                            </div>
                        </section>
                    </section>
                </section>
            </section>
        </section>
    </section>
    <div id="editsinger" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 28%; height: 300px">
        <div class="h4 font-bold text-left">编辑歌手</div>
        <br /><button class="btn" onclick="delsinger()">&nbsp;&nbsp;删除歌手&nbsp;&nbsp;</button>
        <br /><br />
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">歌手名称</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="singername">
                </div>
            </div>
        </form>
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">歌手描述</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="singercontent">
                </div>
            </div>
        </form>
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">歌手性别</label>
                <div class="col-sm-4">
                    <div class="radio" style="float: left">
                        <label>
                            <input type="radio" name="singersex" value="1">男</label>
                    </div>
                    <div class="radio" style="float: right">
                        <label>
                            <input type="radio" name="singersex" value="0">女</label>
                    </div>
                </div>
            </div>
        </form>
        <div>
            <button class="btn btn-primary" onclick="editsinger()">&nbsp;&nbsp;保   存&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="closewindows('editsinger')">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
        </div>
    </div>
    <div id="editmusic" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 28%; height: 260px">
        <div class="h4 font-bold text-left">编辑歌曲</div>
        <br /><button class="btn" onclick="delmusic()">&nbsp;&nbsp;删除歌曲&nbsp;&nbsp;</button>
        <br /><br />
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">歌曲名称</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="musicname">
                </div>
            </div>
        </form>
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">歌手名字</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="musicsinger">
                </div>
            </div>
        </form>
        <div>
            <button class="btn btn-primary" onclick="editmusic()">&nbsp;&nbsp;保   存&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="closewindows('editmusic')">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
        </div>
    </div>
    <div id="addsinger" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 28%; height: 300px">
        <div class="h4 font-bold text-left">添加歌手</div>
        <br />
        <form runat="server">
            <asp:Label ID="Label1" runat="server" Text="名称"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br /><br />
            <asp:Label ID="Label2" runat="server" Text="性别"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:RadioButton ID="RadioButton1" runat="server" GroupName="sex"/>男&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="RadioButton2" runat="server" GroupName="sex"/>女<br /><br />
            <asp:Label ID="Label3" runat="server" Text="描述"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox><br /><br />
            <asp:Label ID="Label4" runat="server" CssClass="h6" Text="点击选择文件按钮选择歌手头像">
            </asp:Label><asp:FileUpload ID="FileUpload1" runat="server" /><br />
            <div>
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="添   加" OnClick="Button1_Click" />
                <button class="btn btn-primary">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
            </div>
        </form>
    </div>
    <script>
        //点击编辑歌手
        $(document).on('click', '.editsinger', function (e) {
            //获得歌手id
            id = $(e.target).parent().parent().parent().attr('id');;
            //重置编辑弹窗
            for (i = 0; i < singerdata.length; i++) {
                if (singerdata[i].singerId == id) {
                    $("#singername").attr("value", singerdata[i].singerName);
                    $("#singercontent").attr("value", singerdata[i].singerContent);
                    $("input[name='singersex'][value=" + singerdata[i].singerSex + "]").attr("checked", true);
                }
            }
            //弹出弹窗
            outwindows('editsinger');
        })
        //点击编辑歌曲
        $(document).on('click', '.editmusic', function (e) {
            //获得歌曲id
            id = $(e.target).parent().parent().parent().attr('id');
            //重置编辑弹窗
            console.log(musicdata);
            for (i = 0; i < musicdata.length; i++) {
                if (musicdata[i].musicId == id) {
                    $("#musicname").attr("value", musicdata[i].musicName);
                    $("#musicsinger").attr("value", musicdata[i].musicSinger);
                }
            }
            //弹出弹窗
            outwindows('editmusic');
        })
    </script>
</body>
</html>

