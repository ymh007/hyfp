<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teacher_list.aspx.cs" Inherits="DTcms.Web.admin.article.teacher_list" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>内容管理</title>
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
    <script type="text/javascript">
        $(function () {
            //初始化上传控件
            $(".upload-img").InitUploader({ filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf", filetypes: "<%=siteConfig.fileextension %>" });
            $(function () {
                $(".button").click(function () {
                    $.ajax({
                        url: "../../tools/submit_ajax.ashx?action=export_click",
                        type: "POST",
                        dataType: "json",
                        success: function (data, responseStatus) {
                            location.href = location.origin + '/' + data;
                        },
                    });
                });
            })

            //打印订单
            $(".btnPrint").click(function () {
                var id = $(this).parent().parent().find(".hidId").val();
                OrderPrint(id);
            });       

            var tableInfo = "";
            var tableObj = $(".ltable")[0];
           
            for (var i = 0; i < tableObj.rows.length; i++) {  //遍历Table的所有Row
                var id = tableObj.rows[i].cells[1].innerText;
                var roleId = $("#labRoleId").val();
                if (roleId=="3") {
                    tableObj.rows[i].cells[0].hidden = true;
                    $(".edit" + id).hide();
                }
                if (roleId != "1") {
                    $("#txtImgUrl").hide();
                    $("#btnImport").hide();
                    $(".upload-img").hide();
                    $("#memo").hide();
                }
                var requota = tableObj.rows[i].cells[6].innerText;
                var pro_requota = tableObj.rows[i].cells[9].innerText;
                if (parseFloat(requota) > 0 || parseFloat(pro_requota) > 0) {
                    $("#print" + id).hide();
                }
            }
            return tableInfo;
        });

        //打印订单
        function OrderPrint(id) {
            var winDialog = top.dialog({
                title: '打印',
                url: 'dialog/teacher_print.aspx?teacher_id=' + id,
                width: 850
            }).showModal();
        }
    </script>
</head>

<body class="mainbody">
    <input runat="server" id="labRoleId" hidden="hidden" value=""/>
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
            <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <span>内容列表</span>
        </div>
        <!--/导航栏-->

        <!--工具栏-->
        <div id="floatHead" class="toolbar-wrap">
            <div class="toolbar">
                <div class="box-wrap">
                    <a class="menu-btn"></a>
                    <div class="l-list">
                        <ul class="icon-list">
                            <li><a class="add" href="teacher_edit.aspx?action=<%=DTEnums.ActionEnum.Add %>"><i></i><span>新增</span></a></li>

                            <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
                            <li>
                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnDelete');" OnClick="btnDelete_Click">
                                    <i></i>
                                    <span>删除</span>
                                </asp:LinkButton>
                            </li>
                            <%--<li>
                                <a href="javascript:;" class="all button">
                                    <i></i>
                                    <span>数据导出</span>
                                </a>
                            </li>--%>
                            <li>
                                <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path test" />
                                <div class="upload-box upload-img"></div>
                            </li>
                            <li>
                                <asp:LinkButton ID="btnImport" runat="server" CssClass="save" OnClick="btnImport_Click"><i></i><span>确认上传</span></asp:LinkButton>
                            </li>
                            <li>
                                <div style="margin-top: 10px; margin-left: 5px; color: red;" id="memo">注:默认用户密码为编号+123（如test123)</div>
                            </li>
                        </ul>
                    </div>
                    <div class="r-list">
                    </div>
                </div>
            </div>
        </div>
        <!--/工具栏-->

        <!--文字列表-->
        <asp:Repeater ID="rptList1" runat="server" OnItemCommand="rptList_ItemCommand">
            <HeaderTemplate>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
                    <tr>
                        <th width="6%">选择</th>
                        <th align="center" width="8%">工号</th>
                        <th align="center" width="8%">姓名</th>
                        <th align="center" width="8%">学术型导师</th>
                        <th align="center" width="5%">学硕分配指标</th>
                        <th align="center" width="5%">学硕剩余指标</th>
                        <th align="center" width="8%">专业型导师</th>
                        <th align="center" width="5%">专硕分配指标</th>
                        <th align="center" width="5%">专硕剩余指标</th>
                        <th align="center" width="8%">邮箱</th>
                        <th align="center" width="8%">研究方向</th>
                        <th align="center" width="8%">专业</th>
                        <th width="10%">操作</th>
                        <th width="5%">打印</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td align="center">
                        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" Style="vertical-align: middle;" />
                        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
                        <asp:HiddenField ID="hidResquota" Value='<%# Eval("resquota")%>' runat="server" />
                        <input class="hidId" style="display: none" value="<%#Eval("id")%>" />
                    </td>
                    <td align="center" hidden="hidden"><%# Eval("id")%></td>
                    <td align="center"><%# Eval("no")%></td>
                    <td align="center"><%# Eval("name")%></td>
                    <td align="center"><%# Eval("is_aca").ToString()=="1"?"是":"否"%></td>
                    <td align="center"><%# Eval("quota")%></td>
                    <td align="center"><%# Eval("resquota")%></td>
                    <td align="center"><%# Eval("is_pro").ToString()=="1"?"是":"否"%></td>
                    <td align="center"><%# Eval("pro_quota")%></td>
                    <td align="center"><%# Eval("pro_resquota")%></td>
                    <td align="center"><%# Eval("email")%></td>
                    <td align="center"><%# Eval("direction")%></td>
                    <td align="center"><%# Eval("major")%></td>
                    <td align="center">
                        <a class="edit<%#Eval("id")%>" href="teacher_edit.aspx?action=<%#DTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">修改</a>
                        <a href="student_choose.aspx?action=<%#DTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">选择研究生</a>
                        <a href="student_choose.aspx?action=<%#DTEnums.ActionEnum.Show %>&id=<%#Eval("id")%>">已选择研究生</a>
                    </td>
                    <td align="center">
                        <a class="btnPrint" id="print<%#Eval("id")%>" href="javascript:;">打印</a>
                    </td>
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
