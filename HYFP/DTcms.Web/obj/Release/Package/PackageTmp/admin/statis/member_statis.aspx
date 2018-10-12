<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="member_statis.aspx.cs" Inherits="DTcms.Web.admin.statis.member_statis" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>会员统计</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
</head>

<body class="mainbody">
        <!--导航栏-->
        <div class="location">
            <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <span>会员统计</span>
        </div>
        <!--/导航栏-->

        <!--列表-->
            <asp:Chart ID="Chart1" runat="server">
            <series>
                <asp:Series ChartType="Pie" IsValueShownAsLabel="True" Label="#VALX:#VAL" Legend="Legend1" Name="Series1">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Enabled="False" Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>
        <!--/列表-->
            <asp:Chart ID="Chart2" runat="server">
            <series>
                <asp:Series ChartType="Pie" IsValueShownAsLabel="True" Label="#VALX:#VAL" Legend="Legend1" Name="Series1">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Enabled="False" Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>
        
     <asp:Chart ID="Chart3" runat="server">
            <series>
                <asp:Series ChartType="Pie" IsValueShownAsLabel="True" Label="#VALX:#VAL" Legend="Legend1" Name="Series1">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Enabled="False" Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>
</body>
</html>
