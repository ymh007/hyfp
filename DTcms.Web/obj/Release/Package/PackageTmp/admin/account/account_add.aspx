<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="account_add.aspx.cs" Inherits="DTcms.Web.admin.account.account_add" ValidateRequest="false" %>

<%@ Import Namespace="DTcms.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>财务管理</title>
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
            $(".upload-album0").InitUploader({ index: 0, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album1").InitUploader({ index: 1, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album2").InitUploader({ index: 2, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album3").InitUploader({ index: 3, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album4").InitUploader({ index: 4, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album5").InitUploader({ index: 5, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album6").InitUploader({ index: 6, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album7").InitUploader({ index: 7, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album8").InitUploader({ index: 8, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });
            $(".upload-album9").InitUploader({ index: 9, btntext: "批量上传", multiple: true, water: false, thumbnail: false, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });

            //设置封面图片的样式
            $(".photo-list ul li .img-box img").each(function () {
                if ($(this).attr("src") == $("#hidFocusPhoto").val()) {
                    $(this).parent().addClass("selected");
                }
            });
        });

        function addImage(targetObj, originalSrc, thumbSrc, index) {
            //插入到相册UL里面
            var newLi = $('<li>'
            + '<input type="hidden" name="hid_photo_name' + index + '" value="0|' + originalSrc + '|' + thumbSrc + '" />'
            + '<input type="hidden" name="hid_photo_remark' + index + '" value="" />'
            + '<input type="hidden" name="hid_photo_link_url' + index + '" value="" />'
            + '<div class="img-box" onclick="setFocusImg(this);" style="width:30px;height:30px;">'
            + '<img src="' + thumbSrc + '" bigsrc="' + originalSrc + '" style="width:30px;height:30px;"/>'

            + '</div>'
             + '<a href="javascript:;" onclick="delImg(this);">删除</a>'
            + '</li>');
            newLi.appendTo(targetObj.siblings(".photo-list").children("ul"));

            //默认第一个为相册封面
            var focusPhotoObj = targetObj.siblings(".focus-photo");
            if (focusPhotoObj.val() == "") {
                focusPhotoObj.val(thumbSrc);
                newLi.children(".img-box").addClass("selected");
            }
        }
    </script>
    <style>
        .select {
            width: 150px;
            height: 30px;
        }
    </style>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
            <a href="account_list.aspx" class="back"><i></i><span>返回列表页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <a href="account_list.aspx"><span>财务管理</span></a>
            <i class="arrow"></i>
            <span>财务管理</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">财务管理</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="tab-content">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
                <tr>
                    <th align="left" style="padding-left: 15px;" width="8%">协会名称</th>
                    <th align="left" width="5%">科目大类</th>
                    <th align="left" width="5%">科目小类</th>
                    <th align="left" width="5%">日期</th>
                    <th align="left" width="8%">借</th>
                    <th align="left" width="8%">贷</th>
                    <th align="left" width="8%">摘要</th>
                    <th align="left" width="8%">附件</th>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui0" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject0" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject0" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime0" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie0" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai0" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao0" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album0"></div>
                        <input type="hidden" name="hidFocusPhoto0" id="hidFocusPhoto0" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui1" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject1" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject1" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime1" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie1" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai1" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao1" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto1" id="hidFocusPhoto1" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui2" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject2" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject2" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime2" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie2" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai2" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao2" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto2" id="hidFocusPhoto2" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui3" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject3" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject3" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime3" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie3" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai3" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao3" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto3" id="hidFocusPhoto3" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui4" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject4" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject4" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime4" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie4" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai4" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao4" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto4" id="hidFocusPhoto4" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui5" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject5" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject5" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime5" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie5" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai5" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao5" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto5" id="hidFocusPhoto5" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui6" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject6" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject6" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime6" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie6" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai6" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao6" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto6" id="hidFocusPhoto6" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui7" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject7" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject7" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime7" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie7" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai7" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao7" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto7" id="hidFocusPhoto7" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui8" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject8" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject8" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime8" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie8" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai8" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao8" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto8" id="hidFocusPhoto8" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlXiehui9" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlBSubject9" runat="server" CssClass="select" AutoPostBack="true" OnSelectedIndexChanged="subjcet_Change_Click"></asp:DropDownList></td>
                    <td>
                        <asp:DropDownList ID="ddlSSubject9" runat="server" CssClass="select"></asp:DropDownList></td>
                    <td>
                        <asp:TextBox ID="txtAddTime9" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" datatype="/^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$" errormsg="请选择正确的日期" sucmsg=" " /></td>
                    <td>
                        <asp:TextBox ID="txtJie9" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtDai9" runat="server" CssClass="input" sucmsg=" "></asp:TextBox></td>
                    <td>
                        <asp:TextBox ID="txtZhaiyao9" runat="server" CssClass="input"></asp:TextBox></td>
                    <td>
                        <div class="upload-box upload-album1"></div>
                        <input type="hidden" name="hidFocusPhoto9" id="hidFocusPhoto9" runat="server" class="focus-photo" />
                        <div class="photo-list">
                            <ul>
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>
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
