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
    public partial class daikuan_reject : Web.UI.ManagePage
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
        }

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            BLL.daikuan bll = new BLL.daikuan();
            bll.UpdateField(id, "status=2");
            var reason = txtReason.Text.Trim();
            bll.UpdateField(id, "reason='" + reason + "'");
            JscriptMsg("驳回借款成功！", Utils.CombUrlTxt("daikuan_audit_list.aspx", "keywords={0}", this.keywords));
        }
    }
}