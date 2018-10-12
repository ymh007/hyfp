<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xiehui_edit.aspx.cs" Inherits="DTcms.Web.admin.xiehui.xiehui_edit" ValidateRequest="false" %>
<%@ Import namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>编辑管理员</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>

<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
<script type="text/javascript">
    $(function () {
        //初始化表单验证
        $("#form1").initValidform();
    });
</script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="xiehui_list.aspx" class="back"><i></i><span>返回列表页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <a href="xiehui_list.aspx"><span>管理员</span></a>
  <i class="arrow"></i>
  <span>编辑管理员</span>
</div>
<div class="line10"></div>
<!--/导航栏-->

<!--内容-->
<div id="floatHead" class="content-tab-wrap">
  <div class="content-tab">
    <div class="content-tab-ul-wrap">
      <ul>
        <li><a class="selected" href="javascript:;">管理员信息</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="tab-content">
     <dl>
        <dt>所属父级</dt>
        <dd>
            <div class="rule-single-select">
                <asp:DropDownList ID="ddlParentId" runat="server"></asp:DropDownList>
            </div>
        </dd>
    </dl>
   <dl>
    <dt>管理角色</dt>
    <dd>
      <div class="rule-single-select">
        <asp:DropDownList id="ddlRoleId" runat="server" datatype="*" errormsg="请选择管理员角色" sucmsg=" "></asp:DropDownList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>是否启用</dt>
    <dd>
      <div class="rule-single-checkbox">
          <asp:CheckBox ID="cbIsLock" runat="server" Checked="True" />
      </div>
      <span class="Validform_checktip">*不启用则无法使用该账户登录</span>
    </dd>
  </dl>
  <dl>
    <dt>账号</dt>
    <dd><asp:TextBox ID="txtUserName" runat="server" CssClass="input normal" datatype="*1-20" sucmsg=" " ajaxurl="../../tools/admin_ajax.ashx?action=xiehui_validate"></asp:TextBox> <span class="Validform_checktip">*字母、下划线，不可修改</span></dd>
  </dl> 
    <dl>
    <dt>所属乡镇</dt>
    <dd>
      <div class="rule-single-select">
        <asp:DropDownList id="ddlTown" runat="server" datatype="*" errormsg="请选择所属乡镇" sucmsg=" " AutoPostBack="true" OnSelectedIndexChanged="town_Change_Click"></asp:DropDownList>
      </div>
    </dd>
  </dl>
    <dl>
    <dt>所属村</dt>
    <dd>
      <div class="rule-single-select">
        <asp:DropDownList id="ddlVillage" runat="server" datatype="*" errormsg="请选择所属村" sucmsg=" "></asp:DropDownList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>登录密码</dt>
    <dd><asp:TextBox ID="txtPassword" runat="server" CssClass="input normal" TextMode="Password" datatype="*6-20" nullmsg="请设置密码" errormsg="密码范围在6-20位之间" sucmsg=" "></asp:TextBox> <span class="Validform_checktip">*</span></dd>
  </dl>
  <dl>
    <dt>确认密码</dt>
    <dd><asp:TextBox ID="txtPassword1" runat="server" CssClass="input normal" TextMode="Password" datatype="*" recheck="txtPassword" nullmsg="请再输入一次密码" errormsg="两次输入的密码不一致" sucmsg=" "></asp:TextBox> <span class="Validform_checktip">*</span></dd>
  </dl>
  <dl>
    <dt>协会名称</dt>
    <dd><asp:TextBox ID="txtRealName" runat="server" CssClass="input normal"></asp:TextBox></dd>
  </dl>
  
    <dl>
    <dt>协会负责人</dt>
    <dd><asp:TextBox ID="txtPerson" runat="server" CssClass="input normal"></asp:TextBox></dd>
  </dl>
    <dl>
    <dt>负责人电话</dt>
    <dd><asp:TextBox ID="txtTel" runat="server" CssClass="input normal"></asp:TextBox></dd>
  </dl>
    <dl>
    <dt>协会地址</dt>
    <dd><asp:TextBox ID="txtAddress" runat="server" CssClass="input" TextMode="MultiLine"></asp:TextBox></dd>
  </dl>
   <div id="field_tab_content" runat="server" visible="false"></div>
</div>
<!--/内容-->
<!--工具栏-->
<div class="page-footer">
  <div class="btn-wrap">
    <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" onclick="btnSubmit_Click" />
    <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript:history.back(-1);" />
  </div>
</div>
<!--/工具栏-->
</form>
</body>
</html>
