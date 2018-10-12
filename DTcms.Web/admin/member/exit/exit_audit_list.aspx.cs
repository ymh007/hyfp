using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;
using System.Web.UI.HtmlControls;

namespace DTcms.Web.admin.exit
{
    public partial class exit_audit_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.keywords = DTRequest.GetQueryString("keywords");

            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("member", DTEnums.ActionEnum.View.ToString()); //检查权限
                Model.xiehui model = GetAdminInfo(); //取得当前管理员信息
                var strWhere = "id>0" + CombSqlTxt(this.keywords);
                RptBind(strWhere, "no,add_time desc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = DTRequest.GetQueryInt("page", 1);
            txtKeywords.Text = this.keywords;
            BLL.member_exit bll = new BLL.member_exit();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
            this.rptList.DataBind();

            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("member_list.aspx", "keywords={0}&page={1}", this.keywords, "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(string _keywords)
        {
            StringBuilder strTemp = new StringBuilder();
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and (town like  '%" + _keywords + "%' or village like '%" + _keywords + "%')");
            }

            return strTemp.ToString();
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

        //关健字查询
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("member_list.aspx", "keywords={0}", txtKeywords.Text));
        }

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
            Response.Redirect(Utils.CombUrlTxt("member_list.aspx", "keywords={0}", this.keywords));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("member_list", DTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0;
            int errorCount = 0;
            BLL.member bll = new BLL.member();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    if (bll.Delete(id))
                    {
                        sucCount += 1;
                    }
                    else
                    {
                        errorCount += 1;
                    }
                }
            }
            AddAdminLog(DTEnums.ActionEnum.Delete.ToString(), "删除协会会员" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("member_list.aspx", "keywords={0}", this.keywords));
        }

        //批量审核
        protected void btnAudit_Click(object sender, EventArgs e)
        {
            BLL.member_exit bll = new BLL.member_exit();
            Repeater rptList = new Repeater();
            rptList = this.rptList;
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    var model = bll.GetModel(id);
                    if (model.status == 1)
                    {
                        JscriptMsg("该会员已经退会成功！", Utils.CombUrlTxt("exit_audit_list.aspx", "keywords={0}", this.keywords));
                        return;
                    }
                    else if (model.status == 2)
                    {
                        JscriptMsg("该会员已经驳回退会申请！", Utils.CombUrlTxt("exit_audit_list.aspx", "keywords={0}", this.keywords));
                        return;
                    }
                    bll.UpdateField(id, "status=1");
                    bll.UpdateField(id, "exit_time='" + DateTime.Now + "'");

                    BLL.member_exit memberBll = new BLL.member_exit();
                    memberBll.UpdateField(Utils.ObjToInt(model.id, 0), "is_delete=1");
                }
            }
            AddAdminLog(DTEnums.ActionEnum.Audit.ToString(), "审核频道内容信息"); //记录日志
            JscriptMsg("同意退会操作成功！", Utils.CombUrlTxt("exit_audit_list.aspx", "keywords={0}", this.keywords));
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            BLL.member_exit bll = new BLL.member_exit();
            Repeater rptList = new Repeater();
            rptList = this.rptList;
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    var model = bll.GetModel(id);
                    if (model.status == 1)
                    {
                        JscriptMsg("该会员已经退会成功！", Utils.CombUrlTxt("exit_audit_list.aspx", "keywords={0}", this.keywords));
                        return;
                    }
                    else if (model.status == 2)
                    {
                        JscriptMsg("该会员已经驳回退会申请！", Utils.CombUrlTxt("exit_audit_list.aspx", "keywords={0}", this.keywords));
                        return;
                    }
                    bll.UpdateField(id, "status=2");
                    bll.UpdateField(id, "exit_time='" + DateTime.Now + "'");
                }
            }
            AddAdminLog(DTEnums.ActionEnum.Audit.ToString(), "审核频道内容信息"); //记录日志
            JscriptMsg("驳回退会成功！", Utils.CombUrlTxt("exit_audit_list.aspx", "keywords={0}", this.keywords));
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

        public string GetStatus(string status)
        {
            if (Utils.StrToInt(status, 0) == 0)
            {
                return "待审核";
            }
            else if (Utils.StrToInt(status, 0) == 1)
            {
                return "同意退会";
            }
            else if (Utils.StrToInt(status, 0) == 2)
            {
                return "驳回退会";
            }
            return "待审核";
        }

    }
}