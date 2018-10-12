<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="daikuan_set.aspx.cs" Inherits="DTcms.Web.admin.daikuan.daikuan_set" ValidateRequest="false" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>借款事项设置</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
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
            <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <span>系统参数设置</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">借款事项设置</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!--主站基本信息-->
        <div class="tab-content">
            <dl>
                <dt>借款利率</dt>
                <dd>
                    <asp:TextBox ID="txtRate" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
                    <span class="Validform_checktip">*借款利率</span>
                </dd>
            </dl>
            <dl>
                <dt>超期利率</dt>
                <dd>
                    <asp:TextBox ID="txtOverRate" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
                    <span class="Validform_checktip">*借款超期利率</span>
                </dd>
            </dl>
            <dl>
                <dt>借款限额</dt>
                <dd>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="input normal" datatype="n" sucmsg=" " Text="20000" />
                    <span class="Validform_checktip">*借款限额，默认为2万</span>
                </dd>
            </dl>
        </div>
        <!--/网站基本信息-->

        <!--/内容-->

        <!--工具栏-->
        <div class="page-footer">
            <div class="btn-wrap">
                <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmit_Click" />
                <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
            </div>
        </div>
        <!--/工具栏-->
    </form>
</body>
</html>
