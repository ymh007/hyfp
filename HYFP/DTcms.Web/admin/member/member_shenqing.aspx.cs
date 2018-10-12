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
    public partial class member_shenqing : Web.UI.ManagePage
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
            this.id = Utils.StrToInt(DTRequest.GetQueryString("id"), 0);
            action = DTRequest.GetQueryString("action");
            BLL.member bll = new BLL.member();
            Model.member model = bll.GetModel(id);
            if (!string.IsNullOrEmpty(model.shenqingbiao))
            {
                txtShenQingBiao.Text = model.shenqingbiao;
                imgShenQingBiao.Src = model.shenqingbiao;
            }
        }

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            BLL.member bll = new BLL.member();
            var shenqingbiao = txtShenQingBiao.Text.Trim();
            bll.UpdateField(id, "shenqingbiao='" + shenqingbiao + "'");
            JscriptMsg("入会申请表上传成功！", Utils.CombUrlTxt("member_list.aspx", "keywords={0}", this.keywords));
        }
    }
}