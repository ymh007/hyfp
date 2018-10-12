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
    public partial class daikuan_chanye_edit : Web.UI.ManagePage
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
                if (!new BLL.member_level().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("daikuan_chanye", DTEnums.ActionEnum.View.ToString()); //检查权限
                //Model.member_level model = GetAdminInfo(); //取得产业规模信息
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }


        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.daikuan_chanye bll = new BLL.daikuan_chanye();
            Model.daikuan_chanye model = bll.GetModel(_id);
            txtName.Text = model.name;
            //txtAmount.Text = model.amount.ToString();
            txtAddTime.Text = model.add_time.Value.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.daikuan_chanye model = new Model.daikuan_chanye();
            BLL.daikuan_chanye bll = new BLL.daikuan_chanye();
            //检测会员证号码是否重复
            if (bll.Exists(txtName.Text.Trim()))
            {
                return false;
            }
            model.name = txtName.Text.Trim();
            //model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            if (bll.Add(model) > 0)
            {
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加产业规模:" + model.name); //记录日志
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.daikuan_chanye bll = new BLL.daikuan_chanye();
            Model.daikuan_chanye model = bll.GetModel(_id);
            model.name = txtName.Text.Trim();
            //model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改产业规模:" + model.name); //记录日志
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
                ChkAdminLevel("daikuan_chanye", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改产业规模信息成功！", "daikuan_chanye_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("daikuan_chanye", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加产业规模信息成功！", "daikuan_chanye_list.aspx");
            }
        }
    }
}