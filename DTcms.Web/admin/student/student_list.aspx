<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student_list.aspx.cs" Inherits="DTcms.Web.admin.article.student_list" %>

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
            var tableInfo = "";
            var tableObj = $(".ltable")[0];
            for (var i = 0; i < tableObj.rows.length; i++) {  //遍历Table的所有Row
                var status = tableObj.rows[i].cells[9].innerText;
                var id = tableObj.rows[i].cells[1].innerText;

                var roleId = $("#labRoleId").val();
                if (roleId == "2") {
                    tableObj.rows[i].cells[0].hidden = true;
                    $(".edit" + id).hide();
                }
                if (roleId != "1") {
                    $("#txtImgUrl").hide();
                    $("#btnImport").hide();
                    $(".upload-img").hide();
                    $("#memo").hide();
                }
                //如果导师已通过学生选择，则隐藏修改、选择导师按钮
                if (status == "导师已通过您的申请") {
                    $(".edit" + id).hide();
                    $(".choose" + id).hide();
                    //$(".revoke" + id).hide();
                }
                var selectTeacher = tableObj.rows[i].cells[8].innerText;
                //研究生选择导师后，就不能再选择导师了，将选择导师隐藏，当此导师没选择他时，再显示让他重新选择导师
                if (selectTeacher != '' && status != "导师未通过您的申请，请再次操作选择其他导师") {
                    $(".choose" + id).hide();
                }
              
            }
            return tableInfo;
        });

        // 导入Excel
        function importExcel() {
            var filepath = $("#txtImgUrl")[0].value;
            $.ajax({
                url: "../../tools/Import/ImportExcel.ashx",
                type: "POST",
                data: { filepath: filepath },// 你的formid
                dataType: 'json', // 服务器返回数据转换成的类型
                success: function (data) {
                    location.reload();
                    alert(data.msg);
                }
            });
        }
    </script>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <input runat="server" id="labRoleId" hidden="hidden" value=""/>
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
                            <li><a class="add" href="student_edit.aspx?action=<%=DTEnums.ActionEnum.Add %>"><i></i><span>新增</span></a></li>

                            <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
                            <li>
                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnDelete');" OnClick="btnDelete_Click">
                                    <i></i>
                                    <span>删除</span>
                                </asp:LinkButton>
                            </li>
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
                        <th align="center" width="8%">编号</th>
                        <th align="center" width="8%">姓名</th>
                        <th align="center" width="10%">本科毕业院校</th>
                        <th align="center" width="8%">笔试成绩</th>
                        <th align="center" width="8%">复试成绩</th>
                        <th align="center" width="8%">学术型研究生</th>
                        <th align="center" width="8%">选择导师</th>
                        <th align="center" width="10%">状态</th>
                        <th align="center" width="10%">个人简历</th>
                        <th width="10%">操作</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td align="center">
                        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" Style="vertical-align: middle;" />
                        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
                        <input class="hidId" style="display: none" value="<%#Eval("id")%>" />
                    </td>
                    <td hidden="hidden"><%# Eval("id")%></td>
                    <td align="center"><%# Eval("no")%></td>
                    <td align="center"><%# Eval("name")%></td>
                    <td align="center"><%# Eval("school")%></td>
                    <td align="center"><%# Eval("score")%></td>
                    <td align="center"><%# Eval("re_score")%></td>
                    <td align="center"><%# Eval("is_aca").ToString()=="1"?"是":"否"%></td>
                    <td align="center"><%# string.IsNullOrEmpty(Eval("teacher_id").ToString())?"":new DTcms.BLL.teacher().GetName(Convert.ToInt32(Eval("teacher_id")))%></td>
                    <td align="center"><%# Eval("status")%></td>
                    <td align="center">
                        <a href="student_edit.aspx?action=<%#DTEnums.ActionEnum.Build %>&id=<%#Eval("id")%>">上传</a>
                        <a href="<%#Eval("attach")%>">下载</a>
                    </td>
                    <td align="center">
                        <a class="edit<%#Eval("id")%>" href="student_edit.aspx?action=<%#DTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">修改</a>
                        <a class="choose<%#Eval("id")%>" href="teacher_choose.aspx?action=<%#DTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">选择导师</a>
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
