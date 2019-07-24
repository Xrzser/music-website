<%@ Page Language="C#" AutoEventWireup="true" CodeFile="recommend.aspx.cs" Inherits="recommend" %>

<!DOCTYPE html>
<html lang="en" class="app">
<head>  
  <meta charset="utf-8" />
  <title>For Music | Web Site</title>
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
  <script>
      //根据歌手名查询歌手信息
      function getsingerItem(singerName) {
          var singerItem;
          $.ajax({
              url: 'musiclist.aspx/getSingerItem',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'singerName':'" + singerName + "'}",
              async: true,
              success: function (data) {//这边返回的是个对象
                  singerItem = data.d;
                  //设置播放组件中的歌手头像
                  if (singerItem != null) {
                      parent.setSingerImage(singerItem.singerImage);
                      //设置播放组件的歌手信息
                      $("#span-singername", window.parent.document).text(singerItem.singerName);
                      $("#small-singercontent", window.parent.document).text(singerItem.singerContent);
                  }
                  else {
                      parent.setSingerImage("/images/default/singer/singer.jpg");
                      //设置播放组件的歌手信息
                      $("#span-singername", window.parent.document).text("");
                      $("#small-singercontent", window.parent.document).text("系统暂无该歌手信息");
                  }
              },
              error: function (err) {
                  alert('err');
              }
          });
          return singerItem;
      }
      //生成12个不重复的随机数
      var imageid = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
      imageid.sort(function () {
          return 0.5 - Math.random();
      });
      //查询推荐的音乐
      function  getRecommendMusic() {
          var musicinfodata;
          $.ajax({
              url: 'recommend.aspx/getRecommendMusic',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: true,
              data: "{}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  musicinfodata = data.d;
                  var liststr = "";
                  for (i = 0; i < musicinfodata.length; i++) {
                      liststr = liststr + "<div class='col-xs-6 col-sm-4 col-md-3 col-lg-2'><div class='item'><div class='pos-rlt'><div class='item-overlay opacity r r-2x bg-black'><div class='center text-center m-t-n'><a class='jp-play-me' style='cursor:pointer'id='" + musicinfodata[i].musicId + "'><i class='icon-control-play text i-2x'></i><i class='icon-control-pause text-active i-2x'></i></a> </div><div class='bottom padder m-b-sm'> <a href='#'><i class='fa fa-plus-circle'></i> </a> </div></div><a href='#'><img src='images/p" + imageid[i] + ".jpg' alt='' class='r r-2x img-full'></a> </div> <div class='padder-v'>   <a href='#' class='text-ellipsis'>" + musicinfodata[i].musicName + "</a><a href='#' class='text-ellipsis text-xs text-muted'>" + musicinfodata[i].musicSinger + "</a></div></div> </div>";
                  }
                  document.getElementById("item").innerHTML = liststr;
              },
              error: function (err) {
                  alert('error');
              }
          });
      }
      //查询推荐更新时间
      function getRecommendTime() {
          var time;
          $.ajax({
              url: 'recommend.aspx/getRecommendTime',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              async: true,
              data: "{}", //必须的，为空的话也必须是json字符串
              success: function (data) {//这边返回的是个对象
                  time = data.d;
                  if (time == null) {
                      document.getElementById("time").innerHTML = '';
                  }
                  else {
                      document.getElementById("time").innerHTML = '生成时间：' + time;
                  }
              },
              error: function (err) {
                  alert('error');
              }
          });
      }
  </script>
</head>

<body class="">
  <section class="vbox">
    <section>
      <section class="hbox stretch">
        <!-- 乐曲推荐主要内容 -->
        <section id="content">
          <section class="hbox stretch">
            <section>
              <section class="vbox">
                <section class="scrollable padder-lg w-f-md" id="bjax-target">
                  <h2 class="font-thin m-b">乐曲推荐 
                     <span class="musicbar animate inline m-l-sm" style="width: 20px; height: 20px">
                         <span class="bar1 a1 bg-primary lter"></span>
                         <span class="bar2 a2 bg-info lt"></span>
                         <span class="bar3 a3 bg-success"></span>
                         <span class="bar4 a4 bg-warning dk"></span>
                         <span class="bar5 a5 bg-danger dker"></span>
                     </span>
                     <span class=" h6" id="time"></span>
                     <script>
                         var time = getRecommendTime();
                     </script>
                  </h2>
                  <!--推荐item-->
                  <div class="row row-sm" id="item"></div>
                    <script>
                        getRecommendMusic();
                    </script>
                </section>
              </section>
            </section>
          </section>
        </section>
      </section>
    </section>    
  </section>
  <script>
      //点击歌曲播放暂停
      $(document).on('click', '.jp-play-me', function (e) {
          e && e.preventDefault();
          var $this = $(e.target);
          if (!$this.is('a')) $this = $this.closest('a');
          $('.jp-play-me').not($this).removeClass('active');
          $('.jp-play-me').parent('li').not($this.parent('li')).removeClass('active');

          $this.toggleClass('active');
          $this.parent('li').toggleClass('active');

          if (!$this.hasClass('active')) {
              parent.musicpause($($this.next()).attr("id"));
          } else {
              parent.musicstart($(e.target).parent().attr("id"));
              getsingerItem($this.parent().parent().parent().next().children()[1].innerHTML); 
          }

      });
  </script>
  <!-- Bootstrap -->
  <script src="js/bootstrap.js"></script>
  <!-- App -->
  <script src="js/app.js"></script>  
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
  <script src="js/app.plugin.js"></script>
</body>
</html>
