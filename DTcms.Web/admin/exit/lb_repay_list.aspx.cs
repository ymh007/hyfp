using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;

namespace DTcms.Web.admin.exit
{
    public partial class lb_repay_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        protected int id = 0;

        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.id = Utils.StrToInt(DTRequest.GetQueryString("id"), 0);
            if (!Page.IsPostBack)
            {
                RptBind("id>0", "add_time asc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = DTRequest.GetQueryInt("page", 1);
            BLL.daikuan_repay bll = new BLL.daikuan_repay();
            var list = bll.GetList(@" daikuan_id IN(select id FROM daikuan WHERE CONVERT(NVARCHAR(50),member_id) IN(
                select * from dbo.f_split((select TOP 1 lb_person from daikuan where member_id=" + this.id + "),',')))");
            rptList.DataSource = list;
            rptList.DataBind();
        }
        #endregion
    }
}