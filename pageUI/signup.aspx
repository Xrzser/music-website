<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" %>

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
  <section id="content" class="m-t-lg wrapper-md animated fadeInDown">
    <div class="container aside-xl">
      <a class="navbar-brand block" href="#"><span class="h1 font-bold">For Music</span></a>
      <section class="m-b-lg">
        <header class="wrapper text-center">
          <strong>Sign up to find interesting things</strong>
        </header>
          <div class="form-group">
            <asp:TextBox ID="name" runat="server" class="form-control rounded input-lg text-center no-border" placeholder="昵称" ></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="Email" runat="server" class="form-control rounded input-lg text-center no-border" placeholder="邮箱" ></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="Password" runat="server" class="form-control rounded input-lg text-center no-border" placeholder="密码"  TextMode="Password"></asp:TextBox>
          </div>
          <div class="checkbox i-checks m-b">
            <label class="m-l">
              <asp:CheckBox ID="CheckBox1" runat="server" Checked="True" /><i></i> 同意 <a href="#">隐私条款</a>
            </label>
          </div>
          <asp:Button ID="sign_up" runat="server" Text="注 册" class="btn btn-lg btn-warning lt b-white b-2x btn-block btn-rounded" OnClick="sign_up_Click" />
          <div class="line line-dashed"></div>
          <p class="text-muted text-center"><small>已经有账户?</small></p>
          <a href="signin.aspx" class="btn btn-lg btn-info btn-block btn-rounded">去登陆页面</a>  
      </section>
    </div>
  </section>
  <!-- footer -->
  <footer id="footer">
    <div class="text-center padder clearfix">
      <p>
        <small>西安电子科技大学<br>&copy; 2019</small>
      </p>
    </div>
  </footer>
</form>
</body>
</html>