<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="daikuan_manager_list.aspx.cs" Inherits="DTcms.Web.admin.manager.daikuan_manager_list" %>
<%@ Import namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>还款列表</title>
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
  <span>还款列表</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
     
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
      <th align="left" width="10%">借款初始时间</th>
      <th align="left" width="10%">借款金额</th>
      <th align="left" width="10%">已还款金额</th>
      <th align="left" width="10%">未还款金额</th>
      <th align="left" width="10%">互助金占用费</th>
      <th align="left" width="10%">超期占用费</th>
      <th align="left" width="10%">状态</th>
      <th width="8%">操作</th>
    </tr>

     
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
        <td align="center"><%# Eval("name") %></td>
        <td><%#string.Format("{0:yyyy-MM-dd}", Eval("audit_time"))%></td>
        <td><%# Eval("amount") %></td>
        <td><%# Eval("yh_amount") %></td>
        <td><%# Eval("wh_amount") %></td>
        <td><%# Eval("zy_amount") %></td>
        <td><%# Eval("cq_amount") %></td>
        <td><%# GetStatus(Eval("hk_status").ToString()) %></td>
      <td align="center">
          <a href="daikuan_repay.aspx?action=<%#DTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>"><i></i><span>还款</span></a>
          <a href="daikuan_repay_detail.aspx?id=<%#Eval("id")%>">详情</a>
      </td>
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
