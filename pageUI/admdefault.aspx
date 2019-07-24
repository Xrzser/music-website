<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admdefault.aspx.cs" Inherits="admdefault" %>

<!DOCTYPE html>
<html lang="zh" class="app" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">  
  <meta charset="utf-8" />
  <title>For Music</title>
  <meta name="description" content="app, web app, music website" />
  <!--引入Jplayer插件和css样式 -->
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />  
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.js"></script>
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
  <script>
      var id = '<%=Session["administratorsId"]%>';
      var limit = '<%=Session["administratorsLimit"]%>'.split('');
      //弹出窗口
      function outwindows(obj) { document.getElementById(obj).style.display = 'block'; }
      //关闭窗口
      function closewindows(obj) { document.getElementById(obj).style.display = 'none'; }
      //更改密码
      function save() {
          var op = $("#oldpwd").val();
          var np = $("#newpwd").val();
          var np1 = $("#newpwd1").val();
          if (np != np1) {
              alert("两次输入的新密码不相同");
          }else
          {
              $.ajax({
                  url: 'admdefault.aspx/updatepwd',
                  type: 'post',
                  contentType: "application/json",
                  dataType: 'json',
                  async: false,
                  data: "{'op':'"+op+"','np':'"+np+"'}", //必须的，为空的话也必须是json字符串
                  success: function (data) {//这边返回的是个对象
                      if (data.d == 0) {
                          alert("密码修改成功");
                          window.location.href = "admlogin.aspx";
                      }
                      else if (data.d == -1)
                      {
                          alert("您的登陆信息已过期，请重新登录后再操作");
                          window.location.href = "admlogin.aspx";
                      }
                      else
                      {
                          alert("系统错误");
                      }
                  }
              });
          }
      }
  </script>
</head>
        
<body class="">
    <section class="vbox">
    <!--顶部不动部分-->
      <header class="bg-white-only header header-md navbar navbar-fixed-top-xs">
          <div class="navbar-header aside bg-info nav-xs">
                  <a href="admdefault.aspx" class="navbar-brand text-lt" id="portrait">
                      <i class="icon-earphones"></i>
                      <img src="images/logo.png" alt="." class="hide" />
                      <span class="hidden-nav-xs m-l-sm">For Music</span>
                  </a>
          </div>
          <ul class="nav navbar-nav hidden-xs">
              <li>
                  <a href="#nav,.navbar-header" data-toggle="class:nav-xs,nav-xs" class="text-muted">
                      <i class="fa fa-indent text"></i>
                      <i class="fa fa-dedent text-active"></i>
                  </a>
              </li>
          </ul>
          <!--右上角个人中心-->
          <form id="form1" runat="server">
              <div class="navbar-right ">
                  <ul class="nav navbar-nav m-n hidden-xs nav-user user">
                      <li class="dropdown">
                          <a href="#" class="dropdown-toggle bg clear" data-toggle="dropdown" id="portraits">
                              <%=Session["administratorsName"]%>
                              <b class="caret"></b>
                          </a>
                          <ul class="dropdown-menu animated fadeInRight">
                              <li>
                                  <a onclick="outwindows('updatepwd')">更改密码</a>
                              </li>
                              <li>
                                  <asp:LinkButton ID="LinkButton_logout" runat="server" OnClick="LinkButton_logout_Click">安全退出</asp:LinkButton>
                              </li>
                          </ul>
                      </li>
                  </ul>
              </div>
          </form>
      </header>
    <section>
      <section class="hbox stretch">
        <aside class="bg-black dk nav-xs aside hidden-print" id="nav">          
          <section class="vbox">
            <!-- nav标签|左边的菜单栏 -->
            <section class="w-f-md scrollable">
              <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="10px" data-railopacity="0.2">                 
                <nav class="nav-primary hidden-xs">
                  <ul class="nav bg clearfix">
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      音乐
                    </li>
                    <li id="admset">
                      <a onclick="iframe.location='admset.aspx'" >
                        <i class="  icon-settings icon text-success"></i>
                        <span class="font-bold">管理员管理</span>
                      </a>
                    </li>
                    <script> if (id != 1) { $('#admset').hide()}</script>
                    <li id="userset">
                      <a onclick="iframe.location='userset.aspx'">
                        <i class=" icon-users icon text-success"></i>
                        <span class="font-bold">用户管理</span>
                      </a>
                    </li>
                    <script> if (limit[0] == 0) { $('#userset').hide() }</script>
                    <li id="musicset">
                      <a onclick="iframe.location='musicset.aspx'">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">音乐管理</span>
                      </a>
                    </li>
                    <script> if (limit[1] == 0) { $('#musicset').hide() }</script>
                    <li id="anaset">
                      <a onclick="iframe.location='anaset.aspx'">
                        <i class=" icon-screen-desktop icon  text-info-dker"></i>
                        <span class="font-bold">后台统计</span>
                      </a>
                    </li>
                    <script> if (limit[2] == 0) { $('#anaset').hide() }</script>
                  </ul>
                  <ul class="nav" data-ride="collapse">
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-grid icon">
                        </i>
                        <span>其他</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li ><br />
                          <a href="admlogin.aspx" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>
                            <span id="denglu">登陆其他管理员</span>
                          </a><br />
                        </li>
                      </ul>
                    </li>
                  </ul>  
                </nav>
              </div>
            </section>
            <!--左下角歌手区域-->
            <footer class="footer hidden-xs no-padder text-center-nav-xs">
              <div class="bg hidden-xs ">
                  <div class="dropdown dropup wrapper-sm clearfix">
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                          <span class="thumb-sm avatar pull-left m-l-xs">
                              <!--左下角歌手头像-->
                              <img src="/images/default/singer/singer.jpg" class="dker singerimage" alt="..." />
                          </span>
                      </a>
                    <ul class="dropdown-menu animated fadeInRight aside text-left" >
                      <li class="list-group-item clearfix">
                          <a class='clear' onclick="clicksingerinfo()"> 
                              <span class='block text-ellipsis' id="span-singername"></span>  
                              <small class='text-muted' id="small-singercontent"></small>
                          </a>
                      </li>
                    </ul>
                  </div>
                </div>            
              </footer>
          </section>
        </aside>
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <!--在这里引入变化部分即可-->
                    <iframe id="mainframe" name="iframe" height="100%" width="100%"></iframe>
                     <script>
                         if (id == 1) { $('#mainframe').attr('src', 'admset.aspx') }
                         else
                         {
                             for (i = 0; i < limit.length; i++) {
                                 if (limit[i] == 1) {
                                     if (i == 0) { $('#mainframe').attr('src', 'userset.aspx') }
                                     else if (i == 1) { $('#mainframe').attr('src', 'musicset.aspx') }
                                     else { $('#mainframe').attr('src', 'anaset.aspx') }
                                     break;
                                 }
                                 if (i == 2) {
                                     alert('您目前没有任何权限，如有疑问请联系超级管理员。');
                                 }
                             }

                         }
                     </script>
                <!--播放器组件-->
                <footer class="footer bg-dark">
                  <div id="jp_container_N">
                    <div class="jp-type-playlist">
                      <div id="jplayer_N" class="jp-jplayer hide"></div>
                      <div class="jp-gui">
                        <div class="jp-video-play hide">
                          <a class="jp-video-play-icon">play</a>
                        </div>
                        <div class="jp-interface">
                          <div class="jp-controls">
                            <!--上一首-->
                            <div><a class="jp-previous"><i class="icon-control-rewind i-lg"></i></a></div>
                            <!--开始播放和暂停-->
                            <div>
                              <a class="jp-play"><i class="icon-control-play i-2x"></i></a>
                              <a class="jp-pause hid"><i class="icon-control-pause i-2x"></i></a>
                            </div>
                            <!--下一首-->
                            <div><a class="jp-next"><i class="icon-control-forward i-lg"></i></a></div>

                            <div class="hide"><a class="jp-stop"><i class="fa fa-stop"></i></a></div>

                            <!--播放的歌单-->
                            <div>
                              <a class="" data-toggle="dropdown" data-target="#playlist"><i class="icon-list"></i></a>
                            </div>
                            <!--播放组建的歌曲名字显示-->
                            <div class="jp-progress hidden-xs">
                              <div class="jp-seek-bar dk">
                                <div class="jp-play-bar bg-info">
                                </div>
                                <div class="jp-title text-lt">
                                  <ul>
                                    <li></li>
                                  </ul>
                                </div>
                              </div>
                            </div>
                            <!--时间-->
                            <div class="hidden-xs hidden-sm jp-current-time text-xs text-muted"></div>
                            <div class="hidden-xs hidden-sm jp-duration text-xs text-muted"></div>
                            <!--静音喇叭-->
                            <div class="hidden-xs hidden-sm">
                              <a class="jp-mute" title="mute"><i class="icon-volume-2"></i></a>
                              <a class="jp-unmute hid" title="unmute"><i class="icon-volume-off"></i></a>
                            </div>
                            <!--音量条-->
                            <div class="hidden-xs hidden-sm jp-volume">
                              <div class="jp-volume-bar dk">
                                <div class="jp-volume-bar-value lter"></div>
                              </div>
                            </div>
                            <!--随机播放按钮-->
                            <div>
                              <a class="jp-shuffle" title="shuffle"><i class="icon-shuffle text-muted"></i></a>
                              <a class="jp-shuffle-off hid" title="shuffle off"><i class="icon-shuffle text-lt"></i></a>
                            </div>
                            <!--循环播放图标-->
                            <div>
                              <a class="jp-repeat" title="repeat"><i class="icon-loop text-muted"></i></a>
                              <a class="jp-repeat-off hid" title="repeat off"><i class="icon-loop text-lt"></i></a>
                            </div>
                            <!--不知道什么鬼-->
                            <div class="hide">
                              <a class="jp-full-screen" title="full screen"><i class="fa fa-expand"></i></a>
                              <a class="jp-restore-screen" title="restore screen"><i class="fa fa-compress text-lt"></i></a>
                            </div>
                          </div>
                        </div>
                      </div>
                      
                      <div class="jp-playlist dropup" id="playlist">
                        <ul class="dropdown-menu aside-xl dker">
                          <!-- The method Playlist.displayPlaylist() uses this unordered list -->
                          <li class="list-group-item"></li>
                        </ul>
                      </div>
                      <div class="jp-no-solution hide">
                        <span>Update Required</span>
                        To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
                      </div>
                    </div>
                  </div>
                </footer>
              </section>
            </section>
          </section>
        </section>
      </section>
    </section>    
  </section>
  <div id="updatepwd" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 28%; height: 280px">
        <div class="h4 font-bold text-left">更改密码</div>
        <br /><br />
        <form class="form-horizontal" >
            <div class="form-group">
                <label class="col-sm-3 control-label">输入原密码</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="password" id="oldpwd"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">输入新密码</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="password" id="newpwd"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">重复新密码</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="password" id="newpwd1"/>
                </div>
            </div>
        </form>
        <div>
            <button class="btn btn-primary" onclick="save()">&nbsp;&nbsp;更  改&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="closewindows('updatepwd')">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
        </div>
    </div>
  <!-- App -->
  <script src="js/app.js"></script>  
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="js/app.plugin.js"></script>
  <!-- Jplayer -->
  <script type="text/javascript" src="js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="js/jPlayer/demo.js"></script>
  <!--播放组件-->
    <script>
        var myPlaylist = new jPlayerPlaylist({
            jPlayer: "#jplayer_N",
            cssSelectorAncestor: "#jp_container_N"
        }, [

        ], {
            playlistOptions: {
                enableRemoveControls: true,
                autoPlay: false
            },
            swfPath: "js/jPlayer",
            supplied: "webmv, ogv, m4v, oga, mp3",
            smoothPlayBar: true,
            keyEnabled: true,
            audioFullScreen: false
        });
        //开始播放某一首歌
        function musicstart(musicid) {
            //单曲播放量加1
            $.ajax({
                url: 'Default.aspx/addMusicvolume',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'musicid':" + musicid + "}", //必须的，为空的话也必须是json字符串

            })
            var musicobj;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'Default.aspx/getmusicinfo',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'musicid':" + musicid + "}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    musicobj = data.d;
                }
            });
            myPlaylist.add({
                title: musicobj.musicName,
                artist: musicobj.musicSinger,
                mp3: musicobj.musicPath,
            });
            myPlaylist.play(myPlaylist.playlist.length - 1);
        }
        //播放歌单
        function musicliststart(list, songsheetid) {
            myPlaylist.remove();
            myPlaylist.setPlaylist(list);
            myPlaylist.play();
            //歌单播放量+1
            $.ajax({
                url: 'Default.aspx/addSongsheetvolume',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'songsheetId':" + songsheetid + "}", //必须的，为空的话也必须是json字符串
            })
            //循环得到单曲Id播放量+1
            for (i = 0; i < list.length; i++) {
                //单曲播放量加1
                $.ajax({
                    url: 'Default.aspx/addMusicvolume',
                    type: 'post',
                    contentType: "application/json",
                    dataType: 'json',
                    async: false,
                    data: "{'musicid':" + list[i].musicid + "}", //必须的，为空的话也必须是json字符串
                })
            }
        }
        //暂停播放
        function musicpause(musicid) {
            myPlaylist.pause();
        }
    </script>
</body>
</html>
