<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hz_statis.aspx.cs" Inherits="DTcms.Web.admin.statis.hz_statis" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>汇总统计</title>
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
        .date-input {
            height: 35px;
        }

        select {
            width: 150px;
            height: 30px;
            border: 1px solid #eee;
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
            <span>汇总统计</span>
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
                                <asp:TextBox ID="txtKeywords" runat="server" CssClass="input rule-date-input left" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " />
                                <asp:DropDownList ID="ddlBSubject" runat="server" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList>
                                <asp:DropDownList ID="ddlSSubject" runat="server"></asp:DropDownList>
                                <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click" AutoPostBack="true">查询</asp:LinkButton></li>
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
                            <th>所属乡镇</th>
                            <th align="left" width="5%">所属村</th>
                            <th align="left" width="6%">协会名称</th>
                            <th align="left" width="4%">现金</th>
                            <th align="left" width="5%">银行存款</th>
                            <th align="left" width="5%">借出互助金</th>
                            <th align="left" width="5%">资产小计</th>
                            <th align="left" width="6%">借出互助金资金占比率</th>
                            <th align="left" width="6%">会员入会互助金</th>
                            <th align="left" width="6%">政府拨入互助资金</th>
                            <th align="left" width="4%">负债小计</th>
                            <th align="left" width="4%">净资产</th>
                            <th align="left" width="5%">政府补助收入</th>
                            <th align="left" width="6%">借出互助资金占用费收入</th>
                            <th align="left" width="6%">业务管理费收入</th>
                            <th align="left" width="5%">公益金</th>
                            <th align="left" width="4%">收入小计</th>
                            <th align="left" width="5%">业务活动支出</th>
                            <th align="left">净资产-本期结余</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center"><%# Eval("Town") %></td>
                        <td><%# Eval("Village") %></td>
                        <td><%# Eval("XieHui") %></td>
                        <td><%# Eval("XianJin") %></td>
                        <td><%# Eval("YHCK") %></td>
                        <td><%# Eval("JCHZJ") %></td>
                        <td><%# Eval("ZCXJ") %></td>
                        <td><%# Eval("JCZB") %></td>
                        <td><%# Eval("RHHZ") %></td>
                        <td><%# Eval("ZFHZJ") %></td>
                        <td><%# Eval("FZXJ") %></td>
                        <td><%# Eval("JZC") %></td>
                        <td><%# Eval("ZFBZ") %></td>
                        <td><%# Eval("JCZY") %></td>
                        <td><%# Eval("YWGL") %></td>
                        <td><%# Eval("GYJ") %></td>
                        <td><%# Eval("SRXJ") %></td>
                        <td><%# Eval("HDZC") %></td>
                        <td><%# Eval("BQJY") %></td>
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
