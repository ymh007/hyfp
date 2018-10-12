<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teacher_choose.aspx.cs" Inherits="DTcms.Web.admin.article.teacher_choose" ValidateRequest="false" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>编辑内容</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../editor/kindeditor-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <script type="text/javascript">
        $(function () {
            //初始化表单验证
            $("#form1").initValidform();

            var tableInfo = "";
            var tableObj = $(".ltable")[0];
            for (var i = 0; i < tableObj.rows.length; i++) {  //遍历Table的所有Row
                var quota = tableObj.rows[i].cells[3].innerText;
                var pro_quota = tableObj.rows[i].cells[4];
                var isAsa = $("#txtIsAsa").val();
                //如果是学术型研究生，则隐藏导师专硕剩余指标
                if (isAsa == 1) {
                    tableObj.rows[i].cells[4].hidden=true;
                }
                else {
                    tableObj.rows[i].cells[3].hidden = true;
                }
            }
            return tableInfo;
        })
    </script>

</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <input type="hidden" runat="server" id="txtIsAsa" />
        <!--导航栏-->
        <div class="location">
            <a href="student_list.aspx" class="back"><i></i><span>返回列表页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <a href="teacher_list.aspx"><span>内容管理</span></a>
            <i class="arrow"></i>
            <span>编辑内容</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">基本信息</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!--文字列表-->
        <asp:Repeater ID="rptList1" runat="server">
            <HeaderTemplate>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
                    <tr>
                        <th width="6%">选择</th>
                        <th align="center" width="8%">工号</th>
                        <th align="center" width="8%">姓名</th>
                        <th align="center" width="5%">学硕剩余指标</th>
                        <th align="center" width="5%">专硕剩余指标</th>
                        <th align="center" width="8%">邮箱</th>
                        <th align="center" width="8%">研究方向</th>
                        <th align="center" width="8%">专业</th>
                        <th align="center" width="8%">添加时间</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td align="center">
                        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" Style="vertical-align: middle;" />
                        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
                        <input class="hidId" style="display: none" value="<%#Eval("id")%>" />
                    </td>
                    <td align="center"><%# Eval("no")%></td>
                    <td align="center"><%# Eval("name")%></td>
                    <td align="center"><%# Eval("resquota")%></td>
                    <td align="center"><%# Eval("pro_resquota")%></td>
                    <td align="center"><%# Eval("email")%></td>
                    <td align="center"><%# Eval("direction")%></td>
                    <td align="center"><%# Eval("major")%></td>
                    <td align="center"><%#string.Format("{0:g}",Eval("add_time"))%></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                <%#rptList1.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"7\">暂无记录</td></tr>" : ""%>
            </table>
            </FooterTemplate>
        </asp:Repeater>
        <!--/文字列表-->

        <!--内容底部-->
        <div class="line20"></div>

        <!--/内容底部-->

        <!--工具栏-->
        <div class="page-footer">
            <div class="btn-wrap">
                <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmit_Click" />
            </div>
        </div>
        <!--/工具栏-->

    </form>
</body>
</html>
