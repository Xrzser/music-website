<%@ Page Language="C#" AutoEventWireup="true" CodeFile="inputuserinfo.aspx.cs" Inherits="inputuserinfo" %>

<!DOCTYPE html>
<html lang="zh" class="app">
<head>  
  <meta charset="utf-8" />
  <title>For Music| 个人信息录入</title>
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />  
  <script src="js/jquery.min.js"></script>
  <script>
      //通过name获取checkbox选中的值
      function fun(name) {
          obj = document.getElementsByName(name);
          check_val = [];
          for (k in obj) {
              if (obj[k].checked) {
                  check_val.push(obj[k].value);
              }
          }
          if (check_val.length == 0) {
              return "";
          }
          else {
              return check_val.toString() + ",";
          }
      }
      function save() {
          var location = $("input[name='location']").val();
          var signature = $("input[name='signature']").val();
          var singer = $("input[name='singer']").val();
          var sex = $("input[name='sex']:checked").val();

          var rhythm = fun('rhythm');
          var emotion = fun("emotion");
          var type = fun('type');
          var language = fun("language");
          console.log("{'location':'" + location + "','signature':'" + signature + "','singer':'" + singer + "','sex':" + sex + ",'rhythm':" + rhythm + ",'emotion':" + emotion + ",'type':" + type + ",'language':" + language + "}");
          $.ajax({
              url: 'inputuserinfo.aspx/setUserInfo',
              type: 'post',
              contentType: "application/json",
              dataType: 'json',
              data: "{'location':'" + location + "','signature':'" + signature + "','singer':'" + singer + "','sex':" + sex + ",'rhythm':'" + rhythm +"','emotion':'"+emotion+"','type':'"+type+"','language':'"+language+"'}",
              async: false,
              success: function (data) {//这边返回的是个对象
                  alert("个人信息保存成功");
                  window.location.href = "signin.aspx";
              },
              error: function (err) {
                  alert('err');
              }
          })
      }
      function skip() {
          window.location.href = "signin.aspx";
      }
      function showimage() {
          $('#title').attr('src', 'images/portrait/p<%=Session["id"] %>.jpg');
          $('#title').css('display', 'block');
          $('#pp').css('display','none');
          $('#uploadportrait').css('display', 'none');
          $('#upload').val('更新')
      }
      function openfile() {
          $('#uploadportrait').click();
      }
  </script>
</head>
<body class="">
  <section class="vbox">
    <section>
      <section class="hbox stretch">
        <section id="content">
          <section class="hbox stretch">
            <!-- 时间线 -->
            <aside class="col-sm-2 no-padder">
              <section class="vbox">
                <section class="scrollable wrapper">
                  <div class="timeline">
                    <article class="timeline-item active">
                        <div class="timeline-caption">
                          <div class="panel bg-primary lt no-borders">
                            <div class="panel-body">
                              <span class="timeline-date">For Music</span>
                              <div class="text-sm">为什么需要您填写下面数据</div>
                              <h5>...</h5>
                            </div>
                          </div>
                        </div>
                    </article>
                    <article class="timeline-item">
                        <div class="timeline-caption">
                          <div class="panel panel-default">
                            <div class="panel-body">
                              <span class="arrow left"></span>
                              <span class="timeline-icon"><i class="icon-settings time-icon bg-primary"></i></span>
                                <span class="timeline-date">设置个人主页</span>
                               <p>为您展示不一样的自己。</p>
                            </div>       
                          </div>
                        </div>
                    </article>
                    <article class="timeline-item alt">
                        <div class="timeline-caption">                
                          <div class="panel panel-default">
                            <div class="panel-body">
                              <span class="arrow right"></span>
                              <span class="timeline-icon"><i class="fa fa-male time-icon bg-success"></i></span>
                              <span class="timeline-date">生成用户画像</span>
                              <div class="text-sm">根据您的个人信息，分析你的专属画像</div>
                              
                            </div>
                          </div>
                        </div>
                    </article>          
                    <article class="timeline-item">
                        <div class="timeline-caption">                
                          <div class="panel panel-default">
                            <div class="panel-body">
                              <span class="arrow left"></span>
                              <span class="timeline-icon"><i class="icon-earphones time-icon bg-dark"></i></span>
                              <span class="timeline-date">专属音乐推荐</span>
                              <div class="text-sm">根据你的个人画像，为你推荐专属于您的动听音乐</div>
                            </div>
                          </div>
                        </div>
                    </article>
                    <article class="timeline-item alt">
                        <div class="timeline-caption">                
                          <div class="panel panel-default">
                            <div class="panel-body">
                              <span class="arrow right"></span>
                              <span class="timeline-icon"><i class="fa fa-file-text time-icon bg-info"></i></span>
                              <span class="timeline-date">用户体验</span>
                              <h5>                                
                                For Music
                              </h5>
                              <p>该平台基于B/S开发，将持续不断的为您带来更多好用，惊艳的功能。</p>
                              <p>更多功能，敬请期待，感谢我们的相遇。</p>
                            </div>
                          </div>
                        </div>
                    </article>
                  </div>
                </section>
              </section>
            </aside>  
            <!-- 录入信息 -->
            <aside class="col-sm-8 no-padder" id="aside">
                <section class="vbox">
                    <section class="scrollable wrapper">
                        <div class="wrapper">
                <h4 class="m-t-none">填写您的个人信息</h4>
                <div style="height:30px"></div>
                <form runat="server">
                    <div class="form-group">
                      <div>
                          <image style=" height: 100px; width: 100px;cursor:pointer;display:none" id="title" onclick="openfile()"></image>
                      </div>
                      <label id="pp">请上传您的头像</label>
                      <asp:FileUpload ID="uploadportrait" runat="server"/>
                      <asp:Button ID="upload" runat="server" Text="上传" OnClick="upload_Click" CssClass="btn-primary"/>
                    </div>
                </form>
                <form id="form1" >
                  <div class="form-group">
                    <label>地点</label>
                    <input type="text" placeholder="例如（西安，中国）" class="input-sm form-control" name="location">
                  </div>
                  <div class="form-group">
                    <label>个性签名 </label>
                    <input type="text" placeholder="一段话展示你的个性" class="datepicker input-sm form-control" name="signature">
                  </div>
                  <div class="form-group">
                    <label>喜欢的歌手</label>
                    <input type="text" placeholder="若填写多个请用逗号隔开" class="input-sm form-control" name="singer">
                  </div>
                  <div class="form-group">
                      <label>性别：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="man" type="radio" checked="checked" name="sex" value="1"/>男
                         &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="woman" type="radio" name="sex" value="0"/>女
                  </div>
                  <div class="form-group">
                      <label>音乐节奏：&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="kuai" type="checkbox"  name="rhythm" value="0"/>快
                         &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="man" type="checkbox" name="rhythm" value="1"/>慢
                  </div>
                  <div class="form-group">
                      <label>音乐表达：&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="gaoxing" type="checkbox" checked="checked" name="emotion" value="0"/>高兴
                         &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="shanggan" type="checkbox" name="emotion" value="1"/>伤感
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="huaijiu" type="checkbox" name="emotion" value="2"/>怀旧
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="aiqing" type="checkbox" name="emotion" value="3"/>爱情
                  </div>
                  <div class="form-group">
                      <label>音乐类型：&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="gaoxing" type="checkbox" checked="checked" name="type" value="0"/>流行
                         &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="shanggan" type="checkbox" name="type" value="1"/>纯音乐
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="huaijiu" type="checkbox" name="type" value="2"/>民谣
                  </div>
                  <div class="form-group">
                      <label>音乐语言：&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <input id="zh" type="checkbox" checked="checked" name="language" value="0"/>中文
                         &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="en" type="checkbox" name="language" value="1"/>英文
                         &nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="ri" type="checkbox" name="language" value="2"/>日语
                  </div>
                  <input type="button" value="保存" onclick="save()">&nbsp;&nbsp;&nbsp;<input type="button"  value="跳过" onclick="skip()">
                </form>
              </div>
            </section>
           </section> 
            </aside>           
          </section>
        </section>
      </section>
    </section>    
  </section>
</body>
</html>
