<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="daikuan_edit.aspx.cs" Inherits="DTcms.Web.admin.daikuan.daikuan_edit" ValidateRequest="false" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>编辑借款明细</title>
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
            $(".upload-album").InitUploader({ btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });

            //设置封面图片的样式
            $(".photo-list ul li .img-box img").each(function () {
                if ($(this).attr("src") == $("#hidFocusPhoto").val()) {
                    $(this).parent().addClass("selected");
                }
            });
        });
    </script>
    <style>
        .tab-content a {
            display: inline-block;
            margin-left: -1px;
            padding: 5px 10px 5px 8px;
            line-height: 20px;
            height: 20px;
            border: solid 1px #eee;
            color: #333;
            font-size: 12px;
            text-decoration: none;
            background: #fafafa;
            white-space: nowrap;
            word-break: break-all;
        }
    </style>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
            <a href="daikuan_list.aspx" class="back"><i></i><span>返回列表页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <a href="daikuan_list.aspx"><span>借款管理</span></a>
            <i class="arrow"></i>
            <span>编辑借款明细</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">管理员信息</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="tab-content">
            <asp:TextBox ID="txtMemberId" runat="server" CssClass="input normal" Visible="false"></asp:TextBox>
            <dl>
                <dt>借款人姓名</dt>
                <dd>
                    <asp:TextBox ID="txtName" runat="server" CssClass="input normal" datatype="*1-100" sucmsg=" " ReadOnly="true"></asp:TextBox>
                    <a class="add" href="member_choose.aspx?action=<%=action %>&id=<%=id %>&type=1"><i></i><span>选择会员</span></a>
                    <span class="Validform_checktip">*字母、下划线，不可修改</span></dd>

            </dl>
             <dl>
                <dt>会员等级</dt>
                <dd>
                     <asp:TextBox ID="txtLevel" runat="server" CssClass="input normal" Visible="false"></asp:TextBox>
                    <asp:TextBox ID="txtLevelName" runat="server" CssClass="input normal" ReadOnly="true"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>性别</dt>
                <dd>
                    <asp:TextBox ID="txtGender" runat="server" CssClass="input normal" ReadOnly="true"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>身份证号码</dt>
                <dd>
                    <asp:TextBox ID="txtIdCard" runat="server" CssClass="input normal" ReadOnly="true"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>电话</dt>
                <dd>
                    <asp:TextBox ID="txtTel" runat="server" CssClass="input normal" ReadOnly="true"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>会员证号码</dt>
                <dd>
                    <asp:TextBox ID="txtMember" runat="server" CssClass="input normal" ReadOnly="true"></asp:TextBox></dd>
            </dl>
             <dl>
                <asp:TextBox ID="txtLbIds" runat="server" CssClass="input normal" Visible="false"></asp:TextBox>
                <dt>互助联保人</dt>
                <dd>
                    <asp:TextBox ID="txtLbNames" runat="server" CssClass="input normal" sucmsg=" " datatype="*1-100" ReadOnly="true"></asp:TextBox>
                    <a class="add" href="member_choose.aspx?action=<%=action %>&id=<%=choose_id %>&type=2"><i></i><span>互助联保人</span></a>
                    <span class="Validform_checktip">*字母、下划线，不可修改</span></dd>
            </dl>
            <asp:TextBox ID="txtMemberAmount" runat="server" CssClass="input normal" Visible="false"></asp:TextBox>
            <dl>
                <dt>可借款金额</dt>
                <dd>
                    <asp:TextBox ID="txtCanAmount" runat="server" CssClass="input" ReadOnly="true"></asp:TextBox></dd>
            </dl>
             <dl>
                <dt>借款金额</dt>
                <dd>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="input" datatype="n" sucmsg=" "></asp:TextBox>
                     <span class="Validform_checktip">*数字</span></dd>
            </dl>
            <dl>
                <dt>借款时长</dt>
                <dd>
                    <asp:TextBox ID="txtMonth" runat="server" CssClass="input" datatype="n" sucmsg=" "></asp:TextBox>
                     <span class="Validform_checktip">*借款月数</span></dd>
            </dl>
            <dl>
                <dt>产业规模</dt>
                <dd>
                    <div class="rule-single-select">
                        <asp:DropDownList ID="ddlChanYe" runat="server" datatype="*" errormsg="请选择产业规模" sucmsg=" "></asp:DropDownList>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>借款用途</dt>
                <dd>
                    <asp:TextBox ID="txtPurpose" runat="server" CssClass="input" TextMode="MultiLine"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>备注</dt>
                <dd>
                    <asp:TextBox ID="txtRemark" runat="server" CssClass="input" TextMode="MultiLine"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>发布时间</dt>
                <dd>
                    <asp:TextBox ID="txtAddTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
                    <span class="Validform_checktip">不选择默认当前发布时间</span>
                </dd>
            </dl>
            <dl id="div_albums_container" runat="server">
                <dt>图片相册</dt>
                <dd>
                    <div class="upload-box upload-album"></div>
                    <input type="hidden" name="hidFocusPhoto" id="hidFocusPhoto" runat="server" class="focus-photo" />
                    <div class="photo-list">
                        <ul>
                            <asp:Repeater ID="rptAlbumList" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <input type="hidden" name="hid_photo_name" value="<%#Eval("id")%>|<%#Eval("original_path")%>|<%#Eval("thumb_path")%>" />
                                        <input type="hidden" name="hid_photo_remark" value="<%#Eval("remark")%>" />
                                        <input type="hidden" name="hid_photo_link_url" value="<%#Eval("link_url")%>" />
                                        <div class="img-box" onclick="setFocusImg(this);">
                                            <img src="<%#Eval("thumb_path")%>" bigsrc="<%#Eval("original_path")%>" />
                                            <span class="remark"><i><%#Eval("remark").ToString() == "" ? "暂无描述..." : Eval("remark").ToString()%></i></span>
                                        </div>
                                        <a href="javascript:;" onclick="setLinkurl(this);">链接</a>
                                        <a href="javascript:;" onclick="setRemark(this);">描述</a>
                                        <a href="javascript:;" onclick="delImg(this);">删除</a>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </dd>
            </dl>
            <div id="field_tab_content" runat="server" visible="false"></div>
        </div>
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
