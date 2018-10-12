﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="exit_detail.aspx.cs" Inherits="DTcms.Web.admin.exit.exit_detail" %>

<%@ Import Namespace="DTcms.Common" %>

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

    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../editor/kindeditor-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <style>
        .imglist ul li{float:left;margin: 10px 30px 15px 15px;min-width:220px;}
    </style>
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
        <!--列表-->
        <div class="table-container">
            <div id="floatHead1" class="content-tab-wrap">
                <div class="content-tab">
                    <div class="content-tab-ul-wrap">
                        <ul>
                            <li><a class="selected" href="javascript:;">附件</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--图片列表-->
            <asp:Repeater ID="rptList2" runat="server">
                <HeaderTemplate>
                    <div class="imglist">
                        <ul>
                </HeaderTemplate>
                <ItemTemplate>
                    <li>
                       <img src=<%# Eval("thumb_path") %> style="width:265px;height:265px;"/>
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    <%#rptList2.Items.Count == 0 ? "<div align=\"center\" style=\"font-size:12px;line-height:30px;color:#666;\">暂无记录</div>" : ""%>
                    </ul>
                  </div>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <!--/列表-->
    </form>
</body>
</html>