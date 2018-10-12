<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="member_edit.aspx.cs" Inherits="DTcms.Web.admin.member.member_edit" ValidateRequest="false" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>编辑会员</title>
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

    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/application.css">
    <script src="js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            //初始化表单验证
            $("#form1").initValidform();
            $(".upload-album").InitUploader({ btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album-cw").InitUploader({ btntext: "批量上传", multiple: true, water: false, thumbnail: false, index: 1, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });

            //初始化上传控件
            $(".upload-img").InitUploader({ filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf", filetypes: "<%=siteConfig.fileextension %>" });
            //设置封面图片的样式
            $(".photo-list ul li .img-box img").each(function () {
                if ($(this).attr("src") == $("#hidFocusPhoto").val()) {
                    $(this).parent().addClass("selected");
                }
            });
        });
    </script>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <div id="bodyer">
        <h1 class="center margin-b-20">陕西省汉阴县
            <asp:DropDownList id="ddlTown" runat="server" datatype="*" errormsg="请选择所属乡镇" sucmsg=" " AutoPostBack="true" OnSelectedIndexChanged="town_Change_Click"></asp:DropDownList>镇
            <asp:DropDownList id="ddlVillage" runat="server" datatype="*" errormsg="请选择所属村" sucmsg=" " AutoPostBack="true" OnSelectedIndexChanged="village_Change_Click"></asp:DropDownList>村扶贫互助资金协会入会申请表
        </h1>
        <div class="display-i-b pct-w50 margin-b-20">
                申请人家庭地址：<asp:TextBox ID="txtAddress" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
        </div><div class="display-i-b pct-w50 margin-b-20">
                会员证编号：<asp:TextBox ID="txtNo" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
        </div>
        <div class="display-i-b pct-w20 margin-b-20">
            姓名：<asp:TextBox ID="txtName" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
        </div><div class="display-i-b pct-w20 margin-b-20">
                       性别：<asp:DropDownList id="rblGender" runat="server" datatype="*" errormsg="请选择性别" sucmsg=" ">
                              <asp:ListItem Value="男">男</asp:ListItem>
                              <asp:ListItem Value="女">女</asp:ListItem>
                             </asp:DropDownList>
        </div><div class="display-i-b pct-w20 margin-b-20">
                    出生年月：<asp:TextBox ID="txtBirthday" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " />
        </div><div class="display-i-b pct-w20 margin-b-20">
                        文化程度：<asp:DropDownList id="ddlEducation" runat="server" datatype="*" errormsg="请选择文化程度" sucmsg=" ">
                              <asp:ListItem Value="小学">小学</asp:ListItem>
                              <asp:ListItem Value="初中">初中</asp:ListItem>
                              <asp:ListItem Value="高中">高中</asp:ListItem>
                              <asp:ListItem Value="大专">大专</asp:ListItem>
                              <asp:ListItem Value="本科">本科</asp:ListItem>
                             </asp:DropDownList>
        </div><div class="display-i-b pct-w20 margin-b-20">
            身份证编号：<asp:TextBox ID="txtIdCard" runat="server" CssClass="input"></asp:TextBox>
        </div>
        <div class="margin-b-20">
            入会缴纳互助金（元）：<asp:TextBox ID="txtAmount" runat="server" CssClass="input small" datatype="n" sucmsg=" "></asp:TextBox>
        </div>
        <div class="center margin-b-20">
            <h2>家庭主要成员</h2>
        </div>
        <div class="member margin-b-20">
        <div class="margin-b-20">
            <div class="display-i-b pct-w5">
            </div><div class="display-i-b pct-w19">
                    姓名：<asp:TextBox ID="txtFamilyName1" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
                </div><div class="display-i-b pct-w19">
                        性别：<asp:DropDownList id="ddlFamilyGender1" runat="server" datatype="*" errormsg="请选择性别" sucmsg=" ">
                              <asp:ListItem Value="男">男</asp:ListItem>
                              <asp:ListItem Value="女">女</asp:ListItem>
                             </asp:DropDownList>
                </div><div class="display-i-b pct-w19">
                        与申请人关系：<asp:TextBox ID="txtFamilyRel1" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
                </div><div class="display-i-b pct-w19">
                        出生年月：<asp:TextBox ID="txtFamilyBir1" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " />
                </div><div class="display-i-b pct-w19">
                        文化程度：<asp:DropDownList id="ddlFamilyEdu1" runat="server" datatype="*" errormsg="请选择文化程度" sucmsg=" ">
                              <asp:ListItem Value="小学">小学</asp:ListItem>
                              <asp:ListItem Value="初中">初中</asp:ListItem>
                              <asp:ListItem Value="高中">高中</asp:ListItem>
                              <asp:ListItem Value="大专">大专</asp:ListItem>
                              <asp:ListItem Value="本科">本科</asp:ListItem>
                              <asp:ListItem Value="研究生及以上">研究生及以上</asp:ListItem>
                             </asp:DropDownList>
                </div>
        </div>
        <div class="margin-b-20">
                <div class="display-i-b pct-w5">
                </div><div class="display-i-b pct-w19">
                        姓名：<asp:TextBox ID="txtFamilyName2" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
                    </div><div class="display-i-b pct-w19">
                            性别：<asp:DropDownList id="ddlFamilyGender2" runat="server" datatype="*" errormsg="请选择性别" sucmsg=" ">
                              <asp:ListItem Value="男">男</asp:ListItem>
                              <asp:ListItem Value="女">女</asp:ListItem>
                             </asp:DropDownList>
                    </div><div class="display-i-b pct-w19">
                            与申请人关系：<asp:TextBox ID="txtFamilyRel2" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
                    </div><div class="display-i-b pct-w19">
                            出生年月：<asp:TextBox ID="txtFamilyBir2" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " />
                    </div><div class="display-i-b pct-w19">
                            文化程度：<asp:DropDownList id="ddlFamilyEdu2" runat="server" datatype="*" errormsg="请选择文化程度" sucmsg=" ">
                              <asp:ListItem Value="小学">小学</asp:ListItem>
                              <asp:ListItem Value="初中">初中</asp:ListItem>
                              <asp:ListItem Value="高中">高中</asp:ListItem>
                              <asp:ListItem Value="大专">大专</asp:ListItem>
                              <asp:ListItem Value="本科">本科</asp:ListItem>
                              <asp:ListItem Value="研究生及以上">研究生及以上</asp:ListItem>
                             </asp:DropDownList>
                    </div>
            </div>
             <div class="margin-b-20">
                <div class="display-i-b pct-w5">
                </div><div class="display-i-b pct-w19">
                        姓名：<asp:TextBox ID="txtFamilyName3" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
                    </div><div class="display-i-b pct-w19">
                            性别：<asp:DropDownList id="ddlFamilyGender3" runat="server" datatype="*" errormsg="请选择性别" sucmsg=" ">
                              <asp:ListItem Value="男">男</asp:ListItem>
                              <asp:ListItem Value="女">女</asp:ListItem>
                             </asp:DropDownList>
                    </div><div class="display-i-b pct-w19">
                            与申请人关系：<asp:TextBox ID="txtFamilyRel3" runat="server" CssClass="input" datatype="*1-100" sucmsg=" "></asp:TextBox>
                    </div><div class="display-i-b pct-w19">
                            出生年月：<asp:TextBox ID="txtFamilyBir3" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " />
                    </div><div class="display-i-b pct-w19">
                            文化程度：<asp:DropDownList id="ddlFamilyEdu3" runat="server" datatype="*" errormsg="请选择文化程度" sucmsg=" ">
                              <asp:ListItem Value="小学">小学</asp:ListItem>
                              <asp:ListItem Value="初中">初中</asp:ListItem>
                              <asp:ListItem Value="高中">高中</asp:ListItem>
                              <asp:ListItem Value="大专">大专</asp:ListItem>
                              <asp:ListItem Value="本科">本科</asp:ListItem>
                              <asp:ListItem Value="研究生及以上">研究生及以上</asp:ListItem>
                             </asp:DropDownList>
                    </div>
            </div>
        </div>


            <div class="shenqin clearfix margin-b-20">
                <div class="display-i-b pct-w20 s1 left">
                                申请人承诺
                </div>
                <div class="display-i-b pct-w80 s2 left">
                    <p>经过慎重考虑，本人自愿加入<asp:TextBox ID="txtVillage" runat="server" CssClass="input small" ReadOnly="true"></asp:TextBox> 村扶贫互助资金协会，自愿缴纳入会资金。我将遵守扶贫互助协会章程，按照扶贫互助协会规章制度使用好互助资金，按期准时偿还借款本金和占用费。</p>
                    <p>我自愿遵守互助联保的所有制度，并将严格做到以下几点：</p>
                    <p>（1）如果我所在互助联保小组的任何成员不能偿还其借款我和我同组的其他成员有义务替他偿还；（2）如我所在互助联保小组的任何小组成员未能偿还或逾期偿还，与我同组的其他成员今后不能获得借款；（3）如果我本人和所在互助联保小组有人未偿还完借款，我不能退互助金；（4）我及互助联保小组所有成员对借款项目的实施进行相互督促、相互帮助、相互监督。</p>
                </div>
            </div>
            <div class="shenqin clearfix margin-b-20">
                    <div class="display-i-b pct-w20 s1 left">
                                    申请人签名
                    </div>
                    <div class="display-i-b pct-w80 s2 left">
                        <p>上述承诺是本人真实意愿表达。</p>
                        <div class="clearfix">
                                <p class="right padding-r-100 margin-b-20">签名（盖章）：</p>
                        </div>
                        <p class="right">申请时间：<asp:TextBox ID="txtAddTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " /></p>
                    </div>
                </div>
                <div class="shenqin clearfix margin-b-20">
                        <div class="display-i-b pct-w20 s1 left">
                                        协会意见
                        </div>
                        <div class="display-i-b pct-w80 s2 left">
                            <p>符合入会条件，同意在其加纳互助金后，加入本协会。</p>
                            <div class="clearfix">
                                    <p class="right padding-r-100 margin-b-20">理事长签名（盖章）：</p>
                            </div>
                            <p class="right"> 批准时间：<asp:TextBox ID="TextBox1" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " /></p>
                        </div>
                    </div>
                    <div class="center">
            <div class="btn-wrap">
                <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmit_Click" />
            </div>
                    </div>
        
    </div>
    <script>
        $(function () {
            var html = '<div class="margin-b-20"><div class="display-i-b pct-w5"><input type="checkbox" name="member"></div><div class="display-i-b pct-w19">姓名：<input type="text"></div><div class="display-i-b pct-w19">性别：<input type="text"></div><div class="display-i-b pct-w19">与申请人关系：<input type="text"></div><div class="display-i-b pct-w19">出生年月：<input type="date"></div><div class="display-i-b pct-w19">文化程度：<input type="text"></div></div>';
            $(".xinjian").on("click", function () {
                $(".member").append(html);
            })
            $(".shanchu").click(function () {
                $("input[name='member']:checked").each(function () {
                    $(this).parent().parent().remove();
                })
            })
        })
    </script>
    </form>
</body>
</html>
