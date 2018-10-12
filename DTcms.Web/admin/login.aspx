<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="DTcms.Web.admin.login" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<LINK rel="Bookmark" href="/favicon.ico">
<LINK rel="Shortcut Icon" href="/favicon.ico" />

<link rel="stylesheet" type="text/css"
	href="static/css/ui.login.css" />
<link rel="stylesheet" type="text/css"
	href="static/css/login.css">

<link rel="stylesheet" href="static/css/css.css"/>
<link rel="stylesheet" href="static/css/m-p.css"/>
<link rel="stylesheet" href="static/css/w-h.css"/>

<script type="text/javascript" src="static/js/js.js"></script>

<script type="text/javascript" src="static/js/messages_zh.js"></script>
<script type="text/javascript" src="static/js/login.js"></script>
<title>汉阴县扶贫</title>
<script type="text/javascript">
    if (top != this) {
        top.location = this.location;
    }
    $(function () {
        $("#username").focus();
        $("#jvForm").validate();
    });
</script>
</head>
<body class="adminLogo_bck">
	<form id="jvForm" method="post" style="width:100%;" runat="server">
		<div class="w-760 h-68 center adminLogo_title"></div>
	    <div class="w-818 center h-425 adminLogo_main">
	    	<div class="w-390 right m-r30 m-t70">
		        <div class="login-input">
					<label for="user" class="icon left"><img
						src="static/images/user.png" alt=""></label> 
                     <asp:TextBox ID="txtUserName" runat="server" CssClass=" left w-220" placeholder="用户名" title="用户名"></asp:TextBox>
                   
					<!--提示信息框-->
					<p class="login-zi1 login-error login-none"></p>
				</div>
				<div class="login-input">
                    
					<label for="pass" class="icon left"><img
						src="static/images/pass.png" alt=""></label> 
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="icon left w-220" TextMode="Password" placeholder="密码" title="密码"></asp:TextBox>
					<!--提示信息框-->
					<p class="login-zi1 pass-error pass-none"></p>
				</div>
				
				<div class="login-bottom">
				 
                     <asp:Button ID="btnSubmit" runat="server" Text="登 录" CssClass="login-sub" onclick="btnSubmit_Click" />
				</div>
                 <div class="login-tips"><i></i><p id="msgtip" runat="server">请输入用户名和密码</p></div>
		    </div>
	    </div>
	</form>
    <div class="adminLogo_footer center m-t50">
<!--         Copyright © 2017  NB2025.CN. All Rights Reserved    大甬智造   版权所有 甬ICP备12034678号-2 -->
    </div>
    <script>
        function updateVercode() {
            document.getElementById("vCode").src = "login/creatCode?"
					+ Math.random().toString();
        }
	</script>
</body>
</html>
