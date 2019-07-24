<%@ Page Language="C#" AutoEventWireup="true" CodeFile="musiclist.aspx.cs" Inherits="musiclist" %>

<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <meta charset="utf-8" />
    <title>For Music</title>
    <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="css/animate.css" type="text/css" />
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
    <link rel="stylesheet" href="css/font.css" type="text/css" />
    <link rel="stylesheet" href="css/app.css" type="text/css" /> 
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script>
        //复制链接
        function copy() {
            var cpelement = document.getElementById("url");
            cpelement.select();
            document.execCommand("copy");
            alert("复制成功");
        }
        //查询我创建的歌单简要
        function getcreatedsongsheetsinfo() {
            var createdlist;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'mylist.aspx/querycreatedSongsheets',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    createdlist = data.d;
                }
            });
            return createdlist;
        }
        //选中的歌曲添加至歌单
        var checkedmusicid;
        function add() {
            var itemchecked = $("input[name='item']:checked").val();
            //向数据库中写入更改
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'musiclist.aspx/addmusictosheet',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'checkedmusicid':'" + checkedmusicid + "','itemchecked':" + itemchecked + "}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    if (data.d != 0) {
                        alert('添加歌曲成功');
                        cancel('list-table');
                    } else {
                        alert("error");
                    }
                }
            });
        }
        function cancel(obj) { document.getElementById(obj).style.display = 'none'; }

        //根据歌手名查询歌手信息并设置歌手小头像
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
        }
        //根据歌手名查询歌手信息并设置歌手大头像
        function getsingerItembig(singerName) {
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
                    //设置歌手歌单大头像及歌手信息展示
                    $(".img-responsive").attr("src", singerItem.singerImage);
                    $(".bigimage").show();
                    $("#volume").text("播放量：" + singerItem.singerVolume);
                    $("#bigsingername").text(singerItem.singerName);
                    $("#bigsingercontent").text(singerItem.singerContent);
                },
                error: function (err) {
                    alert('err');
                }
            });
        }
        //获得歌手分页数据
        function getSinger(offset, rows) {
            var singerlist;
            $.ajax({
                url: 'musiclist.aspx/getSinger',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'offset':" + offset + ",'rows':" + rows + "}",
                async: false,
                success: function (data) {//这边返回的是个对象
                    singerlist = data.d;
                },
                error: function (err) {
                    alert('err');
                }
            })
            return singerlist;
        }
        //获得歌手数量
        function getSingerNum() {
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
        //加载歌手列表
        function loadsingerlist(singerlist) {
            var innerhtml = "";
            for (var i = 0; i < singerlist.length; i++) {
                if (singerlist[i].singerSex == 0) {
                    var sex = "<a  class=' pull-right m-t-sm m-l text-md'><i class='icon-symbol-female'></i></a>";
                }
                else {
                    var sex = "<a  class='pull-right m-t-sm m-l text-md'><i class='icon-symbol-male'></i></a>";
                }
                var touxiang = "<a href='#' class='pull-left thumb-sm m-r'><img src='" + singerlist[i].singerImage + "' alt='...'></a>";
                var content = "<a class='clear' href='#'> <span class='block text-ellipsis'>" + singerlist[i].singerName + "</span> <div class='pre-scrollable' style='height:80px'><small class='text-muted'>" + singerlist[i].singerContent + "</small></div>  </a>";
                innerhtml = innerhtml + "<li class='list-group-item clearfix' id='"+singerlist[i].singerName+"'>"+sex+touxiang+content+"</li>";
            }
            document.getElementById("singerlist").innerHTML = innerhtml;
            document.getElementById("nums").innerHTML = singerfengzi + " / " + singerfengmu;
        }
        //歌手列表分页逻辑及控制
        var singernums = 6;
        var nums = getSingerNum();
        var singerfengmu = Math.ceil(nums / singernums);
        var singerfengzi = 1;
        function singernextpage() {
            if (singerfengzi < singerfengmu) {
                singerlist = getSinger(singernums * singerfengzi, singernums);
                singerfengzi = singerfengzi + 1;
                loadsingerlist(singerlist);
            }
        }
        function singerprepage() {
            if (singerfengzi > 1) {
                singerfengzi = singerfengzi - 1;
                singerlist = getSinger(singernums * (singerfengzi - 1), singernums);
                loadsingerlist(singerlist);
            }
        }
        //获得歌曲分页数据
        function Getmusic(offset, rows, singerName) {
            var musiclist;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'musiclist.aspx/Getmusic',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'offset':" + offset + ",'rows':" + rows + ",'singerName':'"+singerName+"'}",
                async: false,
                success: function (data) {//这边返回的是个对象
                    musiclist = data.d;
                },
                error: function (err) {
                    alert('err');
                }
            });
            return musiclist;
        }
        //获取乐库条目总数
        function getmusicnum(singerName) {
            var num;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'musiclist.aspx/getmusicnum',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'singerName':'"+singerName+"'}",
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
        //加载乐库列表
        function loadlist(musiclist) {
            var userid = '<%=Session["userid"]%>';
            if (userid == '') {
                var innerhtml = "";
                var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#'><i class='icon-share share'> </i></a></div>";
                var control = "<a  class='jp-play-me m-r-sm pull-left' style='cursor:pointer' ><i class='icon-control-play text'></i><i class='icon-control-pause text-active'></i></a>";
                for (var i = 0; i < musiclist.length; i++) {
                    var item = "<div class='clear text-ellipsis' id='" + musiclist[i].musicId + "'><span>" + musiclist[i].musicName + "</span><span class='text-muted'>--" + musiclist[i].musicSinger + "</span></div>";
                    innerhtml = innerhtml + "<li class='list-group-item'>"+ tubiao + control + item + "</li>";
                }
                document.getElementById("list").innerHTML = innerhtml;
                document.getElementById("num").innerHTML = fengzi + " / " + fengmu;
            }
            else
            {
                var innerhtml = "";
                var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#'><i class='icon-plus add'> </i></a>&nbsp;&nbsp;<a href='#'><i class='icon-share share'> </i></a></div>";
                var control = "<a  class='jp-play-me m-r-sm pull-left' style='cursor:pointer' ><i class='icon-control-play text'></i><i class='icon-control-pause text-active'></i></a>";
                for (var i = 0; i < musiclist.length; i++) {
                    var item = "<div class='clear text-ellipsis' id='" + musiclist[i].musicId + "'><span>" + musiclist[i].musicName + "</span><span class='text-muted'>--" + musiclist[i].musicSinger + "</span></div>";
                    innerhtml = innerhtml + "<li class='list-group-item'>" + tubiao + control + item + "</li>";
                }
                document.getElementById("list").innerHTML = innerhtml;
                document.getElementById("num").innerHTML = fengzi + " / " + fengmu;
            }
        }

        //乐库分页逻辑及控制
        var itemnum = 12;
        var num = getmusicnum('');
        var fengmu = Math.ceil(num / itemnum);
        var fengzi = 1;
        function nextpage(singerName) {
            if (fengzi < fengmu) {
                musiclist = Getmusic(itemnum * fengzi, itemnum,singerName);
                fengzi = fengzi + 1;
                loadlist(musiclist);
            }
        }
        function prepage(singerName) {
            if (fengzi > 1) {
                fengzi = fengzi - 1;
                musiclist = Getmusic(itemnum * (fengzi - 1), itemnum, singerName);
                loadlist(musiclist);
            }
        }
    </script>
</head>

<body class="">
    <section class="hbox stretch">
        <section class="w-f-md">
            <section class="hbox stretch wrapper no-padder">
                <!-- side content 歌手列表 -->
                <section class="col-sm-2 no-padder">
                    <section class="vbox">
                        <section class="scrollable hover">
                            <ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" id="singerlist"></ul>
                            <!--歌手分页控制-->
                            <div style="background-color: ButtonFace; text-align: center">
                                <button class="btn" onclick="singerprepage()">上一页</button>
                                <span id="nums"></span>
                                <button class="btn" onclick="singernextpage()">下一页</button>
                            </div>
                            <div style="height:55px"></div>
                            <script>
                                var singerlist = getSinger(0, singernums);
                                loadsingerlist(singerlist);
                            </script>
                        </section>
                    </section>
                </section>
                <!-- / side content  歌曲列表-->
                <aside class="col-sm-8 no-padder" id="sidebar">
                    <section class="vbox animated fadeInUp">
                        <section class="scrollable">
                            <!--歌手大头像-->
                            <div class="m-t-n-xxs item pos-rlt bigimage">
                                <div class="top text-right">
                                    <span class="h1 font-thin" id="bigsingername" ></span>
                                    <span class="musicbar animate bg-success bg-empty inline m-r-lg m-t" style="width: 25px; height: 30px">
                                        <span class="bar1 a3 lter"></span>
                                        <span class="bar2 a5 lt"></span>
                                        <span class="bar3 a1 bg"></span>
                                        <span class="bar4 a4 dk"></span>
                                        <span class="bar5 a2 dker"></span>
                                    </span><br /><br />
                                    <div class="pull-right" style="width:650px">
                                        <p class="text-sm text-right" id="bigsingercontent" style="position:relative;right:25px"></p>
                                    </div>
                                </div>
                                <img class="img-responsive" src="images/m43.jpg" alt="...">
                                <div class="bottom gd bg-info wrapper-lg">
                                    <div style="float:right">
                                        <span class="pull-right text-sm" id="volume"  ></span>
                                    </div>
                                </div>
                            </div>
                            <script>$(".bigimage").hide()</script>
                            <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto" id="list"></ul>
                            <!--分页控制-->
                            <div style="background-color: ButtonFace; text-align: center">
                                <button class="btn" onclick="prepage('')" id="btnpre">上一页</button>
                                <span id="num"></span>
                                <button class="btn" onclick="nextpage('')" id="btnnext">下一页</button>
                            </div>
                            <div style="height:55px"></div>
                            <script>
                                var musiclist = Getmusic(0, itemnum,'');
                                loadlist(musiclist);
                            </script>
                        </section>
                    </section>
                </aside>
            </section>
        </section>
    </section>

    <script src="js/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="js/bootstrap.js"></script>
    <script> 
        //点击歌曲
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
                var singerName = $($this.next())[0].innerText.split('--')[1];
                parent.musicstart($($this.next()).attr("id"));
                getsingerItem(singerName)
            }

        });
        //点击歌手
        $(document).on('click', '.clearfix', function (e) {
            var singerName = $(this).attr("id");
            //通过id(singerName)查询该歌手的音乐
            var mlist = Getmusic(0, 12, singerName);
            //通过id(singerName)查询该歌手的音乐数量
            num = getmusicnum(singerName);
            fengmu = Math.ceil(num / itemnum);
            fengzi = 1;
            //调用loadlist函数
            loadlist(mlist);
            //为分页按钮设置绑定事件
            $('#btnpre')[0].onclick = function () { prepage(singerName) };
            $('#btnnext')[0].onclick = function () { nextpage(singerName) };
            //获取singeritem并设置大头像
            getsingerItembig(singerName);
            
        });
        //点击添加按钮
        $(document).on('click', '.add', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            //获取当前用户创建的歌单名称
            var obj = getcreatedsongsheetsinfo();
            var innerhtml = "<div class='radio'><label><input type='radio' name='item' value='0'>我的收藏</label></div>";
            for (i = 0; i < obj.length; i++)
            {
                var pre = "<div class='radio'><label><input type='radio' name='item' value='" + obj[i].songsheetId + "'>";
                var main = obj[i].songsheetName;
                var nex = "</label></div>";
                innerhtml = innerhtml + pre + main + nex;
            }
            document.getElementById('itemlist').innerHTML = innerhtml;
            document.getElementById('list-table').style.display = 'block';
        })
        //点击分享按钮
        $(document).on('click', '.share', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            var host = location.host;
            var url = "http://"+host+"/share.aspx?id=" + checkedmusicid;
            document.getElementById('url').innerHTML = url;
            document.getElementById('urlwindow').style.display = 'block';
        })
    </script>
    
    <div id="list-table" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 30%; height: 300px">
        <div class="h4 font-bold text-left">选择歌单</div>
        <br />
        <div class="form-group" style="overflow-y: auto; height: 180px" id="itemlist">
            <div class="radio"><label><input type="radio" name="item" value="1">我的收藏我的收藏我的收藏</label></div>
        </div>
        <div>
            <button class="btn btn-primary" onclick="add()">&nbsp;&nbsp;添   加&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="cancel('list-table')">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
        </div>
    </div>
    <div id="urlwindow" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 30%; height: 230px">
        <div class="h4 font-bold text-center">生成的分享链接如下</div>
        <br />
        <textarea style="height:100px;width:90%;position:relative;left:5%" class="bg-dark center" id="url">
         </textarea>
        <div style="width:90%;position:relative;left:5%;top:30px" >
            <button class="btn btn-primary pull-left" onclick="copy()">&nbsp;&nbsp;复  制&nbsp;&nbsp;</button>
            <button class="btn btn-primary pull-right" onclick="cancel('urlwindow')">&nbsp;&nbsp;返  回&nbsp;&nbsp;</button>
        </div>
    </div>
</body>
</html>
