<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mylist.aspx.cs" Inherits="mylist" %>

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
        //弹出歌单信息录入模块
        function createlist(obj) { document.getElementById(obj).style.display = 'block'; }
        //关闭歌单信息录入模块
        function cancel(obj) { document.getElementById(obj).style.display = 'none'; }
        //保存创建的歌单
        function save(){
            var name = $("#listname").val();
            var content = $("#listcontent").text();
            var ispublic = $("input[name='ispublic']:checked").val();
            if (name == '') {
                alert("歌单名称不能为空");
            } else if (ispublic == undefined) {
                alert("请选择该歌单是否公开");
            } else {
                $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                    url: 'mylist.aspx/createSongsheet',
                    type: 'post',
                    contentType: "application/json",
                    dataType: 'json',
                    async: false,
                    data: "{'songsheetName':'" + name + "','songsheetContent':'"+content+"','ispublic':"+ispublic+"}", //必须的，为空的话也必须是json字符串
                    success: function (data) {//这边返回的是个对象
                        if (data.d == 0) {
                            alert('歌单创建成功');
                            window.location.href = 'mylist.aspx';
                        }else
                        {
                            alert("error");
                        }
                    }
                });
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
        //查询我收藏的歌单简要
        function getfavoritesongsheetsinfo() {
            var favoritelist;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'mylist.aspx/getFavoriteSongsheets',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    favoritelist = data.d;
                }
            });
            return favoritelist;
        }
        //查询我收藏的歌曲
        function getfavoritedmusic() {
            var favoritedmusic;
            $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                url: 'mylist.aspx/getFavoritedMusic',
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: false,
                data: "{}", //必须的，为空的话也必须是json字符串
                success: function (data) {//这边返回的是个对象
                    favoritedmusic = data.d;
                }
            });
            return favoritedmusic;
        }
        var favflag;
        //加载歌单曲目
        function loadlist(musiclist) {
            var innerhtml = "";
            if (favflag != 'list-group-item songsheetname favlist') {
                var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#' class='m-r-sm'><i class='icon-plus add'></i></a><a href='#' class='m-r-sm delete'><i class='icon-trash'></i></a>&nbsp;&nbsp;<a href='#'><i class='icon-share share'> </i></a></div>";
            }
            else
            {
                var tubiao = " <div class='pull-right m-l' id='tubiao'><a href='#' class='m-r-sm'><i class='icon-plus add'></i></a>&nbsp;&nbsp;<a href='#'><i class='icon-share share'> </i></a></div>";
            }
            var control = "<a  class='jp-play-me m-r-sm pull-left' style='cursor:pointer' ><i class='icon-control-play text'></i><i class='icon-control-pause text-active'></i></a>";
            for (var i = 0; i < musiclist.length; i++) {
                var item = "<div class='clear text-ellipsis' id='" + musiclist[i].musicId + "'><span>" + musiclist[i].musicName + "</span><span class='text-muted'>--" + musiclist[i].musicSinger + "</span></div>";
                innerhtml = innerhtml + "<li class='list-group-item'>" + tubiao + control + item + "</li>";
            }
            document.getElementById("list").innerHTML = innerhtml;
        }

        //选中的歌曲添加至歌单
        var checkedmusicid;
        var songsheetid;
        var songsheetcontent;
        var songsheetname;
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
                        cancel('list-table1');
                    } else {
                        alert("error");
                    }
                }
            });
        }
        function cancel1(obj) { document.getElementById(obj).style.display = 'none'; }

        //删除歌单中的歌曲
        function deleteMusic(musicid, songsheetid) {
            if (songsheetid == 0)
            {

                $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                    url: 'mylist.aspx/deletefavMusic',
                    type: 'post',
                    contentType: "application/json",
                    dataType: 'json',
                    async: false,
                    data: "{'musicId':'" + musicid + "'}", //必须的，为空的话也必须是json字符串
                    success: function (data) {//这边返回的是个对象
                        if (data.d != 0) {
                            alert('删除歌曲成功');
                            //重新加载我收藏的歌曲
                            var favlist = getfavoritedmusic()
                            songsheetid = '0';
                            if (favlist != null) {
                                loadlist(favlist);
                            }

                        } else {
                            alert("error");
                        }
                    }
                });
            }
            else
            {
                $.ajax({ //调用的静态方法，所以下面必须参数按照下面来
                    url: 'mylist.aspx/deleteMusic',
                    type: 'post',
                    contentType: "application/json",
                    dataType: 'json',
                    async: false,
                    data: "{'musicId':'" + musicid + "','songsheetId':" + songsheetid + "}", //必须的，为空的话也必须是json字符串
                    success: function (data) {//这边返回的是个对象
                        if (data.d != 0) {
                            alert('删除歌曲成功');
                            //重新加载该歌单
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
                                loadlist(musiclist);
                            }
                        } else {
                            alert("error");
                        }
                    }
                });
            }
        }
    </script>
</head>

<body class="">
    <section class="hbox stretch">
        <section class="w-f-md">
            <section class="hbox stretch wrapper no-padder">
                <!-- side content 歌单分类列表 -->
                <section class="col-sm-2 no-padder">
                    <section class="vbox">
                        <section class="scrollable hover">
                            <ul></ul><div onclick="createlist('list-table')" style="cursor:pointer">&nbsp;&nbsp;<i class="icon-plus h4">&nbsp;创建歌单</i></div><ul></ul>
                            <h4 id="myfavoritemusic" class="ul block font-bold text-u-c" style="cursor:pointer">&nbsp;&nbsp;我收藏的音乐</h4>
                            <ul class="myfavoritemusic list-group list-group-lg no-bg auto m-b-none m-t-n-xxs">
                                <li class="list-group-item myfav" style="cursor:pointer"><i class="icon-music-tone"></i>&nbsp;&nbsp;我的收藏</li>
                            </ul>
                            <h4 id="mycreatelist" class="ul block font-bold text-u-c" style="cursor:pointer">&nbsp;&nbsp;我创建的歌单</h4>
                            <ul class="mycreatelist list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" id="createdlist">
                                <script>//加载创建的歌单名称
                                    var createdlist = getcreatedsongsheetsinfo();
                                    if (createdlist == null) {}
                                    else
                                    {
                                        var createdinnerhtml = "";
                                        for (i = 0; i < createdlist.length; i++) {
                                            createdinnerhtml = createdinnerhtml + "<li class='list-group-item songsheetname'id='" + createdlist[i].songsheetId + "' songsheetcontent='" + createdlist[i].songsheetContent + "'><i class='icon-music-tone'> </i> <span style='cursor:pointer'>" + createdlist[i].songsheetName + "</span> <i class=' icon-trash pull-right setNovalid' style='cursor:pointer'></i></li>";
                                        }
                                        document.getElementById("createdlist").innerHTML = createdinnerhtml;
                                    }
                                </script>
                            </ul>
                            <h4 id="myfavoritelist" class="ul block font-bold text-u-c" style="cursor:pointer">&nbsp;&nbsp;我收藏的歌单</h4>
                            <ul class="myfavoritelist list-group list-group-lg no-bg auto m-b-none m-t-n-xxs" id="favoritelist">
                                <script>//加载收藏的歌单名称
                                    var favoritelist = getfavoritesongsheetsinfo();
                                    if (favoritelist == null) {}
                                    else
                                    {
                                        var favoriteinnerhtml = "";
                                        for (i = 0; i < favoritelist.length; i++) {
                                            favoriteinnerhtml = favoriteinnerhtml + "<li class='list-group-item songsheetname favlist'id='" + favoritelist[i].songsheetId + "'  style='cursor:pointer'><i class='icon-music-tone'></i>&nbsp;&nbsp;" + favoritelist[i].songsheetName + "<i class=' icon-trash pull-right deletefavsheet' style='cursor:pointer'></i></li>";
                                        }
                                        document.getElementById("favoritelist").innerHTML = favoriteinnerhtml;
                                    }
                                </script>
                            </ul>

                            <div style="height:55px"></div>
                        </section>
                    </section>
                </section>
                <!-- / side content  歌曲列表-->
                <div style="float:left;height:100%;width:1px;background-color:black"></div>
                <aside class="col-sm-10 no-padder" id="sidebar">
                    
                    <div>
                        <div class=" padder-md padder-v ul block font-bold text-u-c h4" id="show-name">我的收藏&nbsp;&nbsp;&nbsp;&nbsp;<i class="icon-playlist h5 playlist" style="cursor:pointer"></i></div>
                        <div class="padder-md ">
                            <p class="text-sm" id="show-content">该歌单是你的个人收藏歌单，由您收藏的歌曲组成。</p>
                        </div>
                        <div class="bg-dark" style="height:1px;width:100%"></div>
                    </div>
                    <section class="vbox animated fadeInUp">
                        <section class="scrollable">
                            <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto" id="list"></ul>
                            <div style="height:150px"></div>
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
        //加载我的收藏歌曲
        var favlist = getfavoritedmusic()
        songsheetid = '0';
        if (favlist != null) {
            loadlist(favlist);
        }
        var flag = 0;var flag1 = 0;var flag2 = 0;
        //点击ul
        $(document).on('click', '.ul', function (e) {
            var clickid=$(e.target).attr("id");
            if (clickid == 'myfavoritemusic') {if (flag == 0) {$(".myfavoritemusic").children().hide(); flag = 1;}
                else {$(".myfavoritemusic").children().show();flag = 0;} }
            else if (clickid == 'mycreatelist') {
                //展开或者折叠我创建的歌单li
                if (flag1 == 0) {
                    $(".mycreatelist").children().hide();
                    flag1 = 1;
                }
                else {
                    $(".mycreatelist").children().show();
                    flag1 = 0;
                }
                 
            }
            else if ((clickid == 'myfavoritelist'))
            {
                //展开或者折叠我收藏的歌单li
                if (flag2 == 0) {
                    $(".myfavoritelist").children().hide();
                    flag2 = 1;
                }
                else {
                    $(".myfavoritelist").children().show();
                    flag2 = 0;
                }
            }
        })
        //点击我的收藏
        $(document).on('click', '.myfav', function (e) {
            songsheetid = '0';
            document.getElementById("show-name").innerHTML = "我的收藏&nbsp;&nbsp;&nbsp;&nbsp;<i class='icon-playlist h5 playlist' style='cursor:pointer'></i>";
            $("#show-content").text("该歌单是你的个人收藏歌单，由您收藏的歌曲组成。");
            var list=getfavoritedmusic();
            if (list != null) {
                loadlist(list);
            }else
            {
                document.getElementById("list").innerHTML = "";
            }
        })
        //点击歌单
        $(document).on('click', '.songsheetname', function (e) { 
            songsheetid = $(e.target).attr("id");
            songsheetname = $(e.target)[0].innerText;
            songsheetcontent = $(e.target).attr("songsheetContent");
            if (songsheetid == undefined) {
                songsheetid = $(e.target).parent().attr("id");
                songsheetname = $(e.target).parent()[0].innerText;
                songsheetcontent = $(e.target).parent().attr("songsheetContent");
            }
            if (songsheetid == undefined) {}
            else {
                //设置右侧歌单信息
                document.getElementById("show-name").innerHTML = songsheetname + "&nbsp;&nbsp;&nbsp;&nbsp;<i class='icon-playlist h5 playlist' style='cursor:pointer'></i>";
                $("#show-content").text(songsheetcontent);
                favflag = $(e.target).attr("class");
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
                    loadlist(musiclist);
                }
            }
        })
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
        //点击播放歌单按钮
        $(document).on('click', '.playlist', function (e) {
            var list = [];
            var musiclist;
            if (songsheetid == 0) {
                musiclist = getfavoritedmusic();
                for (i = 0; i < musiclist.length; i++)
                {
                    var jsonitem = {};
                    jsonitem.musicid = musiclist[i].musicId;
                    jsonitem.title = musiclist[i].musicName;
                    jsonitem.artist = musiclist[i].musicSinger;
                    jsonitem.mp3 = musiclist[i].musicPath;
                    list.push(jsonitem);
                }
            }
            else
            {
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
                    jsonitem.musicid = musiclist[i].musicId;
                    jsonitem.title = musiclist[i].musicName;
                    jsonitem.artist = musiclist[i].musicSinger;
                    jsonitem.mp3 = musiclist[i].musicPath;
                    list.push(jsonitem);
                }
            }
            parent.musicliststart(list,songsheetid);
        });
        //点击添加按钮
        $(document).on('click', '.add', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            //获取当前用户创建的歌单名称
            var obj = getcreatedsongsheetsinfo();
            var innerhtml = "";
            if (songsheetid != 0)
            {
                innerhtml = "<div class='radio'><label><input type='radio' name='item' value='0'>我的收藏</label></div>";
            }
            for (i = 0; i < obj.length; i++) {
                if (songsheetid == obj[i].songsheetId) { }
                else
                {
                    var pre = "<div class='radio'><label><input type='radio' name='item' value='" + obj[i].songsheetId + "'>";
                    var main = obj[i].songsheetName;
                    var nex = "</label></div>";
                    innerhtml = innerhtml + pre + main + nex;
                }
            }
            document.getElementById('itemlist').innerHTML = innerhtml;
            document.getElementById('list-table1').style.display = 'block';
        })
        //点击删除歌曲按钮
        $(document).on('click', '.delete', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            deleteMusic(checkedmusicid, songsheetid);
        })
        //点击删除创建的歌单按钮
        $(document).on('click', '.setNovalid', function (e) {
            songsheetid = $(e.target).parent().attr("id");
            $.ajax({
                url: "mylist.aspx/setNoValid",
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: true,
                data: "{'songsheetId':"+songsheetid+"}",
                success: function (data) {
                    alert('删除歌单成功');
                    location.reload();
                },
                error:function(e){
                    alert("error");
                }
            });
        })
        //点击删除收藏的歌单
        $(document).on('click', '.deletefavsheet', function (e) {
            songsheetid = $(e.target).parent().attr("id");
            $.ajax({
                url: "mylist.aspx/deleteFavsheet",
                type: 'post',
                contentType: "application/json",
                dataType: 'json',
                async: true,
                data: "{'songsheetId':'" + songsheetid + "'}",
                success: function (data) {
                    alert('取消收藏成功');
                    location.reload();
                },
                error: function (e) {
                    alert("error");
                }
            });
        })
        //点击分享按钮
        $(document).on('click', '.share', function (e) {
            checkedmusicid = $(e.target).parent().parent().next().next().attr("id");
            var host = location.host;
            var url = "http://" + host + "/share.aspx?id=" + checkedmusicid;
            document.getElementById('url').innerHTML = url;
            document.getElementById('urlwindow').style.display = 'block';
        })
    </script>
    <div id="list-table" class="bg-white-only table-bordered padder-v" style="display: none; position: absolute; left: 25%; top: 15%; width: 50%; height: 400px;">
        <div class="h4 font-bold text-center">填写歌单信息</div>
        <br />
        <form class="form-horizontal" runat="server" id="form">
            <div class="form-group">
                <label class="col-sm-3 control-label">歌单名称</label>
                <div class="col-sm-7">
                    <input class="input-s datepicker-input form-control" type="text" id="listname">
                </div>
            </div>
            <div class="line line-dashed b-b line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">歌单描述</label>
                <div class="col-sm-7">
                    <div class="form-control" style="overflow: scroll; height: 150px; max-height: 70px" contenteditable="true" id="listcontent"></div>
                </div>
            </div>
            <div class="line line-dashed b-b line-lg pull-in"></div>
            <div class="form-group">
                <label class="col-sm-3 control-label">是否公开</label>
                <div class="col-sm-7">
                    <div class="radio">
                        <label>
                            <input type="radio" name="ispublic" value="1">是(该歌单可以被其他用户看到并收藏)</label>
                    </div>
                    <div class="radio">
                        <label>
                            <input type="radio" name="ispublic" value="0">否（该歌单仅自己可见）</label>
                    </div>
                </div>
            </div>
        </form>
        <div class="col-sm-9 col-sm-offset-2">
            <button class="btn btn-primary" onclick="save()">&nbsp;&nbsp;确   定&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="cancel('list-table')">&nbsp;&nbsp;返   回&nbsp;&nbsp;</button>
        </div>
    </div>
    <div id="list-table1" class="bg-white-only table-bordered padder-md padder-v" style="display: none; position: absolute; left: 35%; top: 15%; width: 30%; height: 300px">
        <div class="h4 font-bold text-left">选择歌单</div>
        <br />
        <div class="form-group" style="overflow-y: auto; height: 180px" id="itemlist">
            <div class="radio"><label><input type="radio" name="item" value="1">我的收藏我的收藏我的收藏</label></div>
        </div>
        <div>
            <button class="btn btn-primary" onclick="add()">&nbsp;&nbsp;添   加&nbsp;&nbsp;</button>
            <button class="btn btn-primary" onclick="cancel1('list-table1')">&nbsp;&nbsp;取   消&nbsp;&nbsp;</button>
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
