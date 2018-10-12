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
    public partial class daikuan_set_edit : Web.UI.ManagePage
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
                if (!new BLL.daikuan_set().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("daikuan_set", DTEnums.ActionEnum.View.ToString()); //检查权限
                LevelBind();
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 角色类型=================================
        private void LevelBind()
        {
            BLL.xiehui bll = new BLL.xiehui();
            DataTable dt = bll.GetList(" name<>'' and name<>'管理员'").Tables[0];

            ddlXieHui.Items.Clear();
            ddlXieHui.Items.Add(new ListItem("请选择所属协会", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                ddlXieHui.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.daikuan_set bll = new BLL.daikuan_set();
            Model.daikuan_set model = bll.GetModel(_id);
            ddlXieHui.SelectedValue = model.xiehui_id.ToString();
            txtRate.Text = model.rate.ToString();
            txtOverRate.Text = model.over_rate.ToString();
            txtAmount.Text = model.amount.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.daikuan_set model = new Model.daikuan_set();
            BLL.daikuan_set bll = new BLL.daikuan_set();
            model.xiehui_id = Utils.StrToInt(ddlXieHui.SelectedValue, 0);
            model.rate = Utils.StrToDecimal(txtRate.Text, 0);
            model.over_rate = Utils.StrToDecimal(txtOverRate.Text, 0);
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);
            if (bll.Add(model) > 0)
            {
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加利率:" + model.rate); //记录日志
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.daikuan_set bll = new BLL.daikuan_set();
            Model.daikuan_set model = bll.GetModel(_id);
            model.xiehui_id = Utils.StrToInt(ddlXieHui.SelectedValue, 0);
            model.rate = Utils.StrToDecimal(txtRate.Text, 0);
            model.over_rate = Utils.StrToDecimal(txtOverRate.Text, 0);
            model.amount = Utils.StrToDecimal(txtAmount.Text, 0);

            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改利率:" + model.rate); //记录日志
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
                ChkAdminLevel("daikuan_set", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改利率信息成功！", "daikuan_set_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("daikuan_set", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加利率信息成功！", "daikuan_set_list.aspx");
            }
        }
    }
}