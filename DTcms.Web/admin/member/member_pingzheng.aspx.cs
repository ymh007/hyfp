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
    public partial class member_pingzheng : Web.UI.ManagePage
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
            if (!string.IsNullOrEmpty(model.pingzheng))
            {
                txtPingZheng.Text = model.pingzheng;
                imgPingZheng.Src = model.pingzheng;
            }
        }

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            BLL.member bll = new BLL.member();

            var pingzheng = txtPingZheng.Text.Trim();
            bll.UpdateField(id, "pingzheng='" + pingzheng + "'");
            JscriptMsg("缴纳互助金凭证上传成功！", Utils.CombUrlTxt("member_list.aspx", "keywords={0}", this.keywords));
        }
    }
}