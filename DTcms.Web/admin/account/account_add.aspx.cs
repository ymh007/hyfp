using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using System.Web.UI.HtmlControls;
using System.Text;

namespace DTcms.Web.admin.account
{
    public partial class account_add : Web.UI.ManagePage
    {
        private string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;

        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = DTRequest.GetQueryString("action");
            if (!string.IsNullOrEmpty(_action) && _action == DTEnums.ActionEnum.Edit.ToString())
            {
                this.action = DTEnums.ActionEnum.Edit.ToString();//修改类型
                if (!int.TryParse(Request.QueryString["id"] as string, out this.id))
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.account().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                TreeBind();
                ChkAdminLevel("account_list", DTEnums.ActionEnum.View.ToString()); //检查权限
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.xiehui bll = new BLL.xiehui();
            DataTable dt = bll.GetList("").Tables[0];
            for (int i = 0; i < 10; i++)
            {
                DropDownList ddlXiehui = FindControl("ddlXiehui" + i) as DropDownList;
                ddlXiehui.Items.Clear();
                ddlXiehui.Items.Add(new ListItem("请选择协会", "0"));
                foreach (DataRow dr in dt.Rows)
                {
                    string Id = dr["id"].ToString();
                    string Title = dr["name"].ToString().Trim();
                    ddlXiehui.Items.Add(new ListItem(Title, Id));
                }

                BLL.subject subjectBll = new BLL.subject();
                DataTable dtSubject = subjectBll.GetParentList(0);

                DropDownList ddlBSubject = FindControl("ddlBSubject" + i) as DropDownList;
                ddlBSubject.Items.Clear();
                ddlBSubject.Items.Add(new ListItem("请选择科目大类", "0"));
                foreach (DataRow dr in dtSubject.Rows)
                {
                    string Id = dr["id"].ToString();
                    string Title = dr["name"].ToString().Trim();
                    ddlBSubject.Items.Add(new ListItem(Title, Id));
                }
            }

        }
        #endregion

        #region 增加操作=================================
        private int DoAdd()
        {
            var successCount = 0;
            for (int i = 0; i < 10; i++)
            {
                DropDownList ddlXiehui = FindControl("ddlXiehui" + i) as DropDownList;
                DropDownList ddlBSubject = FindControl("ddlBSubject" + i) as DropDownList;
                DropDownList ddlSSubject = FindControl("ddlSSubject" + i) as DropDownList;
                TextBox txtAddTime = FindControl("txtAddTime" + i) as TextBox;
                TextBox txtJie = FindControl("txtJie" + i) as TextBox;
                TextBox txtDai = FindControl("txtDai" + i) as TextBox;
                TextBox txtZhaiyao = FindControl("txtZhaiyao" + i) as TextBox;

                if (ddlXiehui.SelectedValue.ToString() != "0")
                {
                    if (ddlBSubject.SelectedValue.ToString() == "0")
                    {
                        JscriptMsg("请选择大类！", "");
                        return 0;
                    }
                    if (ddlSSubject.SelectedValue.ToString() == "0")
                    {
                        JscriptMsg("请选择小类！", "");
                        return 0;
                    }

                    Model.account model = new Model.account();
                    BLL.account bll = new BLL.account();
                    model.xiehui_id = Utils.StrToInt(ddlXiehui.SelectedValue, 0);
                    model.b_subject = Utils.StrToInt(ddlBSubject.SelectedValue, 0);
                    model.s_subject = Utils.StrToInt(ddlSSubject.SelectedValue, 0);
                    model.date = Utils.StrToDateTime(txtAddTime.Text.Trim()).Date;
                    model.jie = Utils.StrToDecimal(Utils.ObjectToStr(txtJie.Text.Trim()), 0);
                    model.dai = Utils.StrToDecimal(Utils.ObjectToStr(txtDai.Text.Trim()), 0);
                    model.zhaiyao = txtZhaiyao.Text.Trim();
                    #region 保存相册====================
                    string[] albumArr = Request.Form.GetValues("hid_photo_name" + i);
                    string[] remarkArr = Request.Form.GetValues("hid_photo_remark" + i);
                    string[] link_urlArr = Request.Form.GetValues("hid_photo_link_url" + i);
                    if (albumArr != null && albumArr.Length > 0)
                    {
                        List<Model.account_albums> ls = new List<Model.account_albums>();
                        for (int j = 0; j < albumArr.Length; j++)
                        {
                            string[] imgArr = albumArr[j].Split('|');
                            if (imgArr.Length == 3)
                            {
                                if (!string.IsNullOrEmpty(link_urlArr[j]))
                                {
                                    ls.Add(new Model.account_albums { original_path = imgArr[1], thumb_path = imgArr[2], link_url = link_urlArr[j] });
                                }
                                if (!string.IsNullOrEmpty(remarkArr[j]))
                                {
                                    ls.Add(new Model.account_albums { original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[j] });
                                }
                                else
                                {
                                    ls.Add(new Model.account_albums { original_path = imgArr[1], thumb_path = imgArr[2] });
                                }
                            }
                        }
                        model.albums = ls;
                    }
                    #endregion
                    if (bll.Add(model) > 0)
                    {
                        //AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加记账信息:" + model.name); //记录日志
                        successCount++;
                    }

                }
            }
            return successCount;
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Add.ToString()) //添加
            {
                ChkAdminLevel("account_list", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (DoAdd() < 0)
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加记账信息信息成功！", "account_list.aspx");
            }
        }

        //保存
        public void subjcet_Change_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < 10; i++)
            {
                DropDownList ddlBSubject = FindControl("ddlBSubject" + i) as DropDownList;
                if (ddlBSubject.SelectedValue.ToString() != "0")
                {
                    DropDownList ddlSSubject = FindControl("ddlSSubject" + i) as DropDownList;
                    ddlSSubject.Items.Clear();
                    BLL.subject subjectBll = new BLL.subject();
                    DataTable dtSubject = subjectBll.GetList(Utils.StrToInt(ddlBSubject.SelectedValue, 0));
                    foreach (DataRow dr in dtSubject.Rows)
                    {
                        string Id = dr["id"].ToString();
                        string Title = dr["name"].ToString().Trim();
                        ddlSSubject.Items.Add(new ListItem(Title, Id));
                    }
                }
            }
        }
    }
}