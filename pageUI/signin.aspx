<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signin.aspx.cs" Inherits="signin" %>

<!DOCTYPE html>

<!DOCTYPE html>
<html lang="en" class="app">
<head>  
  <meta charset="utf-8" />
  <title>For Music | Web Application</title>
  <meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="js/jPlayer/jplayer.flat.css" type="text/css" />
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />  

</head>
<body class="bg-info dker">
<form id="form1" runat="server">
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp">    
    <div class="container aside-xl">
      <a class="navbar-brand block" href="#"><span class="h1 font-bold">For Music</span></a>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>Sign in to get in touch</strong>
        </header>
          <div class="form-group">
              <asp:TextBox ID="email" runat="server"  placeholder="邮 箱" class="form-control rounded input-lg text-center no-border" OnTextChanged="Email_TextChanged"></asp:TextBox>
          </div>
          <div class="form-group">
              <asp:TextBox ID="password" runat="server"  placeholder="密 码" class="form-control rounded input-lg text-center no-border" OnTextChanged="password_TextChanged" TextMode="Password"></asp:TextBox>
          </div>
            <asp:Button ID="login" runat="server" Text="登 陆" class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded" OnClick="signin_Click" />    
          <div class="line line-dashed"></div>
          <p class="text-muted text-center"><small>已经有账号?</small></p>
          <a href="signup.aspx" class="btn btn-lg btn-info btn-block rounded">免费注册一个账号</a>
      </section> 
    </div>
  </section>
  <!-- footer -->
  <footer id="footer">
    <div class="text-center padder">
      <p>
        <small>西安电子科技大学<br>&copy; 2019</small>
      </p>
    </div>
  </footer>
  <!-- / footer -->
  <script src="js/jquery.min.js"></script>
  <!-- Bootstrap -->
  <script src="js/bootstrap.js"></script>
  <!-- App -->
  <script src="js/app.js"></script>  
  <script src="js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/app.plugin.js"></script>
  <script type="text/javascript" src="js/jPlayer/jquery.jplayer.min.js"></script>
  <script type="text/javascript" src="js/jPlayer/add-on/jplayer.playlist.min.js"></script>
  <script type="text/javascript" src="js/jPlayer/demo.js"></script>
</form>
</body>
</html>
