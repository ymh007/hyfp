using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;

namespace DTcms.Web.admin.statis
{
    public partial class total_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("total", DTEnums.ActionEnum.View.ToString()); //检查权限
                Model.xiehui model = GetAdminInfo(); //取得当前管理员信息
                RptBind("", "");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            var list = GetStatisList();
            this.rptList.DataSource = list;
            this.rptList.DataBind();
        }
        #endregion


        #region 获取列表
        private List<TotalEntity> GetStatisList()
        {
            BLL.daikuan bll = new BLL.daikuan();
            BLL.member memberBll = new BLL.member();
            //已通过贷款数量
            var daikuanCount = bll.GetRecordCount(" status=1");
            //会员数量
            var memberCount = memberBll.GetRecordCount("");
            //新增会员数量
            var newMemberCount = memberBll.GetRecordCount(" add_time>='" + DateTime.Now.Date + "'");
            var exitCount = memberBll.GetRecordCount(" is_delete=1");
            var list = new List<TotalEntity>()
            {
               new TotalEntity(){DaikuanCount=daikuanCount,MemberCount=memberCount,NewMemCount=newMemberCount,ExitCount=exitCount}
            };
            return list;
        }
        #endregion

    }
}