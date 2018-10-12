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
    public partial class account_edit : Web.UI.ManagePage
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
                //Model.account model = GetAdminInfo(); //取得记账信息信息
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                    subjcet_Change_Click(sender, e);
                }
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.xiehui bll = new BLL.xiehui();
            DataTable dt = bll.GetList("").Tables[0];

            this.ddlXiehui.Items.Clear();
            this.ddlXiehui.Items.Add(new ListItem("请选择协会", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                this.ddlXiehui.Items.Add(new ListItem(Title, Id));
            }

            BLL.subject bllSubject = new BLL.subject();
            DataTable dtSubject = bllSubject.GetParentList(0);
            ddlBSubject.Items.Clear();
            ddlBSubject.Items.Add(new ListItem("请选择科目大类", "0"));
            foreach (DataRow dr in dtSubject.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                ddlBSubject.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.account bll = new BLL.account();
            Model.account model = bll.GetModel(_id);
            ddlXiehui.SelectedValue = model.xiehui_id.ToString();
            ddlBSubject.SelectedValue = model.b_subject.ToString();
            ddlSSubject.SelectedValue = model.s_subject.ToString();
            txtAddTime.Text = model.date.Value.ToString("yyyy-MM-dd");
            txtZhaiyao.Text = model.zhaiyao;
            txtJie.Text = model.jie.ToString();
            txtDai.Text = model.dai.ToString();
            //绑定图片相册
            rptAlbumList.DataSource = model.albums;
            rptAlbumList.DataBind();
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.account bll = new BLL.account();
            Model.account model = bll.GetModel(_id);
            model.xiehui_id = Utils.StrToInt(ddlXiehui.SelectedValue.ToString(),0);
            model.b_subject = Utils.StrToInt(ddlBSubject.SelectedValue.ToString(), 0);
            model.s_subject = Utils.StrToInt(ddlSSubject.SelectedValue.ToString(), 0);
            model.date = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.zhaiyao = txtZhaiyao.Text.Trim();
            model.jie = Utils.StrToDecimal(Utils.ObjectToStr(txtJie.Text.Trim()), 0);
            model.dai = Utils.StrToDecimal(Utils.ObjectToStr(txtDai.Text.Trim()), 0);
            #region 保存相册====================
            //检查是否有自定义图片
            if (model.albums != null)
            {
                model.albums.Clear();
            }
            string[] albumArr = Request.Form.GetValues("hid_photo_name");
            string[] remarkArr = Request.Form.GetValues("hid_photo_remark");
            string[] linkUrlArr = Request.Form.GetValues("hid_photo_link_url");
            if (albumArr != null)
            {
                List<Model.account_albums> ls = new List<Model.account_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    int img_id = Utils.StrToInt(imgArr[0], 0);
                    if (imgArr.Length == 3)
                    {
                        if (linkUrlArr != null && !string.IsNullOrEmpty(linkUrlArr[i]) && !string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.account_albums { id = img_id, account_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i], link_url = linkUrlArr[i] });
                        }
                        else if (linkUrlArr != null && !string.IsNullOrEmpty(remarkArr[i]) && string.IsNullOrEmpty(linkUrlArr[i]))
                        {
                            ls.Add(new Model.account_albums { id = img_id, account_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else if (linkUrlArr != null && !string.IsNullOrEmpty(linkUrlArr[i]) && string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.account_albums { id = img_id, account_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], link_url = linkUrlArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.account_albums { id = img_id, account_id = _id, original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion
            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改记账信息:" + model.xiehui_id); //记录日志
                result = true;
            }

            return result;
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
            {
                ChkAdminLevel("account_list", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改记账信息信息成功！", "account_list.aspx");
            }
        }

        //保存
        public void subjcet_Change_Click(object sender, EventArgs e)
        {
            if (ddlBSubject.SelectedValue.ToString() != "0")
            {
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