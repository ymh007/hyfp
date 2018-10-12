using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using System.Web.UI.HtmlControls;
using System.Text;

namespace DTcms.Web.admin.daikuan
{
    public partial class daikuan_edit : Web.UI.ManagePage
    {
        protected string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        protected int id = 0;
        protected string keywords = string.Empty;
        protected string choose_id = string.Empty;
        protected string type = string.Empty;
        protected string lb_ids = string.Empty;

        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.keywords = DTRequest.GetQueryString("keywords");
            this.choose_id = DTRequest.GetQueryString("choose_id");
            this.lb_ids = DTRequest.GetQueryString("lb_ids");
            this.type = DTRequest.GetQueryString("type");
            string _action = DTRequest.GetQueryString("action");
            if (!string.IsNullOrEmpty(_action) && _action == DTEnums.ActionEnum.Edit.ToString())
            {
                this.action = DTEnums.ActionEnum.Edit.ToString();//修改类型
                if (!int.TryParse(Request.QueryString["id"] as string, out this.id))
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.daikuan().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("daikuan_list", DTEnums.ActionEnum.View.ToString()); //检查权限
                //Model.daikuan model = GetAdminInfo(); //取得借款信息信息
                ChanYeBind();
                BLL.member bll = new BLL.member();
                //选择会员
                if (!string.IsNullOrEmpty(choose_id))
                {
                    txtMemberId.Text = choose_id;
                    Model.member model = bll.GetModel(Utils.StrToInt(choose_id, 0));
                    txtName.Text = model.name;
                    if (!string.IsNullOrWhiteSpace(model.gender))
                    {
                        txtGender.Text = model.gender == "0" ? "男" : "女";
                    }
                    txtLevel.Text = model.level;
                    txtLevelName.Text = new BLL.member_level().GetName(Utils.StrToInt(model.level, 0)); ;
                    txtIdCard.Text = model.id_card;
                    txtMember.Text = model.no;
                    txtTel.Text = model.tel;
                    txtCanAmount.Text = model.can_amount.ToString();
                    txtMemberAmount.Text = model.amount.ToString();
                }
                //互助联保人
                if (type == "2")
                {
                    if (!string.IsNullOrEmpty(lb_ids))
                    {
                        var ids = lb_ids.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                        var name = "";
                        foreach (var id in ids)
                        {
                            Model.member model = bll.GetModel(Utils.StrToInt(id, 0));
                            name += model.name + ",";
                        }
                        name = name.Substring(0, name.Length - 1);
                        txtLbIds.Text = lb_ids;
                        txtLbNames.Text = name;
                    }
                }
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 角色类型=================================
        private void ChanYeBind()
        {
            BLL.daikuan_chanye bll = new BLL.daikuan_chanye();
            DataTable dt = bll.GetList("").Tables[0];

            ddlChanYe.Items.Clear();
            ddlChanYe.Items.Add(new ListItem("请选择产业规模", ""));
            foreach (DataRow dr in dt.Rows)
            {
                ddlChanYe.Items.Add(new ListItem(dr["name"].ToString(), dr["id"].ToString()));
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.daikuan bll = new BLL.daikuan();
            BLL.member memberBll = new BLL.member();
            Model.daikuan model = bll.GetModel(_id);
            txtName.Text = model.name;
            if (!string.IsNullOrWhiteSpace(model.gender))
            {
                txtGender.Text = model.gender == "0" ? "男" : "女";
            }
            txtLevelName.Text = new BLL.member_level().GetName(Utils.StrToInt(model.level, 0));
            txtIdCard.Text = model.id_card;
            txtLevel.Text = model.level;
            txtTel.Text = model.tel;
            txtMember.Text = model.member_no;
            txtCanAmount.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.can_amount), 0).ToString();
            txtAmount.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.amount), 0).ToString();
            txtMemberAmount.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.member_amount), 0).ToString();
            txtPurpose.Text = model.purpose;
            txtAddTime.Text = model.add_time.Value.ToString("yyyy-MM-dd HH:mm:ss");
            txtMemberId.Text = model.member_id.ToString();
            txtMonth.Text = model.month.ToString();
            ddlChanYe.SelectedValue = model.chanye;
            txtRemark.Text = model.remark;
            if (!string.IsNullOrEmpty(model.lb_person))
            {
                txtLbIds.Text = model.lb_person;
                txtLbNames.Text = model.lb_person_names;
            }
            //绑定图片相册
            rptAlbumList.DataSource = model.albums;
            rptAlbumList.DataBind();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.daikuan model = new Model.daikuan();
            BLL.daikuan bll = new BLL.daikuan();
            model.member_id = Utils.StrToInt(txtMemberId.Text, 0);
            model.name = txtName.Text.Trim();
            if (!string.IsNullOrWhiteSpace(txtGender.Text.Trim()))
            {
                model.gender = txtGender.Text.Trim() == "男" ? "0" : "1";
            }
            model.id_card = txtIdCard.Text.Trim();
            model.tel = txtTel.Text.Trim();
            model.level = txtLevel.Text.Trim();
            model.member_no = txtMember.Text.Trim();
            model.can_amount = Utils.StrToDecimal(txtCanAmount.Text, 0);
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.purpose = txtPurpose.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.lb_person = txtLbIds.Text.ToString();
            model.lb_person_names = txtLbNames.Text.ToString();
            model.month = Utils.StrToInt(txtMonth.Text, 0);
            model.member_amount = Utils.StrToDecimal(txtMemberAmount.Text, 0);
            model.chanye = ddlChanYe.SelectedValue;
            model.remark = txtRemark.Text.Trim().ToString();

            BLL.daikuan_set setBll = new BLL.daikuan_set();
            var isExsit = setBll.Exists(1);
            Model.daikuan_set setModel = new Model.daikuan_set();
            if (isExsit)
            {
                setModel = setBll.GetModel(1);
                model.zy_amount = model.amount * (setModel.rate * 0.01m);

                model.wh_amount = model.amount + model.zy_amount;
            }

            #region 保存相册====================
            string[] albumArr = Request.Form.GetValues("hid_photo_name");
            string[] remarkArr = Request.Form.GetValues("hid_photo_remark");
            string[] link_urlArr = Request.Form.GetValues("hid_photo_link_url");
            if (albumArr != null && albumArr.Length > 0)
            {
                List<Model.daikuan_albums> ls = new List<Model.daikuan_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    if (imgArr.Length == 3)
                    {
                        if (!string.IsNullOrEmpty(link_urlArr[i]))
                        {
                            ls.Add(new Model.daikuan_albums { original_path = imgArr[1], thumb_path = imgArr[2], link_url = link_urlArr[i] });
                        }
                        if (!string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.daikuan_albums { original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.daikuan_albums { original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion
            if (bll.Add(model) > 0)
            {
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加借款信息:" + model.name); //记录日志
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.daikuan bll = new BLL.daikuan();
            Model.daikuan model = bll.GetModel(_id);
            model.member_id = Utils.StrToInt(txtMemberId.Text, 0);
            model.name = txtName.Text.Trim();
            model.level = txtLevel.Text.Trim();
            if (!string.IsNullOrWhiteSpace(txtGender.Text.Trim()))
            {
                model.gender = txtGender.Text.Trim() == "男" ? "0" : "1";
            }
            model.id_card = txtIdCard.Text.Trim();
            model.tel = txtTel.Text.Trim();
            model.member_no = txtMember.Text.Trim();
            model.can_amount = Utils.StrToDecimal(txtCanAmount.Text, 0);
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.member_amount = Utils.StrToDecimal(txtMemberAmount.Text, 0);
            model.purpose = txtPurpose.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.lb_person = txtLbIds.Text.ToString();
            model.lb_person_names = txtLbNames.Text.ToString();
            model.month = Utils.StrToInt(txtMonth.Text, 0);
            model.chanye = ddlChanYe.SelectedValue;
            model.remark = txtRemark.Text.Trim().ToString();

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
                List<Model.daikuan_albums> ls = new List<Model.daikuan_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    int img_id = Utils.StrToInt(imgArr[0], 0);
                    if (imgArr.Length == 3)
                    {
                        if (linkUrlArr != null && !string.IsNullOrEmpty(linkUrlArr[i]) && !string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.daikuan_albums { id = img_id, daikuan_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i], link_url = linkUrlArr[i] });
                        }
                        else if (linkUrlArr != null && !string.IsNullOrEmpty(remarkArr[i]) && string.IsNullOrEmpty(linkUrlArr[i]))
                        {
                            ls.Add(new Model.daikuan_albums { id = img_id, daikuan_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else if (linkUrlArr != null && !string.IsNullOrEmpty(linkUrlArr[i]) && string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.daikuan_albums { id = img_id, daikuan_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], link_url = linkUrlArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.daikuan_albums { id = img_id, daikuan_id = _id, original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion

            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改借款信息:" + model.name); //记录日志
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
                ChkAdminLevel("daikuan_list", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改借款信息信息成功！", "daikuan_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("daikuan_list", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加借款信息信息成功！", "daikuan_list.aspx");
            }
        }
    }
}