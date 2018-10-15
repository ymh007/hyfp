using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;

namespace DTcms.Web.admin.manager
{
    public partial class daikuan_list : Web.UI.ManagePage
    {
        private string action = DTEnums.ActionEnum.Add.ToString(); //操作类型

        protected void Page_Load(object sender, EventArgs e)
        {
            BLL.village bll = new BLL.village();
            DataTable dtVillage = bll.GetList(0);
            this.cunlist.DataBind();
            cunlist.Items.Clear();
            cunlist.Items.Add(new ListItem("请选择", "0"));
            foreach (DataRow dr in dtVillage.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                cunlist.Items.Add(new ListItem(Title, Id));
            }
            var start = 1991;
            var end = DateTime.Now.Year;
            agesye.Items.Add(new ListItem("请选择年份", "0"));
            for (int i = start; i <= end; i++)
            {
                agesye.Items.Add(new ListItem(i.ToString(), i.ToString()));
            };
            for (int i = 1; i <= 150; i++)
            {
                age.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }; 
            this.name.Text = "张三1";
            this.peiouxingming.Text = "张三2";
            this.jichengren.Text = "cxvxcv";
            this.cunzu.Text = "ewqe掐我v";
            this.jiatingshouru.Text = "驱蚊器无";
            this.jiekuanyongtu.Text = "恶趣味";
            this.jiekuanjine.Text = "全文我去额";
            this.shenqings1.Text = "张 全文三";
            this.shenqings2.Text = "张而我却三";
            this.shenqings3.Text = "张擦擦擦三";
            this.shenqings4.Text = "张三";
            this.xiaozuyijian1.Text = "张三";
            this.xiaozuyijian2.Text = "张三";
            this.name.Text = "张三";
            this.name.Text = "张三";
            this.jiekuanstart.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            this.jiekuanend.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            this.jiekuantime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            this.xiaozutime.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            this.xieshenpiyijian.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            this.jianshiyijian.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");

        }

        protected void btnSubmited_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
            {
                ChkAdminLevel("member", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                //if (!DoEdit(this.id))
                //{
                //    JscriptMsg("保存过程中发生错误！", "");
                //    return;
                //}
                //JscriptMsg("修改协会会员信息成功！", "member_list.aspx");
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

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.member model = new Model.member();
            BLL.member bll = new BLL.member();
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
            List<Model.member_family> ls = new List<Model.member_family>();
            var familyModel = new Model.member_family();
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
                JscriptMsg("添加协会会员信息成功！", "member_list.aspx");
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        //private bool DoEdit(int _id)
        //{
        //    bool result = false;
        //    BLL.member bll = new BLL.member();
        //    Model.member model = bll.GetModel(_id);
        //    model.town = ddlTown.SelectedValue.ToString();
        //    model.village = ddlVillage.SelectedValue.ToString();
        //    model.address = txtAddress.Text.Trim();
        //    model.no = txtNo.Text.Trim();
        //    model.name = txtName.Text.Trim();
        //    model.gender = rblGender.SelectedValue.ToString();
        //    model.birthday = txtBirthday.Text.Trim();
        //    model.education = ddlEducation.SelectedValue.ToString();
        //    model.id_card = txtIdCard.Text.Trim();
        //    model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
        //    model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
        //    if (model.town == "0")
        //    {
        //        JscriptMsg("请填写所属乡镇！", "");
        //        return false;
        //    }
        //    if (model.village == "0")
        //    {
        //        JscriptMsg("请填写所属村庄！", "");
        //        return false;
        //    }
        //    if (string.IsNullOrEmpty(model.no))
        //    {
        //        JscriptMsg("请填写会员编号！", "");
        //        return false;
        //    }
        //    if (string.IsNullOrEmpty(model.name))
        //    {
        //        JscriptMsg("请填写姓名！", "");
        //        return false;
        //    }
        //    List<Model.member_family> ls = new List<Model.member_family>();
        //    var familyModel = new Model.member_family();
        //    if (!string.IsNullOrEmpty(txtFamilyName1.Text.Trim()))
        //    {
        //        familyModel.name = txtFamilyName1.Text.Trim();
        //        familyModel.gender = ddlFamilyGender1.SelectedValue.ToString();
        //        familyModel.relationship = txtFamilyRel1.Text.Trim();
        //        familyModel.birthday = txtFamilyBir1.Text.Trim();
        //        familyModel.education = ddlFamilyEdu1.SelectedValue.ToString();
        //        ls.Add(familyModel);
        //    }
        //    if (!string.IsNullOrEmpty(txtFamilyName2.Text.Trim()))
        //    {
        //        familyModel.name = txtFamilyName2.Text.Trim();
        //        familyModel.gender = ddlFamilyGender2.SelectedValue.ToString();
        //        familyModel.relationship = txtFamilyRel2.Text.Trim();
        //        familyModel.birthday = txtFamilyBir2.Text.Trim();
        //        familyModel.education = ddlFamilyEdu2.SelectedValue.ToString();
        //        ls.Add(familyModel);
        //    }
        //    if (!string.IsNullOrEmpty(txtFamilyName3.Text.Trim()))
        //    {
        //        familyModel.name = txtFamilyName3.Text.Trim();
        //        familyModel.gender = ddlFamilyGender3.SelectedValue.ToString();
        //        familyModel.relationship = txtFamilyRel3.Text.Trim();
        //        familyModel.birthday = txtFamilyBir3.Text.Trim();
        //        familyModel.education = ddlFamilyEdu3.SelectedValue.ToString();
        //        ls.Add(familyModel);
        //    }
        //    model.family = ls;
        //    if (bll.Update(model))
        //    {
        //        AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改协会会员:" + model.no); //记录日志
        //        result = true;
        //    }

        //    return result;
        //}
        #endregion
    }
}