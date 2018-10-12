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
    public partial class exit_edit : Web.UI.ManagePage
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
                if (!new BLL.member_exit().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("member", DTEnums.ActionEnum.View.ToString()); //检查权限
                //Model.member_exit model = GetAdminInfo(); //取得协会会员信息
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
            BLL.member_exit bll = new BLL.member_exit();
            Model.member_exit model = bll.GetModel(_id);
            ddlTown.SelectedValue = model.town.ToString();
            ddlVillage.SelectedValue = model.village.ToString();
            txtAddress.Text = model.address;
            txtNo.Text = model.no;
            txtNo.ReadOnly = true;
            txtName.Text = model.name;
            rblGender.SelectedValue = model.gender.ToString();
            txtBirthday.Text = model.birthday.ToString();
            ddlEducation.SelectedValue = model.education;
            txtIdCard.Text = model.id_card;
            txtAmount.Text = model.amount.ToString();
            for (int i = 1; i < model.family.Count + 1; i++)
            {
                TextBox txtFamilyName = FindControl("txtFamilyName" + i) as TextBox;
                DropDownList ddlFamilyGender = FindControl("ddlFamilyGender" + i) as DropDownList;
                TextBox txtFamilyRel = FindControl("txtFamilyRel" + i) as TextBox;
                TextBox txtFamilyBir = FindControl("txtFamilyBir" + i) as TextBox;
                DropDownList ddlFamilyEdu = FindControl("ddlFamilyEdu" + i) as DropDownList;

                var current = model.family[i - 1];
                txtFamilyName.Text = current.name;
                ddlFamilyGender.SelectedValue = current.gender;
                txtFamilyRel.Text = current.relationship;
                txtFamilyBir.Text = current.birthday;
                ddlFamilyEdu.SelectedValue = current.education;
            }
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.member_exit model = new Model.member_exit();
            BLL.member_exit bll = new BLL.member_exit();
            //检测会员证号码是否重复
            if (bll.Exists(txtNo.Text.Trim()))
            {
                JscriptMsg("会员证号码重复！", "");
                return false;
            }
            model.town = ddlTown.SelectedValue.ToString();
            model.village = ddlVillage.SelectedValue.ToString();
            model.address = txtAddress.Text.Trim();
            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.gender = rblGender.SelectedValue.ToString();
            model.birthday = txtBirthday.Text.Trim();
            model.education = ddlEducation.SelectedValue.ToString();
            model.id_card = txtIdCard.Text.Trim();
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            if (model.town == "0")
            {
                JscriptMsg("请填写所属乡镇！", "");
                return false;
            }
            if (model.village == "0")
            {
                JscriptMsg("请填写所属村庄！", "");
                return false;
            }
            if (string.IsNullOrEmpty(model.no))
            {
                JscriptMsg("请填写会员编号！", "");
                return false;
            }
            if (string.IsNullOrEmpty(model.name))
            {
                JscriptMsg("请填写姓名！", "");
                return false;
            }
            List<Model.member_exit_family> ls = new List<Model.member_exit_family>();
            var familyModel = new Model.member_exit_family();
            if (!string.IsNullOrEmpty(txtFamilyName1.Text.Trim()))
            {
                familyModel.name = txtFamilyName1.Text.Trim();
                familyModel.gender = ddlFamilyGender1.SelectedValue.ToString();
                familyModel.relationship = txtFamilyRel1.Text.Trim();
                familyModel.birthday = txtFamilyBir1.Text.Trim();
                familyModel.education = ddlFamilyEdu1.SelectedValue.ToString();
                ls.Add(familyModel);
            }
            if (!string.IsNullOrEmpty(txtFamilyName2.Text.Trim()))
            {
                familyModel.name = txtFamilyName2.Text.Trim();
                familyModel.gender = ddlFamilyGender2.SelectedValue.ToString();
                familyModel.relationship = txtFamilyRel2.Text.Trim();
                familyModel.birthday = txtFamilyBir2.Text.Trim();
                familyModel.education = ddlFamilyEdu2.SelectedValue.ToString();
                ls.Add(familyModel);
            }
            if (!string.IsNullOrEmpty(txtFamilyName3.Text.Trim()))
            {
                familyModel.name = txtFamilyName3.Text.Trim();
                familyModel.gender = ddlFamilyGender3.SelectedValue.ToString();
                familyModel.relationship = txtFamilyRel3.Text.Trim();
                familyModel.birthday = txtFamilyBir3.Text.Trim();
                familyModel.education = ddlFamilyEdu3.SelectedValue.ToString();
                ls.Add(familyModel);
            }
            model.family = ls;
            if (bll.Add(model) > 0)
            {
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加协会会员:" + model.no); //记录日志
                JscriptMsg("添加协会会员信息成功！", "exit_edit.aspx");
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.member_exit bll = new BLL.member_exit();
            Model.member_exit model = bll.GetModel(_id);
            model.town = ddlTown.SelectedValue.ToString();
            model.village = ddlVillage.SelectedValue.ToString();
            model.address = txtAddress.Text.Trim();
            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.gender = rblGender.SelectedValue.ToString();
            model.birthday = txtBirthday.Text.Trim();
            model.education = ddlEducation.SelectedValue.ToString();
            model.id_card = txtIdCard.Text.Trim();
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            if (model.town == "0")
            {
                JscriptMsg("请填写所属乡镇！", "");
                return false;
            }
            if (model.village == "0")
            {
                JscriptMsg("请填写所属村庄！", "");
                return false;
            }
            if (string.IsNullOrEmpty(model.no))
            {
                JscriptMsg("请填写会员编号！", "");
                return false;
            }
            if (string.IsNullOrEmpty(model.name))
            {
                JscriptMsg("请填写姓名！", "");
                return false;
            }
            List<Model.member_exit_family> ls = new List<Model.member_exit_family>();
            var familyModel = new Model.member_exit_family();
            if (!string.IsNullOrEmpty(txtFamilyName1.Text.Trim()))
            {
                familyModel.name = txtFamilyName1.Text.Trim();
                familyModel.gender = ddlFamilyGender1.SelectedValue.ToString();
                familyModel.relationship = txtFamilyRel1.Text.Trim();
                familyModel.birthday = txtFamilyBir1.Text.Trim();
                familyModel.education = ddlFamilyEdu1.SelectedValue.ToString();
                ls.Add(familyModel);
            }
            if (!string.IsNullOrEmpty(txtFamilyName2.Text.Trim()))
            {
                familyModel.name = txtFamilyName2.Text.Trim();
                familyModel.gender = ddlFamilyGender2.SelectedValue.ToString();
                familyModel.relationship = txtFamilyRel2.Text.Trim();
                familyModel.birthday = txtFamilyBir2.Text.Trim();
                familyModel.education = ddlFamilyEdu2.SelectedValue.ToString();
                ls.Add(familyModel);
            }
            if (!string.IsNullOrEmpty(txtFamilyName3.Text.Trim()))
            {
                familyModel.name = txtFamilyName3.Text.Trim();
                familyModel.gender = ddlFamilyGender3.SelectedValue.ToString();
                familyModel.relationship = txtFamilyRel3.Text.Trim();
                familyModel.birthday = txtFamilyBir3.Text.Trim();
                familyModel.education = ddlFamilyEdu3.SelectedValue.ToString();
                ls.Add(familyModel);
            }
            model.family = ls;
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
                JscriptMsg("修改协会会员信息成功！", "exit_edit.aspx");
            }
            else //添加
            {
                ChkAdminLevel("member", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加协会会员信息成功！", "exit_edit.aspx");
            }
        }

        //保存
        public void town_Change_Click(object sender, EventArgs e)
        {
            ddlVillage.Items.Clear();
            BLL.village subjectBll = new BLL.village();
            DataTable dtVillage = subjectBll.GetList(Utils.StrToInt(ddlTown.SelectedValue, 0));
            foreach (DataRow dr in dtVillage.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                ddlVillage.Items.Add(new ListItem(Title, Id));
                var rowIndex = dtVillage.Rows.IndexOf(dr);
                if (rowIndex == 0)
                {
                    txtVillage.Text = Title;
                }
            }

        }

        public void village_Change_Click(object sender, EventArgs e)
        {
            BLL.village bll = new BLL.village();
            if (ddlVillage.SelectedValue != "0")
            {
                var name = bll.GetName(Utils.StrToInt(ddlVillage.SelectedValue, 0));
                txtVillage.Text = name;
            }
        }
    }
}