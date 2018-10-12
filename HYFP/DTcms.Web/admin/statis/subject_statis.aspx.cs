using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;
using System.IO;

namespace DTcms.Web.admin.statis
{
    public partial class subject_statis : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string keywords = string.Empty;
        protected string bSubject = string.Empty;
        protected string sSubject = string.Empty;
        protected string town = string.Empty;
        protected string village = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.keywords = DTRequest.GetQueryString("keywords");
            this.bSubject = DTRequest.GetQueryString("BSubject");
            this.sSubject = DTRequest.GetQueryString("SSubject");
            this.town = DTRequest.GetQueryString("town");
            this.village = DTRequest.GetQueryString("village");

            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                TreeBind();
                ChkAdminLevel("statis_list", DTEnums.ActionEnum.View.ToString()); //检查权限
                Model.xiehui model = GetAdminInfo(); //取得当前管理员信息
                ddlBSubject.SelectedValue = this.bSubject;
                subjcet_Change_Click(sender, e);
                RptBind();
            }
        }

        #region 数据绑定=================================
        private void RptBind()
        {
            txtKeywords.Text = this.keywords;
            txtTown.Text = this.town;
            txtVillage.Text = this.village;
            ddlSSubject.SelectedValue = this.sSubject;
            var list = GetStatisList();
            this.rptList.DataSource = list;
            this.rptList.DataBind();
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.xiehui bll = new BLL.xiehui();
            DataTable dt = bll.GetList("").Tables[0];

            BLL.subject bllSubject = new BLL.subject();
            DataTable dtSubject = bllSubject.GetParentList(0);
            ddlBSubject.Items.Clear();
            ddlBSubject.Items.Add(new ListItem("请选择科目大类", "0"));
            foreach (DataRow dr in dtSubject.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                ddlBSubject.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion

        private List<StatisEntity> GetStatisList()
        {
            BLL.account bll = new BLL.account();
            BLL.xiehui xiehuiBll = new BLL.xiehui();

            var id = xiehuiBll.GetId(txtTown.Text, txtVillage.Text);
            var ds = bll.GetStatisList(this.keywords, Utils.StrToInt(id, 0), Utils.StrToInt(this.bSubject, 0), Utils.StrToInt(this.sSubject, 0)).Tables[0];
            var list = new List<StatisEntity>();
            foreach (DataRow item in ds.Rows)
            {
                BLL.subject_detail subjectDetailBll = new BLL.subject_detail();
                var subjcetDetail = subjectDetailBll.GetModel(Utils.StrToInt(item["b_subject"].ToString(), 0), Utils.StrToInt(item["s_subject"].ToString(), 0));
                if (subjcetDetail == null)
                {
                    continue;
                }
                var model = new StatisEntity();
                var xiehui = xiehuiBll.GetModel(Utils.StrToInt(item["xiehui_id"].ToString(), 0));

                BLL.subject subjectBll = new BLL.subject();
                var bSubjectName = subjectBll.GetName(Utils.StrToInt(item["b_subject"].ToString(), 0));
                var sSubjectName = subjectBll.GetName(Utils.StrToInt(item["s_subject"].ToString(), 0));

                model.Town = xiehui.town;
                model.Village = xiehui.village;
                model.XieHui = xiehui.name;
                model.BBSubjcet = bSubjectName;
                model.SSbuject = sSubjectName;
                model.Amount = subjcetDetail.amount.ToString();
                model.BQJie = item["jie"].ToString();
                model.BQDai = item["dai"].ToString();
                model.QmAmount = (Utils.StrToInt(subjcetDetail.amount.ToString(), 0) - Utils.StrToInt(item["jie"].ToString(), 0) + Utils.StrToInt(item["dai"].ToString(), 0)).ToString();
                list.Add(model);
            }
            return list;
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(string _keywords)
        {
            StringBuilder strTemp = new StringBuilder();
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and (user_name like  '%" + _keywords + "%' or real_name like '%" + _keywords + "%' or email like '%" + _keywords + "%')");
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
            if (string.IsNullOrWhiteSpace(txtKeywords.Text))
            {
                JscriptMsg("请填写日期 ！", "back");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtTown.Text))
            {
                JscriptMsg("请填写所属乡镇！", "back");
                return;
            }
            if (string.IsNullOrWhiteSpace(txtVillage.Text))
            {
                JscriptMsg("请填写所属村庄！", "back");
                return;
            }
            Response.Redirect(Utils.CombUrlTxt("subject_statis.aspx", "keywords={0}&BSubject={1}&SSubject={2}&town={3}&village={4}", txtKeywords.Text, ddlBSubject.SelectedValue, ddlSSubject.SelectedValue, txtTown.Text, txtVillage.Text));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("subject_statis", DTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0;
            int errorCount = 0;
            BLL.subject_detail bll = new BLL.subject_detail();
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
            AddAdminLog(DTEnums.ActionEnum.Delete.ToString(), "删除记账信息" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("subject_statis.aspx", "keywords={0}", this.keywords));
        }


        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                var list = GetStatisList();

                // 2.设置单元格抬头
                // key：实体对象属性名称，可通过反射获取值
                // value：Excel列的名称
                Dictionary<string, string> cellheader = new Dictionary<string, string> { 
                    { "Town", "所属乡镇" },
                    { "Village", "所属村" },
                    { "XieHui", "协会名称" },
                    { "BBSubjcet", "科目大类" },
                    { "SSbuject", "科目小类" },
                    { "Amount", "初期余额" },
                    { "BQJie", "本期发生-借" },
                    { "BQDai", "本期发生-贷" },
                    { "QmAmount", "期末余额" },
                };

                // 3.进行Excel转换操作，并返回转换的文件下载链接
                string urlPath = ExcelHelper.EntityListToExcel2003(cellheader, list, "汇总报表");
                System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
                //Response.ContentType = "text/plain";
                //Response.Write(js.Serialize(urlPath)); // 返回Json格式的内容

                string filePath = HttpContext.Current.Server.MapPath("\\" + urlPath);
                string path = Server.UrlDecode(filePath);
                string fileName = Path.GetFileName(path);//文件名

                //以字符流的形式下载文件
                FileStream fs = new FileStream(filePath, FileMode.Open);
                byte[] bytes = new byte[(int)fs.Length];
                fs.Read(bytes, 0, bytes.Length);
                fs.Close();
                Response.ContentType = "application/octet-stream";
                //通知浏览器下载文件而不是打开
                Response.AddHeader("Content-Disposition", "attachment;  filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //保存
        public void subjcet_Change_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(ddlBSubject.SelectedValue) && ddlBSubject.SelectedValue.ToString() != "0")
            {
                ddlSSubject.Items.Clear();
                BLL.subject subjectBll = new BLL.subject();
                DataTable dtSubject = subjectBll.GetList(Utils.StrToInt(ddlBSubject.SelectedValue, 0));
                foreach (DataRow dr in dtSubject.Rows)
                {
                    string Id = dr["id"].ToString();
                    string Title = dr["name"].ToString().Trim();
                    ddlSSubject.Items.Add(new ListItem(Title, Id));
                }
            }
        }
    }
}