<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="exit_audit_list.aspx.cs" Inherits="DTcms.Web.admin.exit.exit_audit_list" %>
<%@ Import namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>退回审核</title>
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
  <span>退会审核</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
      <div class="l-list">
        <ul class="icon-list">
          <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
          <li><asp:LinkButton ID="btnAudit" runat="server" CssClass="lock" OnClientClick="return ExePostBack('btnAudit','您确认要同意该退会申请吗？');" onclick="btnAudit_Click"><i></i><span>同意退会</span></asp:LinkButton></li>
            <li><asp:LinkButton ID="LinkButton1" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnAudit','您确认要驳回该退会申请吗？');" onclick="btnReject_Click"><i></i><span>驳回退会</span></asp:LinkButton></li>
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
      <th width="8%">选择</th>
      <th align="left" width="8%">会员证号码</th>
      <th align="left" width="5%">姓名</th>
      <th align="left" width="5%">退会状态</th>
      <th align="left" width="5%">类别</th>
      <th align="left" width="5%">性别</th>
      <th align="left" width="8%">身份证号码</th>
      <th align="left" width="8%">电话</th>
      <th align="left" width="8%">所属村镇</th>
      <th align="left" width="8%">缴纳会费金额</th>
      <th align="left" width="8%">缴纳会费时间</th>
      <th align="left" width="8%">退会时间</th>
      <th align="left" width="8%">备注</th>
      <th width="8%">操作</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
      <td align="center">
        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;" />
        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
      </td>
        <td><%# Eval("no") %></td>
        <td><%# Eval("name") %></td>
        <td><%#GetStatus(Eval("status").ToString()) %></td>
        <td><%# Convert.ToString(Eval("type")) == "0" ? "常规会员" : "贫困会员"%></td>
        <td><%# Convert.ToString(Eval("gender")) == "0" ? "男" : "女"%></td>
        <td><%# Eval("id_card") %></td>
        <td><%# Eval("tel") %></td>
        <td><%# Eval("village") %></td>
        <td><%# Eval("amount") %></td>
        <td><%#string.Format("{0:yyyy-MM-dd}",Eval("date"))%></td>
        <td><%#string.Format("{0:yyyy-MM-dd HH:mm}",Eval("exit_time"))%></td>
        <td><%# Eval("remark") %></td>
      <td align="center">
          <a href="exit_detail.aspx?id=<%#Eval("id")%>">详情</a>
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
