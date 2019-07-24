<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchres.aspx.cs" Inherits="searchres" %>

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
        var songsheetid;
        //根据歌手名查询歌手信息
        function getsingerItem(singerName) {
            var singerItem;
            $.ajax({
                url: 'musiclist.aspx/getSingerItem',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'singerName':'" + singerName + "'}",
                async: false,
                success: function (data) {//这边返回的是个对象
                    singerItem = data.d;
                },
                error: function (err) {
                    alert('err');
                }
            });
            return singerItem;
        }
        var checkedmusicid;
        //获取父页面输入的关键字
        var keywords = $(parent.document.getElementById('inputkey')).val();
        if (keywords.match(/^[ ]*$/)) {
            alert("请输入有效的关键字");
        }
        else
        {
            var reslist;
            var songsheetlist;
            //通过关键字获取搜索结果
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'searchres.aspx/searchMusic',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'offset':" + 0 + ",'rows':" + 12 + ",'keywords':'" + keywords + "'}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    reslist = data.d;
                }
            });
            //通过关键字获取搜索到的歌单
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'searchres.aspx/serarchSongsheet',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'offset':" + 0 + ",'rows':" + 12 + ",'keywords':'" + keywords + "'}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    songsheetlist = data.d;
                }
            });
        }
        //获得搜索结果的分页数据
        function Getmusic(offset, rows, keywords) {
            var reslist;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'searchres.aspx/searchMusic',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'offset':" + offset + ",'rows':" + rows + ",'keywords':'" + keywords + "'}",
                async: false,
                success: function (data) {//这边返回的是个对象
                    reslist = data.d;
                },
                error: function (err) {
                    alert('err');
                }
            });
            return reslist;
        }
        //获取搜索到的歌单分页数据
        function getSongsheet(offset, rows, keywords) {
            var songsheetlist;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'searchres.aspx/serarchSongsheet',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'offset':" + offset + ",'rows':" + rows + ",'keywords':'" + keywords + "'}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    songsheetlist = data.d;
                    console.log(data.d);
                },
                error:function(err){
                    alert(err);
                }
            });
            return songsheetlist;
        }
        //获取乐库条目总数
        function getresnum(keywords) {
            var num;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'searchres.aspx/getresnum',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'keywords':'" + keywords + "'}",
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
        //获取搜索到的歌单总条目数
        function getsongsheetnum(keywords) {
            var num;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'searchres.aspx/getSongsheetnum',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                data: "{'keywords':'" + keywords + "'}",
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
        //加载搜索结果列表
        function loadlist(musiclist) {
            var innerhtml = "";
            var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#'><i class='icon-plus add'></i></a>&nbsp;&nbsp;<a href='#'><i class='icon-share share'> </i></a></div>";
            var control = "<a  class='jp-play-me m-r-sm pull-left' style='cursor:pointer' ><i class='icon-control-play text'></i><i class='icon-control-pause text-active'></i></a>";
            for (var i = 0; i < musiclist.length; i++) {
                var item = "<div class='clear text-ellipsis' id='" + musiclist[i].musicId + "'><span>" + musiclist[i].musicName + "</span><span class='text-muted'>--" + musiclist[i].musicSinger + "</span></div>";
                innerhtml = innerhtml + "<li class='list-group-item'>" + tubiao + control + item + "</li>";
            }
            document.getElementById("list").innerHTML = innerhtml;
            document.getElementById("num").innerHTML = fengzi + " / " + fengmu;
        }
        //加载搜索到的歌单列表
        function loadsongsheet(songsheetlist) {
            var innerhtml = "";
            var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#'><i class='icon-heart fav'></i></a></div>";
            for (var i = 0; i < songsheetlist.length; i++) {
                var item = "<div class='clear text-ellipsis songsheetclass' style='cursor:pointer' id='" + songsheetlist[i].songsheetId + "' songsheetcontentvalue='" + songsheetlist[i].songsheetContent + "'><i class='icon-music-tone'> </i><span>" + songsheetlist[i].songsheetName + "</span></div>";
                innerhtml = innerhtml + "<li class='list-group-item'>" + tubiao + item + "</li>";
            }
            document.getElementById("list1").innerHTML = innerhtml;
            document.getElementById("num1").innerHTML = fengzi1 + " / " + fengmu1;
        }
        //点击歌单名称加载歌单
        function actloadlist(musiclist) {
            var innerhtml = "";
            var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#'><i class='icon-plus add'></i></a>&nbsp;&nbsp;<a href='#'><i class='icon-share share'> </i></a></div>";
            var control = "<a  class='jp-play-me m-r-sm pull-left' style='cursor:pointer' ><i class='icon-control-play text'></i><i class='icon-control-pause text-active'></i></a>";
            for (var i = 0; i < musiclist.length; i++) {
                var item = "<div class='clear text-ellipsis' id='" + musiclist[i].musicId + "'><span>" + musiclist[i].musicName + "</span><span class='text-muted'>--" + musiclist[i].musicSinger + "</span></div>";
                innerhtml = innerhtml + "<li class='list-group-item'>" + tubiao + control + item + "</li>";
            }
            document.getElementById("list").innerHTML = innerhtml;
            document.getElementById("ctrol2").innerHTML = "";
        }
        //搜索结果分页逻辑及控制
        var itemnum = 12;
        var num = getresnum(keywords);
        var fengmu = Math.ceil(num / itemnum);
        var fengzi = 1;
        function nextpage(singerName) {
            if (fengzi < fengmu) {
                musiclist = Getmusic(itemnum * fengzi, itemnum, keywords);
                fengzi = fengzi + 1;
                loadlist(musiclist);
            }
        }
        function prepage(singerName) {
            if (fengzi > 1) {
                fengzi = fengzi - 1;
                musiclist = Getmusic(itemnum * (fengzi - 1), itemnum, keywords);
                loadlist(musiclist);
            }
        }
        //搜索结果分页逻辑及控制1
        var itemnum1 = 12;
        var num1 = getsongsheetnum(keywords);
        var fengmu1 = Math.ceil(num1 / itemnum1);
        var fengzi1 = 1;
        function nextpage1() {
            if (fengzi1 < fengmu1) {
                songsheetlist = getSongsheet(itemnum1 * fengzi1, itemnum1, keywords);
                fengzi1 = fengzi1 + 1;
                loadsongsheet(songsheetlist);
            }
        }
        function prepage1() {
            if (fengzi1 > 1) {
                fengzi1 = fengzi1 - 1;
                songsheetlist = getSongsheet(itemnum1 * (fengzi1 - 1), itemnum1, keywords);
                loadsongsheet(songsheetlist);
            }
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
    </script>
</head>

<body class="">
    <section class="hbox stretch">
        <section class="w-f-md">
            <section class="hbox stretch wrapper no-padder">
                <aside class="col-sm-3 no-padder" id="songsheetres">
                    <div style="height: 60px; width: 100%;border-bottom:1px solid black" class=" padder-v ul block font-bold text-u-c h4">&nbsp;搜索到的歌单</div>
                    <section class="vbox animated fadeInUp">        
                        <section class="scrollable">
                            <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto" id="list1">
                            </ul>
                            <!--分页控制-->
                            <div style="background-color: ButtonFace; text-align: center; position: relative; bottom: 0">
                                <button class="btn" onclick="prepage1('')" id="btnpre1">上一页</button>
                                <span id="num1"></span>
                                <button class="btn" onclick="nextpage1('')" id="btnnext1">下一页</button>
                            </div>
                            <div style="height: 108px"></div>
                            <script>loadsongsheet(songsheetlist);</script>
                        </section>
                    </section>
                </aside>
                <div style="width:1px;height:100%;background-color:black"></div>
                <!-- / side content  歌曲列表-->
                <aside class="col-sm-9 no-padder" id="sidebar">
                    <div style="height: 60px; width: 100%; border-bottom: 1px solid black;padding-left:10px" class=" padder-v ul block font-bold text-u-c h4">
                        <p id="show-name">搜索到的歌曲</p>
                        <p class="text-xs text-dark-lter" id="contenttext">下面是根据您输入的关键词得到的相关歌曲</p>
                    </div>
                    
                    <section class="vbox animated fadeInUp" style="margin-left:1px">    
                        <section class="scrollable">
                            <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto" id="list"></ul>
                            <!--分页控制-->
                            <div style="background-color: ButtonFace; text-align: center" id="ctrol2">
                                <button class="btn" onclick="prepage('')" id="btnpre">上一页</button>
                                <span id="num"></span>
                                <button class="btn" onclick="nextpage('')" id="btnnext">下一页</button>
                            </div>
                            <div style="height: 108px"></div>
                            <script>
                                loadlist(reslist);
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
                var singeritem = getsingerItem(singerName)
                //设置播放组件中的歌手头像
                if (singeritem != null) {
                    parent.setSingerImage(singeritem.singerImage);
                    //设置播放组件的歌手信息
                    $("#span-singername", window.parent.document).text(singeritem.singerName);
                    $("#small-singercontent", window.parent.document).text(singeritem.singerContent);
                }
                else {
                    parent.setSingerImage("/images/default/singer/singer.jpg");
                    //设置播放组件的歌手信息
                    $("#span-singername", window.parent.document).text("");
                    $("#small-singercontent", window.parent.document).text("系统暂无该歌手信息");
                }
            }

        });
        //点击添加按钮
        $(document).on('click', '.add', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            //获取当前用户创建的歌单名称
            var obj = getcreatedsongsheetsinfo();
            var innerhtml = "<div class='radio'><label><input type='radio' name='item' value='0'>我的收藏</label></div>";
            for (i = 0; i < obj.length; i++) {
                var pre = "<div class='radio'><label><input type='radio' name='item' value='" + obj[i].songsheetId + "'>";
                var main = obj[i].songsheetName;
                var nex = "</label></div>";
                innerhtml = innerhtml + pre + main + nex;
            }
            document.getElementById('itemlist').innerHTML = innerhtml;
            document.getElementById('list-table').style.display = 'block';
        })
        //点击收藏歌单按钮
        $(document).on('click', '.fav', function (e) {
            var songsheetId = $(e.target).parent().parent().next().attr("id");
            if (confirm("你确定要收藏该歌单吗？")) {
                $.ajax({
                    url: 'searchres.aspx/favSongsheet',
                    type: 'post',
                    contentType: "application/json",
                    dataType: 'json',
                    data: "{'songsheetId':'"+songsheetId+"'}",
                    async: true,
                    success: function (data) {//这边返回的是个对象
                        if (data.d == 0) {
                            alert('你已经收藏过该歌单');
                        }
                        else {
                            alert("收藏成功");
                        } 
                    },
                    error: function (err) {
                        alert('收藏失败');
                    }
                });
            }
            else { }
        })
        //点击搜索出来的歌单
        $(document).on('click', '.songsheetclass', function (e) {
            var songsheetname;
            var songsheetcontent;
            
            if ($(e.target).attr("id") == undefined) {
                songsheetid = $(e.target).parent().attr("id");
                songsheetname = $(e.target).parent().text();
                songsheetcontent = $(e.target).parent().attr("songsheetcontentvalue");
            }
            else
            {
                songsheetid = $(e.target).attr("id");
                songsheetname = $(e.target).text();
                songsheetcontent = $(e.target).attr("songsheetcontentvalue");
            }
            document.getElementById("show-name").innerHTML = songsheetname + "&nbsp;&nbsp;&nbsp;&nbsp;<i class='icon-playlist h5 playlist' style='cursor:pointer'></i>";
            document.getElementById("contenttext").innerHTML = songsheetcontent;
            //根据songsheetid进行展示
            var musiclist;
            $.ajax({
                url: 'mylist.aspx/getmusiclistBysongsheetId',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{'songsheetid':" + songsheetid + "}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    musiclist = data.d;
                }
            });
            if (musiclist == null) {
                document.getElementById("list").innerHTML = "";
            }
            else {
                actloadlist(musiclist);
            }
        })
        //点击歌单播放图标
        $(document).on('click', '.playlist', function (e) {
            var list = [];
            var musiclist;
            if (songsheetid == 0) {
                musiclist = getfavoritedmusic();
                for (i = 0; i < musiclist.length; i++) {
                    var jsonitem = {};
                    jsonitem.title = musiclist[i].musicName;
                    jsonitem.artist = musiclist[i].musicSinger;
                    jsonitem.mp3 = musiclist[i].musicPath;
                    list.push(jsonitem);
                }
            }
            else {
                $.ajax({
                    url: 'mylist.aspx/getmusiclistBysongsheetId',
                    type: 'post',
                    contentType: "application/json",
                    dataType: 'json',
                    async: false,
                    data: "{'songsheetid':" + songsheetid + "}", //必须的，为空的话也必须是json字符串
                    success: function (data) {//这边返回的是个对象
                        musiclist = data.d;
                    }
                });
                for (i = 0; i < musiclist.length; i++) {
                    var jsonitem = {};
                    jsonitem.title = musiclist[i].musicName;
                    jsonitem.artist = musiclist[i].musicSinger;
                    jsonitem.mp3 = musiclist[i].musicPath;
                    list.push(jsonitem);
                }
            }
            parent.musicliststart(list);
        });
        //点击分享按钮
        $(document).on('click', '.share', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            var host = location.host;
            var url = "http://" + host + "/share.aspx?id=" + checkedmusicid;
            document.getElementById('url').innerHTML = url;
            document.getElementById('urlwindow').style.display = 'block';
        })
    </script>
    <div id="list-table" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 30%; height: 300px">
        <div class="h4 font-bold text-left">选择歌单</div>
        <br />
        <div class="form-group" style="overflow-y: auto; height: 180px" id="itemlist">
            <div class="radio">
                <label>
                    <input type="radio" name="item" value="1"></label></div>
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
