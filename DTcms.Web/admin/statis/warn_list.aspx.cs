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
    public partial class warn_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("total", DTEnums.ActionEnum.View.ToString()); //检查权限
                Model.xiehui model = GetAdminInfo(); //取得当前管理员信息
                RptBind("", "add_time asc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = DTRequest.GetQueryInt("page", 1);
            BLL.daikuan bll = new BLL.daikuan();
            this.rptList.DataSource = bll.GetWarnList(this.pageSize, this.page, "status=1 and hk_status<>1 and DATEDIFF(day, getdate(),(DATEADD(month,[month],audit_time))) <=31", _orderby, out this.totalCount);
            this.rptList.DataBind();

            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("daikuan_list.aspx", "keywords={0}&page={1}", this.keywords, "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 返回每页数量=============================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("manager_page_size", "DTcmsPage"), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    return _pagesize;
                }
            }
            return _default_size;
        }
        #endregion

        //设置分页数量
        protected void txtPageNum_TextChanged(object sender, EventArgs e)
        {
            int _pagesize;
            if (int.TryParse(txtPageNum.Text.Trim(), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    Utils.WriteCookie("manager_page_size", "DTcmsPage", _pagesize.ToString(), 14400);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("warn_list.aspx", "keywords={0}", this.keywords));
        }


        public string GetGender(string gender)
        {
            if (string.IsNullOrWhiteSpace(gender))
            {
                return "";
            }
            if (Utils.StrToInt(gender, 0) == 0)
            {
                return "男";
            }
            else if (Utils.StrToInt(gender, 0) == 1)
            {
                return "女";
            }
            return "";
        }

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