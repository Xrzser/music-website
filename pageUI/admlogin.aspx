<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admlogin.aspx.cs" Inherits="admlogin" %>

<!DOCTYPE html>
<html lang="en" class="app">
<head>  
  <meta charset="utf-8" />
  <title>Musik | Administrators</title>
  <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="css/animate.css" type="text/css" />
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="css/font.css" type="text/css" />
  <link rel="stylesheet" href="css/app.css" type="text/css" />  

</head>
<body class=" bg-dark">
<form id="form1" runat="server" >
  <section id="content" class="m-t-lg wrapper-md animated fadeInUp">    
    <div class="container aside-xl bg-dark">
      <a class="navbar-brand block"><span class="h1 font-bold">Musik Administrators</span></a>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>Sign in to get in touch</strong>
        </header>
          <div class="form-group">
              <asp:TextBox ID="name" runat="server"  placeholder="Name" class="form-control rounded input-lg text-center no-border"></asp:TextBox>
          </div>
          <div class="form-group">
              <asp:TextBox ID="password" runat="server"  placeholder="Password" class="form-control rounded input-lg text-center no-border" TextMode="Password"></asp:TextBox>
          </div>
            <asp:Button ID="login" runat="server" Text="Sign in" class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded" OnClick="signin_Click" />    
          <div class="line line-dashed"></div>
          <p class="text-muted text-center"><small>本页面为管理员登陆界面</small></p>
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
