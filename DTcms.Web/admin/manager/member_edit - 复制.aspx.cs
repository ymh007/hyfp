using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using System.Web.UI.HtmlControls;
using System.Text;

namespace DTcms.Web.admin.member
{
    public partial class member_edit : Web.UI.ManagePage
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
                if (!new BLL.member().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("member", DTEnums.ActionEnum.View.ToString()); //检查权限
                //Model.member model = GetAdminInfo(); //取得协会会员信息
                LevelBind();
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                    town_Change_Click(sender, e);
                }
            }
        }

        #region 角色类型=================================
        private void LevelBind()
        {
            BLL.member_level bll = new BLL.member_level();
            DataTable dt = bll.GetList("").Tables[0];

            ddlMemberLevel.Items.Clear();
            ddlMemberLevel.Items.Add(new ListItem("请选择会员级别", ""));
            foreach (DataRow dr in dt.Rows)
            {
                ddlMemberLevel.Items.Add(new ListItem(dr["name"].ToString(), dr["id"].ToString()));
            }

            BLL.village villageBll = new BLL.village();
            DataTable dtVillage = villageBll.GetParentList(0);

            ddlTown.Items.Clear();
            ddlTown.Items.Add(new ListItem("请选择所属乡镇", "0"));
            foreach (DataRow dr in dtVillage.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                ddlTown.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.member bll = new BLL.member();
            Model.member model = bll.GetModel(_id);
            txtNo.Text = model.no;
            txtNo.ReadOnly = true;
            txtNo.Attributes.Remove("ajaxurl");
            txtName.Text = model.name;
            rblType.SelectedValue = model.type.ToString();
            rblGender.SelectedValue = model.gender.ToString();
            ddlMemberLevel.SelectedValue = model.level.ToString();
            txtTel.Text = model.tel;
            txtIdCard.Text = model.id_card;
            ddlTown.SelectedValue = model.town;
            ddlVillage.SelectedValue = model.village;
            txtAmount.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.amount), 0).ToString();
            txtCanAmount.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.can_amount), 0).ToString();
            txtYh.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.yh_amount), 0).ToString();
            txtPeigu.Text = Utils.StrToDecimal(Utils.ObjectToStr(model.peigu), 0).ToString();
            txtDate.Text = model.date.Value.ToString("yyyy-MM-dd HH:mm:ss");
            txtAddTime.Text = model.add_time.Value.ToString("yyyy-MM-dd HH:mm:ss");
            txtRemark.Text = model.remark;
            txtImgUrl.Text = model.img_url;
            //绑定图片相册
            rptAlbumList.DataSource = model.albums;
            rptAlbumList.DataBind();
            rptCwList.DataSource = model.cw_albums;
            rptCwList.DataBind();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.member model = new Model.member();
            BLL.member bll = new BLL.member();
            //检测会员证号码是否重复
            if (bll.Exists(txtNo.Text.Trim()))
            {
                return false;
            }
            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.type = rblType.SelectedValue.ToString();
            model.level = ddlMemberLevel.SelectedValue.ToString();
            model.gender = rblGender.SelectedValue.ToString();
            model.id_card = txtIdCard.Text.Trim();
            model.tel = txtTel.Text.Trim();
            model.town = ddlTown.SelectedValue.ToString();
            model.village = ddlVillage.SelectedValue.ToString();
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.can_amount = model.amount * 10;
            model.yh_amount = Utils.StrToDecimal(txtYh.Text, 0);
            model.peigu = Utils.StrToDecimal(txtPeigu.Text, 0);
            if (model.peigu >= 3000)
            {
                model.can_amount = model.amount * 10 + model.peigu;
            }
            model.no = txtNo.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.date = Utils.StrToDateTime(txtDate.Text.Trim());
            model.remark = txtRemark.Text.Trim();
            model.img_url = txtImgUrl.Text.Trim();
            #region 保存相册====================
            string[] albumArr = Request.Form.GetValues("hid_photo_name");
            string[] remarkArr = Request.Form.GetValues("hid_photo_remark");
            string[] link_urlArr = Request.Form.GetValues("hid_photo_link_url");
            if (albumArr != null && albumArr.Length > 0)
            {
                List<Model.member_albums> ls = new List<Model.member_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    if (imgArr.Length == 3)
                    {
                        if (!string.IsNullOrEmpty(link_urlArr[i]))
                        {
                            ls.Add(new Model.member_albums { original_path = imgArr[1], thumb_path = imgArr[2], link_url = link_urlArr[i] });
                        }
                        if (!string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.member_albums { original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.member_albums { original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion

            #region 保存相册====================
            string[] cw_albumArr = Request.Form.GetValues("hid_photo_cw_name");
            string[] cw_remarkArr = Request.Form.GetValues("hid_photo_cw_remark");
            string[] cw_link_urlArr = Request.Form.GetValues("hid_photo_cw_link_url");
            if (cw_albumArr != null && cw_albumArr.Length > 0)
            {
                List<Model.member_cw_albums> ls = new List<Model.member_cw_albums>();
                for (int i = 0; i < cw_albumArr.Length; i++)
                {
                    string[] imgArr = cw_albumArr[i].Split('|');
                    if (imgArr.Length == 3)
                    {
                        if (!string.IsNullOrEmpty(link_urlArr[i]))
                        {
                            ls.Add(new Model.member_cw_albums { original_path = imgArr[1], thumb_path = imgArr[2], link_url = link_urlArr[i] });
                        }
                        if (!string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.member_cw_albums { original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.member_cw_albums { original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.cw_albums = ls;
            }
            #endregion
            if (bll.Add(model) > 0)
            {
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加协会会员:" + model.no); //记录日志
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.member bll = new BLL.member();
            Model.member model = bll.GetModel(_id);
            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.type = rblType.SelectedValue.ToString();
            model.level = ddlMemberLevel.SelectedValue.ToString();
            model.gender = rblGender.SelectedValue.ToString();
            model.id_card = txtIdCard.Text.Trim();
            model.tel = txtTel.Text.Trim();
            model.town = ddlTown.SelectedValue.ToString();
            model.village = ddlVillage.SelectedValue.ToString();
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.yh_amount = Utils.StrToDecimal(txtYh.Text, 0);
            model.peigu = Utils.StrToDecimal(txtPeigu.Text, 0);
            model.can_amount = model.amount * 10;
            model.no = txtNo.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.date = Utils.StrToDateTime(txtDate.Text.Trim());
            model.remark = txtRemark.Text.Trim();
            model.img_url = txtImgUrl.Text.Trim();
            if (model.peigu >= 3000)
            {
                model.can_amount = model.amount * 10 + model.peigu;
            }
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
                List<Model.member_albums> ls = new List<Model.member_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    int img_id = Utils.StrToInt(imgArr[0], 0);
                    if (imgArr.Length == 3)
                    {
                        if (linkUrlArr != null && !string.IsNullOrEmpty(linkUrlArr[i]) && !string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.member_albums { id = img_id, member_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i], link_url = linkUrlArr[i] });
                        }
                        else if (linkUrlArr != null && !string.IsNullOrEmpty(remarkArr[i]) && string.IsNullOrEmpty(linkUrlArr[i]))
                        {
                            ls.Add(new Model.member_albums { id = img_id, member_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else if (linkUrlArr != null && !string.IsNullOrEmpty(linkUrlArr[i]) && string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.member_albums { id = img_id, member_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], link_url = linkUrlArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.member_albums { id = img_id, member_id = _id, original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion

            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改协会会员:" + model.no); //记录日志
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
                ChkAdminLevel("member", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改协会会员信息成功！", "member_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("member", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加协会会员信息成功！", "member_list.aspx");
            }
        }

        //保存
        public void town_Change_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < 10; i++)
            {
                if (ddlVillage.SelectedValue.ToString() != "0")
                {
                    ddlVillage.Items.Clear();
                    BLL.village subjectBll = new BLL.village();
                    DataTable dtVillage = subjectBll.GetList(Utils.StrToInt(ddlTown.SelectedValue, 0));
                    foreach (DataRow dr in dtVillage.Rows)
                    {
                        string Id = dr["id"].ToString();
                        string Title = dr["name"].ToString().Trim();
                        ddlVillage.Items.Add(new ListItem(Title, Id));
                    }
                }
            }
        }
    }
}