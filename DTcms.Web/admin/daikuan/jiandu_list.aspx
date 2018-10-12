<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jiandu_list.aspx.cs" Inherits="DTcms.Web.admin.daikuan.jiandu_list" %>
<%@ Import namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>借款列表</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>借款列表</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
      <div class="l-list">
        <ul class="icon-list">
        </ul>
      </div>
      <div class="r-list">
        <asp:TextBox ID="txtKeywords" runat="server" CssClass="keyword" />
        <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" onclick="btnSearch_Click">查询</asp:LinkButton>
      </div>
    </div>
  </div>
</div>
<!--/工具栏-->

<!--列表-->
<div class="table-container">
  <asp:Repeater ID="rptList" runat="server">
  <HeaderTemplate>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
    <tr>
      <th align="center" width="8%">借款人姓名</th>
      <th align="left" width="5%">会员等级</th>
      <th align="left" width="5%">性别</th>
      <th align="left" width="6%">身份证号码</th>
      <th align="left" width="6%">会员证号码</th>
      <th align="left" width="6%">可借款金额</th>
      <th align="left" width="5%">借款金额</th>
      <th align="left" width="5%">借款用途</th>
      <th align="left" width="8%">互助联保人</th>
      <th align="left" width="5%">产业规模</th>
      <th align="left" width="5%">备注</th>
      <th width="8%">回访附件</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
        <td align="center"><%# Eval("name") %></td>
        <td><%#new DTcms.BLL.member_level().GetName(Convert.ToInt32(Eval("level")))%></td>
        <td><%# GetGender(Eval("gender").ToString()) %></td>
        <td><%# Eval("id_card") %></td>
        <td><%# Eval("member_no") %></td>
        <td><%# Eval("can_amount") %></td>
        <td><%# Eval("amount") %></td>
        <td><%# Eval("purpose") %></td>
        <td><%# Eval("lb_person_names") %></td>
        <td><%#new DTcms.BLL.daikuan_chanye().GetName(Convert.ToInt32(Eval("chanye")))%></td>
        <td style="color:#ff0000"><%# Eval("remark") %></td>
      <td align="center"><a href="">上传</a></td>
    </tr>
  </ItemTemplate>
  <FooterTemplate>
    <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"8\">暂无记录</td></tr>" : ""%>
  </table>
  </FooterTemplate>
  </asp:Repeater>
</div>
<!--/列表-->

<!--内容底部-->
<div class="line20"></div>
<div class="pagelist">
  <div class="l-btns">
    <span>显示</span><asp:TextBox ID="txtPageNum" runat="server" CssClass="pagenum" onkeydown="return checkNumber(event);"
                OnTextChanged="txtPageNum_TextChanged" AutoPostBack="True"></asp:TextBox><span>条/页</span>
  </div>
  <div id="PageContent" runat="server" class="default"></div>
</div>
<!--/内容底部-->
</form>
</body>
</html>
