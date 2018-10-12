<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="subject_statis.aspx.cs" Inherits="DTcms.Web.admin.statis.subject_statis" %>
<%@ Import namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>科目统计</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>

    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../editor/kindeditor-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>

    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <style>
        .date-input{
            height:35px;
        }
        select {
            width: 150px;
            height: 30px;
            border:1px solid #eee;
        }
    </style>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>科目统计</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
      <div class="l-list">
           <ul class="icon-list">
               <li>
                   所属乡镇：<asp:TextBox ID="txtTown" runat="server" CssClass="input" />
                   所属村庄：<asp:TextBox ID="txtVillage" runat="server" CssClass="input" />
                   日期：<asp:TextBox ID="txtKeywords" runat="server" CssClass="input rule-date-input left" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " />
                   <asp:DropDownList ID="ddlBSubject" runat="server" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList>
                   <asp:DropDownList ID="ddlSSubject" runat="server"></asp:DropDownList>
                   <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" onclick="btnSearch_Click" AutoPostBack="true" >查询</asp:LinkButton></li>
               <li>
                   <asp:LinkButton ID="btnExport" runat="server" CssClass="save" OnClick="btnExport_Click"><i></i><span>导出</span></asp:LinkButton>
               </li>
           </ul>
           
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
      <th width="5%">所属乡镇</th>
      <th align="left" width="5%">所属村</th>
      <th align="left" width="5%">协会名称</th>
      <th align="left" width="5%">科目大类</th>
      <th align="left" width="5%">科目小类</th>
      <th align="left" width="8%">初期余额</th>
      <th align="left" width="8%">本期发生-借</th>
      <th align="left" width="8%">本期发生-贷</th>
      <th align="left" width="8%">期末余额</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
        <td align="center"><%# Eval("Town") %></td>
        <td><%# Eval("Village") %></td>
        <td><%# Eval("XieHui") %></td>
        <td><%# Eval("BBSubjcet") %></td>
        <td><%# Eval("SSbuject") %></td>
        <td><%# Eval("Amount") %></td>
        <td><%# Eval("BQJie") %></td>
        <td><%# Eval("BQDai") %></td>
        <td><%# Eval("QmAmount") %></td>
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

<!--/内容底部-->
</form>
</body>
</html>
