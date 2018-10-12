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
        <!--导航栏-->
        <div class="location">
            <a href="member_list.aspx" class="back"><i></i><span>返回列表页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <a href="member_list.aspx"><span>会员管理</span></a>
            <i class="arrow"></i>
            <span>编辑会员</span>
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
           <dl>
            <dt>所属乡镇</dt>
            <dd>
              <div class="rule-single-select">
                <asp:DropDownList id="ddlTown" runat="server" datatype="*" errormsg="请选择所属乡镇" sucmsg=" " AutoPostBack="true" OnSelectedIndexChanged="town_Change_Click"></asp:DropDownList>
              </div>
            </dd>
          </dl>
            <dl>
            <dt>所属村</dt>
            <dd>
              <div class="rule-single-select">
                <asp:DropDownList id="ddlVillage" runat="server" datatype="*" errormsg="请选择所属村" sucmsg=" "></asp:DropDownList>
              </div>
            </dd>
          </dl>
            <dl>
                <dt>会员证号码</dt>
                <dd>
                    <asp:TextBox ID="txtNo" runat="server" CssClass="input normal" datatype="/^[a-zA-Z0-9\-\_]{2,50}$/" sucmsg=" " ajaxurl="../../tools/admin_ajax.ashx?action=member_validate"></asp:TextBox>
                    <span class="Validform_checktip">*字母、下划线，不可修改</span></dd>
            </dl>
            <dl>
                <dt>姓名</dt>
                <dd>
                    <asp:TextBox ID="txtName" runat="server" CssClass="input normal" datatype="*1-100" sucmsg=" "></asp:TextBox>
                    <span class="Validform_checktip">*姓名必填</span></dd>
            </dl>
            <dl>
                <dt>会员类别</dt>
                <dd>
                    <div class="rule-multi-radio">
                        <asp:RadioButtonList ID="rblType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="0" Selected="True">常规会员</asp:ListItem>
                            <asp:ListItem Value="1">贫困户会员</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>会员等级</dt>
                <dd>
                    <div class="rule-single-select">
                        <asp:DropDownList ID="ddlMemberLevel" runat="server" datatype="*" errormsg="请选择会员等级" sucmsg=" "></asp:DropDownList>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>性别</dt>
                <dd>
                    <div class="rule-multi-radio">
                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="0" Selected="True">男</asp:ListItem>
                            <asp:ListItem Value="1">女</asp:ListItem>
                            <asp:ListItem Value="">暂无</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>身份证号码</dt>
                <dd>
                    <asp:TextBox ID="txtIdCard" runat="server" CssClass="input normal"></asp:TextBox></dd>
            </dl>
             <dl>
                <dt>身份证正面图</dt>
                <dd>
                    <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path" />
                    <div class="upload-box upload-img"></div>
                </dd>
            </dl>
            <dl>
                <dt>电话</dt>
                <dd>
                    <asp:TextBox ID="txtTel" runat="server" CssClass="input normal"></asp:TextBox></dd>
            </dl>
          
            <dl>
                <dt>基准互助金</dt>
                <dd>
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="input small" datatype="n" sucmsg=" "></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>可借款金额</dt>
                <dd>
                    <asp:TextBox ID="txtCanAmount" runat="server" CssClass="input" ReadOnly="true"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>缴纳会费时间</dt>
                <dd>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
                    <span class="Validform_checktip">不选择默认当前发布时间</span>
                </dd>
            </dl>
            <dl>
                <dt>配股</dt>
                <dd>
                    <asp:TextBox ID="txtPeigu" runat="server" CssClass="input small" datatype="n" sucmsg=" " Visible="false"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>优惠金额</dt>
                <dd>
                    <asp:TextBox ID="txtYh" runat="server" CssClass="input small" datatype="n" sucmsg=" " Visible="false"></asp:TextBox></dd>
            </dl>
            <dl>
                <dt>发布时间</dt>
                <dd>
                    <asp:TextBox ID="txtAddTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
                    <span class="Validform_checktip">不选择默认当前发布时间</span>
                </dd>
            </dl>
            <dl>
                <dt>备注</dt>
                <dd>
                    <asp:TextBox ID="txtRemark" runat="server" CssClass="input" TextMode="MultiLine"></asp:TextBox></dd>
            </dl>

            <!--业务审核文件-->
            <dl id="div_albums_container" runat="server">
                <dt>业务审核文件</dt>
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
            <!--业务审核文件-->

            <!--财务凭证-->
            <dl id="Dl1" runat="server">
                <dt>财务凭证</dt>
                <dd>
                    <div class="upload-box upload-album-cw"></div>
                    <input type="hidden" name="hidFocusPhoto" id="Hidden1" runat="server" class="focus-photo" />
                    <div class="photo-list">
                        <ul>
                            <asp:Repeater ID="rptCwList" runat="server">
                                <ItemTemplate>
                                    <li>
                                        <input type="hidden" name="hid_photo_cw_name" value="<%#Eval("id")%>|<%#Eval("original_path")%>|<%#Eval("thumb_path")%>" />
                                        <input type="hidden" name="hid_photo_cw_remark" value="<%#Eval("remark")%>" />
                                        <input type="hidden" name="hid_photo_cw_link_url" value="<%#Eval("link_url")%>" />
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
            <!--财务凭证-->
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
