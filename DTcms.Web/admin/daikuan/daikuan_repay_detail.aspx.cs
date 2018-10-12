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
    public partial class daikuan_repay_detail : Web.UI.ManagePage
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
            var list = bll.GetList("daikuan_id=" + this.id);
            rptList.DataSource = list;
            rptList.DataBind();

            var albumsList = new List<Model.daikuan_repay_albums>();
            var dt = list.Tables[0];
            foreach (DataRow item in dt.Rows)
            {
                var model = bll.GetModel(Utils.StrToInt(item["id"].ToString(), 0));
                albumsList.AddRange(model.albums);
            }
            this.rptList2.DataSource = albumsList;
            this.rptList2.DataBind();
        }
        #endregion
    }
}