<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="center.aspx.cs" Inherits="DTcms.Web.admin.center" %>
<%@ Import namespace="DTcms.Common" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>管理首页</title>
<link href="skin/default/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/layindex.js"></script>
<script type="text/javascript" charset="utf-8" src="js/common.js"></script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>管理中心</span>
</div>
<!--/导航栏-->

<!--内容-->
<div class="line10"></div>
<div class="line10"></div>
     <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">借款待审批列表</a></li>
                    </ul>
                </div>
            </div>
        </div>
     <div class="table-container">
      <asp:Repeater ID="rptList" runat="server">
      <HeaderTemplate>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
        <tr>
          <th width="12%">姓名</th>
          <th align="left" width="12%">会员号</th>
          <th align="left" width="12%">借款金额</th>
          <th align="left" width="12%">借款用途</th>
          <th align="left" width="12%">联系方式</th>
        </tr>
      </HeaderTemplate>
      <ItemTemplate>
        <tr>
            <td align="center"><%# Eval("name") %></td>
            <td><%# Eval("member_no") %></td>
            <td><%# Eval("amount") %></td>
            <td><%# Eval("purpose") %></td>
            <td><%# Eval("tel") %></td>
    </tr>
  </ItemTemplate>
  <FooterTemplate>
    <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"8\">暂无记录</td></tr>" : ""%>
  </table>
  </FooterTemplate>
  </asp:Repeater>
</div>

     <div id="floatHead1" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">汇总信息</a></li>
                    </ul>
                </div>
            </div>
        </div>
     <!--列表-->
        <div class="table-container">
            <asp:Repeater ID="rptTotal" runat="server">
                <HeaderTemplate>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
                        <tr>
                            <th>贷款数量</th>
                            <th align="left">会员数量</th>
                            <th align="left">新增会员数量</th>
                            <th align="left">退会数量</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center"><%# Eval("DaikuanCount") %></td>
                        <td><%# Eval("MemberCount") %></td>
                        <td><%# Eval("NewMemCount") %></td>
                        <td><%# Eval("ExitCount") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <%#rptTotal.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"8\">暂无记录</td></tr>" : ""%>
  </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <!--/列表-->

<div class="line20"></div>

    <div id="floatHead2" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">会员统计</a></li>
                    </ul>
                </div>
            </div>
        </div>
     <!--列表-->
        <div class="table-container">
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
        </div>

 <%--   <asp:Chart ID="Chart4" runat="server">
            <series>
                <asp:Series ChartType="Line" IsValueShownAsLabel="True" Label="#VALX:#VAL" Legend="Legend1" Name="Series1">
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
        </asp:Chart>--%>
        <!--/列表-->


</form>
</body>
</html>
