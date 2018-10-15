<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="daikuan_list.aspx.cs" Inherits="DTcms.Web.admin.manager.daikuan_list" ValidateRequest="false" %>

<%@ Import Namespace="DTcms.Common" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>会员借款审批表</title>
    <link rel="stylesheet" href="../skin/css/global.css">
    <link rel="stylesheet" href="../skin/css/application.css">
    <script src="../skin/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="loan-1200">
            <h1 class="center margin-b-20">陕西省汉阴县
                <asp:DropDownList ID="cunlist" runat="server" datatype="*" errormsg="请选择！" sucmsg=" "></asp:DropDownList>
                村扶贫互助资金协会会员借款审批表
            </h1>
            <div class="text-r margin-b-20">
                <asp:DropDownList ID="agesye" runat="server"></asp:DropDownList>年
            </div>
            <div class="display-i-b pct-w20 margin-b-20">
                姓名：
                <asp:TextBox ID="name" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w10 margin-b-20">
                <label>性别：</label>
                    <asp:DropDownList id="rblGender" runat="server" datatype="*" errormsg="请选择性别" sucmsg=" ">
                              <asp:ListItem Value="男">男</asp:ListItem>
                              <asp:ListItem Value="女">女</asp:ListItem>
                             </asp:DropDownList>
                
            </div>
            <div class="display-i-b pct-w10 margin-b-20 text-r">
                年龄： 
                    <asp:DropDownList ID="age" runat="server"></asp:DropDownList>
            </div>
            <div class="display-i-b pct-w20 margin-b-20 text-r">
                配偶姓名：
                <asp:TextBox ID="peiouxingming" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w20 margin-b-20 text-r">
                继承人姓名：
                <asp:TextBox ID="jichengren" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w20 margin-b-20 text-r">
                村组：
                <asp:TextBox ID="cunzu" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w50 margin-b-20">
                家庭年收入（元）
                <asp:TextBox ID="jiatingshouru" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w50 margin-b-20">
                借款用途（项目）：
                <asp:TextBox ID="jiekuanyongtu" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w50 margin-b-20">
                借款金额（元）
                <asp:TextBox ID="jiekuanjine" runat="server"></asp:TextBox>
            </div>
            <div class="display-i-b pct-w50 margin-b-20">
                借款期限：
                <asp:TextBox ID="jiekuanstart" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />至
                <asp:TextBox ID="jiekuanend" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
            </div>


            <div class="shenqin clearfix margin-b-80 margin-t-40">
                <div class="display-i-b pct-w20  left height-auto">
                    会员借款申请
                </div>
                <div class="display-i-b pct-w80  left height-auto">
                    <p class="margin-b-10">村扶贫互助资金协会：</p>
                    <p class="margin-b-20">
                        因我家要<asp:TextBox ID="shenqings1" runat="server" class="y-1"></asp:TextBox>
                        尚缺部分资金，将申请贷款<asp:TextBox runat="server" ID="shenqings2" class="y-2"></asp:TextBox>
                        元（大写：<asp:TextBox ID="shenqings3" class="y-2" runat="server"></asp:TextBox>
                        ），并经第<asp:TextBox ID="shenqings4" class="y-2" runat="server"></asp:TextBox>互助联保小组联保请村扶贫互助资金协会给予扶持。借款落实后，将按审定的资金用途使用，保证按期还借款本金及占用金，如到期不能及时偿还本金及占用费，我愿意承担法律责任并接受一切违约处罚。
                    </p>
                    <p class="text-r padding-r-100 margin-b-20">申请人签字：</p>
                    <p class="text-r">时间：<asp:TextBox ID="jiekuantime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " /><%--<input type="date" id="jiekuantime" runat="server">--%></p>
                </div>
            </div>
            <div class="shenqin clearfix margin-b-80">
                <div class="display-i-b pct-w20  left height-auto">
                    互助联保小组意见
                </div>
                <div class="display-i-b pct-w80  left height-auto">
                    <p class="margin-b-20">经本互助联保小组研究，同意借款，并由<asp:TextBox ID="xiaozuyijian1" runat="server" class="y-1"></asp:TextBox>和<asp:TextBox ID="xiaozuyijian2" runat="server" class="y-1"></asp:TextBox>担任第一，二位代偿人。</p>
                    <p class="text-r padding-r-100 margin-b-20">互助联保小组组长签字：</p>
                    <p class="text-r">时间：<asp:TextBox ID="xiaozutime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " /><%--<input type="date" runat="server" id="xiaozutime">--%></p>
                </div>
            </div>
            <div class="shenqin clearfix margin-b-80">
                <div class="display-i-b pct-w20  left height-auto">
                    协会理事会审批意见
                </div>
                <div class="display-i-b pct-w80  left height-auto">
                    <p class="text-r padding-r-100 margin-b-20">理事长签字（盖章）：</p>
                    <p class="text-r">时间：<asp:TextBox ID="xieshenpiyijian" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " /><%--<input type="date" runat="server" id="xieshenpiyijian">--%></p>
                </div>
            </div>
            <div class="shenqin clearfix margin-b-20 margin-b-40">
                <div class="display-i-b pct-w20  left height-auto">
                    协会监视会审查意见
                </div>
                <div class="display-i-b pct-w80  left height-auto">
                    <p class="text-r padding-r-100 margin-b-20">监视会主任签字（盖章）：</p>
                    <p class="text-r">时间：<asp:TextBox ID="jianshiyijian" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " /><%--<input id="jianshiyijian" type="date" runat="server">--%></p>
                </div>
            </div>
            <div class="color-red margin-b-40">
                注：此表由借款会员填写后交互助联保小组组长，互助联保小组签署意见后交村协会审批。
            </div>
            <div class="btn-wrap center">
                <asp:Button ID="btnSubmited" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmited_Click" />
            </div>
        </div>
    </form>
</body>
</html>
