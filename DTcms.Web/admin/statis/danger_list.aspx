<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="danger_list.aspx.cs" Inherits="DTcms.Web.admin.statis.danger_list" %>

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

        <!--工具栏-->
        <div id="floatHead" class="toolbar-wrap">
            <div class="toolbar">
                <div class="box-wrap">
                     <a class="menu-btn"></a>
                      <div class="l-list">
                        <ul class="icon-list">
                          <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
                          <li><asp:LinkButton ID="btnDongJie" runat="server" CssClass="lock" OnClientClick="return ExePostBack('btnDongJie','您确认要银行协助冻结该会员资金吗？');" onclick="btnDongJie_Click"><i></i><span>银行协助</span></asp:LinkButton></li>
                            <li><asp:LinkButton ID="btnFaLv" runat="server" CssClass="lock" OnClientClick="return ExePostBack('btnFaLv','您确认要对该会员走法律程序吗吗？');" onclick="btnFaLv_Click"><i></i><span>法律程序</span></asp:LinkButton></li>
                            <li><asp:LinkButton ID="btnStop" runat="server" CssClass="lock" OnClientClick="return ExePostBack('btnStop','您确认要停止该会员的一切业务吗？');" onclick="btnStop_Click"><i></i><span>停止业务</span></asp:LinkButton></li>
                        </ul>
                      </div>
                    <div class="r-list">
                        <asp:TextBox ID="txtKeywords" runat="server" CssClass="keyword" />
                        <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click">查询</asp:LinkButton>
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
                            <th align="left" width="6%">会员证号码</th>
                            <th align="left" width="5%">姓名</th>
                            <th align="left" width="5%">类别</th>
                            <th align="left" width="5%">等级</th>
                            <th align="left" width="5%">性别</th>
                            <th align="left" width="5%">身份证号码</th>
                            <th align="left" width="5%">电话</th>
                            <th align="left" width="5%">所属乡镇</th>
                            <th align="left" width="5%">所属村</th>
                            <th align="left" width="5%">备注</th>
                            <th align="left" width="5%">防控措施</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center">
                            <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" Style="vertical-align: middle;" />
                            <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
                        </td>
                        <td><%# Eval("no") %></td>
                        <td><%# Eval("name") %></td>
                        <td><%# Convert.ToString(Eval("type")) == "0" ? "常规会员" : "贫困会员"%></td>
                        <td><%#new DTcms.BLL.member_level().GetName(Convert.ToInt32(Eval("level")))%></td>
                        <td><%# GetGender(Eval("gender").ToString()) %></td>
                        <td><%# Eval("id_card") %></td>
                        <td><%# Eval("tel") %></td>
                        <td><%# Eval("town") %></td>
                        <td><%# Eval("village") %></td>
                        <td><%# Eval("remark") %></td>
                        <td><%# Eval("fangkong") %></td>
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
