<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teacher_print.aspx.cs" Inherits="DTcms.Web.admin.dialog.teacher_print" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>打印</title>
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <script type="text/javascript">
        var api = top.dialog.get(window); //获取父窗体对象
        //页面加载完成执行
        $(function () {
            //设置按钮及事件
            api.button([{
                value: '确认打印',
                callback: function () {
                    printWin();
                },
                autofocus: true
            }, {
                value: '取消',
                callback: function () { }
            }]);
        });
        //打印方法
        function printWin() {
            var oWin = window.open("", "_blank");
            oWin.document.write(document.getElementById("content").innerHTML);
            oWin.focus();
            oWin.document.close();
            oWin.print();
            oWin.close();
            return false;
        }
    </script>
</head>

<body style="margin: 0;">
    <form id="form1" runat="server">
        <div id="content">
            <table width="800" border="0" align="center" cellpadding="3" cellspacing="0" style="font-size: 12px; font-family: '微软雅黑'; background: #fff;">
                <tr>
                    <th align="center" style="font-size: 16px">导师信息
                    </th>
                </tr>
                <tr>
                    <td colspan="3" style="padding: 10px 0; border-top: 1px solid #000;">
                        <asp:Repeater ID="rptList" runat="server">
                            <HeaderTemplate>
                                <table width="100%" border="0" cellspacing="0" cellpadding="5" style="font-size: 12px; font-family: '微软雅黑'; background: #fff;">
                                    <tr>
                                        <th width="10%" align="center" style="background: #ccc;">工号</th>
                                        <th width="10%" align="center" style="background: #ccc;">姓名</th>
                                        <th width="10%" align="center" style="background: #ccc;">学术型导师</th>
                                        <th width="10%" align="center" style="background: #ccc;">学硕分配指标</th>
                                        <th width="10%" align="center" style="background: #ccc;">专业型导师</th>
                                        <th width="10%" align="center" style="background: #ccc;">专硕分配指标</th>
                                        <th width="10%" align="center" style="background: #ccc;">研究方向</th>
                                        <th width="10%" align="center" style="background: #ccc;">专业</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td align="center"><%#Eval("no")%></td>
                                    <td align="center"><%#Eval("name")%></td>
                                    <td align="center"><%# Eval("is_aca").ToString()=="1"?"是":"否"%></td>
                                    <td align="center"><%#Eval("quota")%></td>
                                    <td align="center"><%# Eval("is_pro").ToString()=="1"?"是":"否"%></td>
                                    <td align="center"><%#Eval("pro_quota")%></td>
                                    <td align="center"><%#Eval("direction")%></td>
                                    <td align="center"><%#Eval("major")%></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"7\">暂无记录</td></tr>" : ""%>
                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </td>

                </tr>
                <tr>
                </tr>
            </table>

            <table width="800" border="0" align="center" cellpadding="3" cellspacing="0" style="font-size: 12px; font-family: '微软雅黑'; background: #fff;">
                <tr>
                    <th align="center" style="font-size: 16px">研究生信息
                    </th>
                </tr>
                <tr>
                    <td colspan="3" style="padding: 10px 0; border-top: 1px solid #000;">
                        <asp:Repeater ID="rptList1" runat="server">
                            <HeaderTemplate>
                                <table width="100%" border="0" cellspacing="0" cellpadding="5" style="font-size: 12px; font-family: '微软雅黑'; background: #fff;">
                                    <tr>
                                        <th align="center" width="15%" style="background: #ccc;">编号</th>
                                        <th align="center" width="15%" style="background: #ccc;">姓名</th>
                                        <th align="center" width="15%" style="background: #ccc;">学术型研究生</th>
                                        <th align="center" width="15%" style="background: #ccc;">本科毕业院校</th>
                                        <th align="center" width="15%" style="background: #ccc;">笔试成绩</th>
                                        <th align="center" width="15%" style="background: #ccc;">复试成绩</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td align="center"><%# Eval("no")%></td>
                                    <td align="center"><%# Eval("name")%></td>
                                    <td align="center"><%# Eval("is_aca").ToString()=="1"?"是":"否"%></td>
                                    <td align="center"><%# Eval("school")%></td>
                                    <td align="center"><%# Eval("score")%></td>
                                    <td align="center"><%# Eval("re_score")%></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                <%#rptList1.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"7\">暂无记录</td></tr>" : ""%>
                            </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
