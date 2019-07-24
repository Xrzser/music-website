<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
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
      //设置歌手小头像
      function setSingerImage(path) {
          $(".singerimage").attr("src", path);
      }
      //点击歌手小头像信息事件
      function clicksingerinfo() {
          //alert("功能待实现")
      }
      //点击搜索按钮
      function search() {
          iframe.location = 'searchres.aspx';
      }
  </script>
</head>
        
<body class="">
    <section class="vbox">
    <!--顶部不动部分-->
      <header class="bg-white-only header header-md navbar navbar-fixed-top-xs">
          <div class="navbar-header aside bg-info nav-xs">
              <a href="default.aspx" class="navbar-brand text-lt" id="portrait">
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
          <!--提交表单搜索歌曲，歌手，标签-->
          <div class="navbar-form navbar-left input-s-lg m-t m-l-n-xs hidden-xs" role="search">
              <div class="form-group">
                  <div class="input-group">
                      <span class="input-group-btn">
                          <button  class="btn btn-sm bg-white btn-icon rounded" onclick="search()"><i class="fa fa-search"></i></button>
                      </span>
                      <input type="text" id="inputkey" class="form-control input-sm no-border rounded" placeholder="Search songs, singers..." />
                  </div>
              </div>
          </div>
              <!--右上角个人中心-->
              <form id="form1" runat="server">
              <div class="navbar-right ">
                  <ul class="nav navbar-nav m-n hidden-xs nav-user user">
                      <li class="dropdown">
                          <a href="#" class="dropdown-toggle bg clear" data-toggle="dropdown" id="portraits">
                              <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm" style="height:40px;width:40px">
                                  <img src="images/portrait/p<%=Session["userid"] %>.jpg" alt="还未上传头像"/>
                              </span>
                              <%=Session["username"]%>
                              <b class="caret"></b>
                          </a>
                          <script>
                              var userid = '<%=Session["userid"]%>';
                              if (userid == '') {
                                  document.getElementById('portraits').style.display = "none";
                              }
                          </script>
                          <ul class="dropdown-menu animated fadeInRight">
                              <li>
                                  <a href="profile.aspx" target="_blank">个人中心</a>
                              </li>
                              <li>
                                  <asp:LinkButton ID="LinkButton_logout" runat="server" OnClick="LinkButton_logout_Click">退出登录</asp:LinkButton>
                              </li>
                              <li class="divider"></li>
                              <li>
                                  <asp:LinkButton ID="LinkButton_aboutus" runat="server" OnClick="LinkButton_aboutus_Click">关于我们</asp:LinkButton>
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
                    <li>
                      <a onclick="iframe.location='recommend.aspx'">
                        <i class="icon-disc icon text-success"></i>
                        <span class="font-bold">音乐推荐</span>
                      </a>
                    </li>
                    <li>
                      <a onclick="iframe.location='musiclist.aspx'">
                        <i class="icon-music-tone-alt icon text-info"></i>
                        <span class="font-bold">音乐库</span>
                      </a>
                    </li>
                    <li id="mylist">
                      <a onclick="iframe.location='mylist.aspx'">
                        <i class="icon-list icon  text-info-dker"></i>
                        <span class="font-bold">我的歌单</span>
                      </a>
                    </li>
                   <li id="shangchuan">
                      <a onclick="iframe.location='musicupload.aspx'">
                        <i class="icon-cloud-upload icon  text-info-dker"></i>
                        <span class="font-bold">音乐上传</span>
                      </a>
                    </li>
                    <script>
                        if(userid=='')
                        {
                            document.getElementById("shangchuan").style.display = "none";
                            document.getElementById("mylist").style.display = "none";
                        }
                    </script>
                    <li class="m-b hidden-nav-xs"></li>
                  </ul>
                  <ul class="nav" data-ride="collapse">
                    <li class="hidden-nav-xs padder m-t m-b-sm text-xs text-muted">
                      个人中心
                    </li>
                    <li >
                      <a href="#" class="auto">
                        <span class="pull-right text-muted">
                          <i class="fa fa-angle-left text"></i>
                          <i class="fa fa-angle-down text-active"></i>
                        </span>
                        <i class="icon-grid icon">
                        </i>
                        <span>用户管理</span>
                      </a>
                      <ul class="nav dk text-sm">
                        <li >
                          <a href="signin.aspx" class="auto">                                                        
                            <i class="fa fa-angle-right text-xs"></i>

                            <span id="denglu">登陆其他用户</span>
                          </a>
                        </li>
                        <li >
                          <a href="signup.aspx" class="auto" target="_blank">                                                        
                            <i class="fa fa-angle-right text-xs"></i>
                            <span>新用户注册</span>
                          </a>
                        </li>
                      </ul>
                        <script>
                            if (userid == '') {
                                document.getElementById("denglu").innerHTML = "用户登陆";
                            }
                        </script>
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
                    <iframe name="iframe" src="recommend.aspx" id="chlidaspx" height="100%" width="100%"></iframe>
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
            //获得单曲数据
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'Default.aspx/getmusicinfo',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: true,
                data: "{'musicid':" + musicid + "}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    var musicobj = data.d;
                    myPlaylist.add({
                        title: musicobj.musicName,
                        artist: musicobj.musicSinger,
                        mp3: musicobj.musicPath,
                    });
                    myPlaylist.play(myPlaylist.playlist.length - 1);
                }
            });
            //单曲播放量加1
            $.ajax({
                url: 'Default.aspx/addMusicvolume',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: true,
                data: "{'musicid':" + musicid + "}", //必须的，为空的话也必须是json字符串
            })
        }
        //播放歌单
        function musicliststart(list,songsheetid) {
            myPlaylist.remove();
            myPlaylist.setPlaylist(list);
            myPlaylist.play();
            //歌单播放量+1
            $.ajax({
                url: 'Default.aspx/addSongsheetvolume',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: true,
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
                    async: true,
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