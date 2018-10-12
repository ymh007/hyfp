using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;

namespace DTcms.Web.admin.daikuan
{
    public partial class daikuan_detail : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        protected int id = 0;

        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.keywords = DTRequest.GetQueryString("keywords");
            this.id = Utils.StrToInt(DTRequest.GetQueryString("id"), 0);
            if (!Page.IsPostBack)
            {
                BLL.daikuan bll = new BLL.daikuan();
                Model.daikuan model = bll.GetModel(this.id);
                //绑定图片相册
                rptList2.DataSource = model.albums;
                rptList2.DataBind();
                var lbIds = model.lb_person;
                RptBind("id>0 and id in(" + lbIds + ")", "add_time asc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = DTRequest.GetQueryInt("page", 1);
            BLL.member bll = new BLL.member();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
            this.rptList.DataBind();
        }
        #endregion
    }
}