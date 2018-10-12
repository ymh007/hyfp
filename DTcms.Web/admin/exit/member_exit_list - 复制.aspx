<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="member_exit_list.aspx.cs" Inherits="DTcms.Web.admin.exit.member_exit_list" %>
<%@ Import namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>管理员列表</title>
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
  <span>协会会员列表</span>
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
      <th width="8%">选择</th>
      <th align="left" width="8%">会员证号码</th>
      <th align="left" width="5%">姓名</th>
      <th align="left" width="5%">性别</th>
      <th align="left" width="5%">会员缴纳金额</th>
      <th align="left" width="8%">借款金额</th>
      <th align="left" width="8%">互助金占用费</th>
      <th align="left" width="8%">借款是否还清</th>
      <th align="left" width="8%">已还金额</th>
      <th align="left" width="8%">未还金额</th>
      <th width="8%">操作</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
      <td align="center">
        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;" />
        <asp:HiddenField ID="hidId" Value='<%#Eval("member_id")%>' runat="server" />
      </td>
        <td><%# Eval("member_no") %></td>
        <td><%# Eval("name") %></td>
        <td><%# Convert.ToString(Eval("gender")) == "0" ? "男" : "女"%></td>
        <td><%# Eval("member_amount") %></td>
        <td><%# Eval("sum_amount") %></td>
        <td><%# Eval("sum_zy_amount") %></td>
        <td><%# Convert.ToDecimal(Eval("sum_wh_amount")) == 0 ? "已还清" : "未还清"%></td>
        <td><%# Eval("sum_yh_amount") %></td>
        <td><%# Eval("sum_wh_amount") %></td>
        <td align="center">
            <a href="repay_list.aspx?id=<%#Eval("member_id")%>">还款详情</a>
            <a href="lb_repay_list.aspx?id=<%#Eval("member_id")%>">小组还款详情</a>
            <a href="exit_edit.aspx?action=<%#DTEnums.ActionEnum.Add %>&id=<%#Eval("member_id")%>">退会</a>
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
