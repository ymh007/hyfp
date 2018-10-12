using System;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using DTcms.Common;

namespace DTcms.Web.admin.daikuan
{
    public partial class member_choose : Web.UI.ManagePage
    {
        private string type = "1"; //操作类型
        protected string channel_name = string.Empty; //频道名称
        protected string keywords = string.Empty;
        private string action = ""; //操作类型
        protected int id = 0;

        //页面初始化事件
        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            type = DTRequest.GetQueryString("type");
            action = DTRequest.GetQueryString("action");
            id = DTRequest.GetQueryInt("id");
            this.keywords = DTRequest.GetQueryString("keywords");
            if (!Page.IsPostBack)
            {
                var strWhere = "id>0 and id!=" + id + CombSqlTxt(this.keywords);
                RptBind(strWhere, "name asc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            BLL.member bll = new BLL.member();
            BLL.member studentBll = new BLL.member();
            this.rptList.Visible = true;
            this.rptList.DataSource = bll.GetList(0, _strWhere, _orderby);
            this.rptList.DataBind();
            txtKeywords.Text = this.keywords;
        }
        #endregion

        //关健字查询
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("member_choose.aspx", "keywords={0}&type={1}", txtKeywords.Text, type));
        }

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (type == "1")
            {
                var checkCount = 0;
                var choose_id = 0;
                for (int i = 0; i < rptList.Items.Count; i++)
                {
                    int selectId = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                    CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                    if (cb.Checked)
                    {
                        checkCount++;
                        choose_id = selectId;
                    }
                    else
                    {
                    }
                }
                if (checkCount > 1)
                {
                    JscriptMsg("只能选择一个会员进行操作！", string.Empty);
                    return;
                }
                if (choose_id == 0)
                {
                    JscriptMsg("请选择会员！", string.Empty);
                    return;
                }
                Utils.WriteCookie("DTRememberChooseId", choose_id.ToString(), 14400);
                string pageUrl = Utils.CombUrlTxt("daikuan_edit.aspx", "action={0}&keywords={1}&choose_id={2}&id={3}&type={4}", action, keywords, choose_id.ToString(), id.ToString(), "1");
                Response.Redirect(pageUrl);
            }
            else if (type == "2")
            {
                var checkCount = 0;
                var lb_ids = "";
                for (int i = 0; i < rptList.Items.Count; i++)
                {
                    int selectId = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                    CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                    if (cb.Checked)
                    {
                        checkCount++;
                        lb_ids += selectId + ",";
                    }
                    else
                    {
                    }
                }
                lb_ids = lb_ids.Substring(0, lb_ids.Length - 1);
                if (checkCount != 2)
                {
                    JscriptMsg("必须选择两人为互助联保人！", string.Empty);
                    return;
                }
                string pageUrl = Utils.CombUrlTxt("daikuan_edit.aspx", "action={0}&keywords={1}&lb_ids={2}&id={3}&type={4}&choose_id={5}", action, keywords, lb_ids, id.ToString(), "2", Utils.GetCookie("DTRememberChooseId"));
                Response.Redirect(pageUrl);
            }
        }

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(string _keywords)
        {
            StringBuilder strTemp = new StringBuilder();
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and (name like '%" + _keywords + "%' or no like '%" + _keywords + "%') ");
            }
            return strTemp.ToString();
        }
        #endregion

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
    }
}