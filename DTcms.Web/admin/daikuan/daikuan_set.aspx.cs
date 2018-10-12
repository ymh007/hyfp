using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;

namespace DTcms.Web.admin.daikuan
{
    public partial class daikuan_set : Web.UI.ManagePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ShowInfo();
            }
        }

        #region 赋值操作=================================
        private void ShowInfo()
        {
            BLL.daikuan_set bll = new BLL.daikuan_set();
            Model.daikuan_set model = bll.GetModel(1);

            if (model != null)
            {
                txtRate.Text = model.rate.ToString();
                txtOverRate.Text = model.over_rate.ToString();
                txtAmount.Text = model.amount.ToString();
            }
        }
        #endregion

        /// <summary>
        /// 保存配置信息
        /// </summary>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            BLL.daikuan_set bll = new BLL.daikuan_set();
            var isExsit = bll.Exists(1);
            Model.daikuan_set model = new Model.daikuan_set();
            if (isExsit)
            {
                model = bll.GetModel(1);
            }
            model.rate = Utils.ObjToDecimal(txtRate.Text, 0);
            model.over_rate = Utils.ObjToDecimal(txtOverRate.Text, 0);
            model.amount = Utils.ObjToDecimal(txtAmount.Text, 0);
            if (isExsit)
            {
                if (!bll.Update(model))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                else
                {
                    AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改借款事项信息"); //记录日志
                    JscriptMsg("修改借款事项成功！", "daikuan_set.aspx");
                }
            }
            else
            {

                if (bll.Add(model) > 0)
                {
                    AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加借款事项信息:"); //记录日志
                }
                else
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
            }

        }

    }
}