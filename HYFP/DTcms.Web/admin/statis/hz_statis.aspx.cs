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
    public partial class hz_statis : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string keywords = string.Empty;
        protected string bSubject = string.Empty;
        protected string sSubject = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.keywords = DTRequest.GetQueryString("keywords");
            this.bSubject = DTRequest.GetQueryString("BSubject");
            this.sSubject = DTRequest.GetQueryString("SSubject");

            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                TreeBind();

                ChkAdminLevel("hz_statis", DTEnums.ActionEnum.View.ToString()); //检查权限
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
            BLL.subject subjectBll = new BLL.subject();
            BLL.subject_detail subjectDetailBll = new BLL.subject_detail();

            var ds = bll.GetStatisList(this.keywords, 0, Utils.StrToInt(ddlBSubject.SelectedValue, 0), Utils.StrToInt(ddlSSubject.SelectedValue, 0)).Tables[0];
            var list = new List<StatisEntity>();
            foreach (DataRow dr in ds.Rows)
            {
                var xiehui = xiehuiBll.GetModel(Utils.StrToInt(dr["xiehui_id"].ToString(), 0));
                var model = new StatisEntity();
                model.Town = xiehui.town;
                model.Village = xiehui.village;
                model.XieHui = xiehui.name;
                model.XianJin = GetAmount("现金", dr);
                model.YHCK = GetAmount("银行存款", dr);
                model.JCHZJ = GetAmount("借出互助金", dr);
                //资产小计=现金+银行存款+借出互助金
                model.ZCXJ = (Utils.StrToInt(model.XianJin, 0) + Utils.StrToInt(model.YHCK, 0) + Utils.StrToInt(model.JCHZJ, 0)).ToString();
                //借出互助资金占比率=资产小计/借出互助金
                model.JCZB = Utils.StrToInt(model.JCHZJ, 0) == 0 ? "0" : (Utils.StrToInt(model.ZCXJ, 0) / Utils.StrToInt(model.JCHZJ, 0)).ToString();
                model.RHHZ = GetAmount("会员入会互助金", dr);
                model.ZFHZJ = GetAmount("政府拨入互助资金", dr);
                //负债小计=会员入会互助金+政府拨入互助金
                model.FZXJ = (Utils.StrToInt(model.RHHZ, 0) + Utils.StrToInt(model.ZFHZJ, 0)).ToString();
                //净资产=资产小计-负债小计
                model.JZC = (Utils.StrToInt(model.ZCXJ, 0) + Utils.StrToInt(model.FZXJ, 0)).ToString();
                model.ZFBZ = GetAmount("政府补助收入", dr);
                model.JCZY = GetAmount("互助金占用费收入", dr);
                model.YWGL = GetAmount("业务管理费收入", dr);
                model.GYJ = GetAmount("公益金", dr);
                //收入小计=政府补助收入+互助金占用费收入+业务管理费收入+公益金
                model.SRXJ = (Utils.StrToInt(model.ZFBZ, 0) + Utils.StrToInt(model.JCZY, 0) + Utils.StrToInt(model.YWGL, 0) + Utils.StrToInt(model.GYJ, 0)).ToString();
                model.HDZC = GetAmount("业务活动支出", dr);
                //本期结余=收入小计-业务活动支出
                model.BQJY = (Utils.StrToInt(model.SRXJ, 0) + Utils.StrToInt(model.HDZC, 0)).ToString();
                list.Add(model);
            }
            //var list = new List<StatisEntity>()
            //{
            //   new StatisEntity(){Town="漩涡镇",Village="茨沟村",XieHui="漩涡镇茨沟村协会",XianJin="",YHCK="191816.41",JCHZJ="556000.00",ZCXJ="747816.41",JCZB="74.35%",RHHZ="54600.00",ZFHZJ="693780",FZXJ="748380",JZC="-563.59 ",ZFBZ="",JCZY="250.00",GYJ="",SRXJ="1261.41",HDZC="1825",BQJY="-563.59"},

            //   new StatisEntity(){Town="漩涡镇",Village="东河村",XieHui="漩涡镇东河村协会",XianJin="",YHCK="307102.74",JCHZJ="451000.00",ZCXJ="758102.74",JCZB="59.49%",RHHZ="39400.00",ZFHZJ="713420",FZXJ="752820",JZC="5282.74",ZFBZ="",JCZY="5282.74",GYJ="",SRXJ="5282.74",HDZC="",BQJY="5282.74"},

            //   new StatisEntity(){Town="漩涡镇",Village="金星村",XieHui="漩涡镇金星村协会",XianJin="",YHCK="237406.44 ",JCHZJ="555000.00",ZCXJ="792406.44",JCZB="70.04%",RHHZ="48300.00",ZFHZJ="741740",FZXJ="790040",JZC="2366.44",ZFBZ="",JCZY="2366.44",GYJ="",SRXJ="2366.44",HDZC="",BQJY="2366.44"},

            //   new StatisEntity(){Town="漩涡镇",Village="田凤村",XieHui="漩涡镇田凤村协会",XianJin="",YHCK="494204.05",JCHZJ="305000.00",ZCXJ="799204.05",JCZB="38.16%",RHHZ="27000.00",ZFHZJ="770950",FZXJ="797950",JZC="1254.05",ZFBZ="",JCZY="1254.05",GYJ="",SRXJ="1254.05",HDZC="",BQJY="1254.05"},

            //   new StatisEntity(){Town="漩涡镇",Village="田堰村",XieHui="漩涡镇田堰村协会",XianJin="",YHCK="441926.13",JCHZJ="310000.00",ZCXJ="751926.13",JCZB="41.23%",RHHZ="29900.00",ZFHZJ="715700",FZXJ="745600",JZC="6326.13",ZFBZ="",JCZY="8121.13",GYJ="",SRXJ="8121.13",HDZC="1795",BQJY="6326.13"},

            //   new StatisEntity(){Town="漩涡镇",Village="上七村",XieHui="漩涡镇上七村协会",XianJin="",YHCK="500379.17",JCHZJ="",ZCXJ="500379.17",JCZB="0.00%",RHHZ="",ZFHZJ="500000",FZXJ="500000",JZC="379.17",ZFBZ="",JCZY="379.17",GYJ="",SRXJ="379.17",HDZC="",BQJY="379.17"},

            //   new StatisEntity(){Town="漩涡镇",Village="龙泉村",XieHui="漩涡镇龙泉村协会",XianJin="237",YHCK="170990.74",JCHZJ="370000.00",ZCXJ="541227.74",JCZB="68.36%",RHHZ="42700.00",ZFHZJ="500000",FZXJ="542700",JZC="-1472.26",ZFBZ="",JCZY="290.74",GYJ="",SRXJ="290.74",HDZC="1763",BQJY="-1472.26"},

            //   new StatisEntity(){Town="漩涡镇",Village="中银村",XieHui="漩涡镇中银村协会",XianJin="47",YHCK="246524.64",JCHZJ="412000.00",ZCXJ="658571.64",JCZB="62.56%",RHHZ="41900.00",ZFHZJ="600000",FZXJ="641900",JZC="16671.64",ZFBZ="",JCZY="18576.64",GYJ="",SRXJ="18576.64",HDZC="1905",BQJY="16671.64"},
            //};
            return list;
            //BLL.account bll = new BLL.account();
            //var ds = bll.GetStatisList(this.keywords,1, Utils.StrToInt(this.bSubject, 0), Utils.StrToInt(this.sSubject, 0)).Tables[0];
            //var list = new List<StatisEntity>();
            //foreach (DataRow item in ds.Rows)
            //{
            //    BLL.subject_detail subjectDetailBll = new BLL.subject_detail();
            //    var subjcetDetail = subjectDetailBll.GetModel(Utils.StrToInt(item["b_subject"].ToString(), 0), Utils.StrToInt(item["s_subject"].ToString(), 0));
            //    if (subjcetDetail == null)
            //    {
            //        continue;
            //    }
            //    var model = new StatisEntity();
            //    BLL.xiehui xiehuiBll = new BLL.xiehui();
            //    var xiehui = xiehuiBll.GetModel(Utils.StrToInt(item["xiehui_id"].ToString(), 0));

            //    BLL.subject subjectBll = new BLL.subject();
            //    var bSubjectName = subjectBll.GetName(Utils.StrToInt(item["b_subject"].ToString(), 0));
            //    var sSubjectName = subjectBll.GetName(Utils.StrToInt(item["s_subject"].ToString(), 0));

            //    model.Town = xiehui.town;
            //    model.Village = xiehui.village;
            //    model.XieHui = xiehui.name;
            //    model.BBSubjcet = bSubjectName;
            //    model.SSbuject = sSubjectName;
            //    model.Amount = subjcetDetail.amount.ToString();
            //    model.BQJie = item["jie"].ToString();
            //    model.BQDai = item["dai"].ToString();
            //    model.QmAmount = (Utils.StrToInt(subjcetDetail.amount.ToString(), 0) - Utils.StrToInt(item["jie"].ToString(), 0) + Utils.StrToInt(item["dai"].ToString(), 0)).ToString();
            //    list.Add(model);
            //}
            //return list;
        }

        private static string GetAmount(string subjetNmae, DataRow dr)
        {
            BLL.subject subjectBll = new BLL.subject();
            BLL.subject_detail subjectDetailBll = new BLL.subject_detail();

            var xianjinId = subjectBll.GetNavId(subjetNmae);
            var xianjinModel = subjectBll.GetModel(xianjinId);
            var subjcetDetail = subjectDetailBll.GetModel(Utils.ObjToInt(xianjinModel.parent_id, 0), xianjinModel.id);
            var amount = "0";
            if (subjcetDetail != null)
            {
                amount = subjcetDetail.amount.ToString();
                //如果是当前科目则进行计算
                if (Utils.StrToInt(dr["s_subject"].ToString(), 0) == xianjinModel.id)
                {
                    amount = (Utils.StrToInt(subjcetDetail.amount.ToString(), 0) - Utils.StrToInt(dr["jie"].ToString(), 0) + Utils.StrToInt(dr["dai"].ToString(), 0)).ToString();
                }
            }
            return amount;
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
            Response.Redirect(Utils.CombUrlTxt("hz_statis.aspx", "keywords={0}&BSubject={1}&SSubject={2}", txtKeywords.Text, ddlBSubject.SelectedValue, ddlSSubject.SelectedValue));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("hz_statis", DTEnums.ActionEnum.Delete.ToString()); //检查权限
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
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("hz_statis.aspx", "keywords={0}", this.keywords));
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
                    { "XieHui", "现金" },
                    { "YHCK", "银行存款" },
                    { "JCHZJ", "借出互助金" },
                    { "ZCXJ", "资产小计" },
                    { "JCZB", "借出互助金资金占比率" },
                    { "RHHZ", "会员入会互助金" },
                    { "ZFHZJ", "政府拨入互助资金" },
                    { "FZXJ", "负债小计" },
                    { "JZC", "净资产" },
                    { "ZFBZ", "政府补助收入" },
                    { "JCZY", "借出互助资金占用费收入" },
                    { "GYJ", "公益金" },
                    { "SRXJ", "收入小计" },
                    { "HDZC", "业务活动支出" },
                    { "BQJY", "净资产-本期结余" },
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

        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        // 1.获取数据集合
        //        List<StatisEntity> enlist = new List<StatisEntity>();

        //        BLL.subject subjectBll = new BLL.subject();
        //        BLL.xiehui xiehuiBll = new BLL.xiehui();
        //        BLL.account accountBll = new BLL.account();
        //        BLL.subject_detail subjectDetailBll = new BLL.subject_detail();

        //        var subjectList = subjectBll.GetList("parent_id<>0", " parent_id,id").Tables[0];

        //        var list = xiehuiBll.GetList(" no<>'admin'").Tables[0];
        //        foreach (DataRow item in list.Rows)
        //        {
        //            var model = new StatisEntity();
        //            model.XieHui = item["name"].ToString();
        //            model.Town = item["town"].ToString();
        //            model.Village = item["village"].ToString();

        //            foreach (DataRow subjcet in subjectList.Rows)
        //            {
        //                var subjcetDetail = subjectDetailBll.GetModel(Utils.StrToInt(subjcet["parent_id"].ToString(), 0), Utils.StrToInt(subjcet["id"].ToString(), 0));
        //                if (subjcetDetail != null)
        //                {
        //                    model.GetType().GetProperty(subjcet["name"].ToString()).SetValue(model, subjcetDetail.amount.ToString(), null);
        //                    var account = accountBll.GetModel(" date='" + txtKeywords.Text + "' and xiehui_id=" + Utils.StrToInt(item["id"].ToString(), 0) + " and b_subject=" + Utils.StrToInt(subjcet["parent_id"].ToString(), 0) + " and s_subject=" + Utils.StrToInt(subjcet["id"].ToString(), 0));
        //                    if (account != null)
        //                    {
        //                        var amount = (Utils.StrToInt(subjcetDetail.amount.ToString(), 0) - account.jie + account.dai).ToString();

        //                        model.GetType().GetProperty(subjcet["name"].ToString()).SetValue(model, amount, null);
        //                    }
        //                }
        //            }

        //            enlist.Add(model);
        //        }

        //        // 2.设置单元格抬头
        //        // key：实体对象属性名称，可通过反射获取值
        //        // value：Excel列的名称
        //        Dictionary<string, string> cellheader = new Dictionary<string, string>();


        //        cellheader.Add("XieHui", "协会名称");
        //        cellheader.Add("Town", "所属乡镇");
        //        cellheader.Add("Village", "所属村庄");
        //        foreach (DataRow item in subjectList.Rows)
        //        {
        //            var parentName = subjectBll.GetName(Utils.StrToInt(item["parent_id"].ToString(), 0));
        //            cellheader.Add(item["name"].ToString(), item["name"].ToString() + "(" + parentName + ")");
        //        }

        //        // 3.进行Excel转换操作，并返回转换的文件下载链接
        //        string urlPath = ExcelHelper.EntityListToExcel2003(cellheader, enlist, "汇总报表");
        //        System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
        //        //Response.ContentType = "text/plain";
        //        //Response.Write(js.Serialize(urlPath)); // 返回Json格式的内容

        //        string filePath = HttpContext.Current.Server.MapPath("\\" + urlPath);
        //        string path = Server.UrlDecode(filePath);
        //        string fileName = Path.GetFileName(path);//文件名

        //        //以字符流的形式下载文件
        //        FileStream fs = new FileStream(filePath, FileMode.Open);
        //        byte[] bytes = new byte[(int)fs.Length];
        //        fs.Read(bytes, 0, bytes.Length);
        //        fs.Close();
        //        Response.ContentType = "application/octet-stream";
        //        //通知浏览器下载文件而不是打开
        //        Response.AddHeader("Content-Disposition", "attachment;  filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
        //        Response.BinaryWrite(bytes);
        //        Response.Flush();
        //        Response.End();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

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