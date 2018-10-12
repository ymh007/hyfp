using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;
using System.Data;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;

namespace DTcms.Web.admin
{
    public partial class center : Web.UI.ManagePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Model.xiehui admin_info = GetAdminInfo(); //管理员信息
                RptBind("", "add_time asc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            BLL.daikuan bll = new BLL.daikuan();
            this.rptList.DataSource = bll.GetList("");
            this.rptList.DataBind();
            //绑定页码
            string pageUrl = Utils.CombUrlTxt("center.aspx", "keywords={0}&page={1}", "", "__id__");

            var list = GetStatisList();
            this.rptTotal.DataSource = list;
            this.rptTotal.DataBind();

            MemberCount();
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

        public void MemberCount()
        {
            List<string> xData = new List<string>();
            List<int> yData = new List<int>();
            var bll = new BLL.member();
            var ds = bll.GetListByType().Tables[0];
            foreach (DataRow dr in ds.Rows)
            {
                if (dr["type"].ToString() == "0")
                {
                    xData.Add("常规会员");
                }
                else
                {
                    xData.Add("贫困户会员");
                }
                yData.Add(Utils.StrToInt(dr["count"].ToString(), 0));
            }
            Chart1.Series[0]["PieLabelStyle"] = "Outside";//将文字移到外侧 
            Chart1.Series[0]["PieLineColor"] = "Black";//绘制黑色的连线。 
            Chart1.Series[0].Points.DataBindXY(xData, yData);


            List<string> xLevelData = new List<string>();
            List<int> yLevelData = new List<int>();
            var dsLevel = bll.GetListByLevel().Tables[0];
            var bllLevel = new BLL.member_level();
            foreach (DataRow dr in dsLevel.Rows)
            {
                var level = bllLevel.GetName(Utils.StrToInt(dr["level"].ToString(), 0));
                xLevelData.Add(level);
                yLevelData.Add(Utils.StrToInt(dr["count"].ToString(), 0));
            }
            Chart2.Series[0]["PieLabelStyle"] = "Outside";//将文字移到外侧 
            Chart2.Series[0]["PieLineColor"] = "Black";//绘制黑色的连线。 
            Chart2.Series[0].Points.DataBindXY(xLevelData, yLevelData);

            List<string> xTownData = new List<string>();
            List<int> yTownData = new List<int>();
            var dsTown = bll.GetListByTown().Tables[0];
            foreach (DataRow dr in dsTown.Rows)
            {
                var villageBll = new BLL.village();
                var town = villageBll.GetName(Utils.StrToInt(dr["town"].ToString(), 0));
                xTownData.Add(town);
                yTownData.Add(Utils.StrToInt(dr["count"].ToString(), 0));
            }
            Chart3.Series[0]["PieLabelStyle"] = "Outside";//将文字移到外侧 
            Chart3.Series[0]["PieLineColor"] = "Black";//绘制黑色的连线。 
            Chart3.Series[0].Points.DataBindXY(xTownData, yTownData);

            //List<string> xTData = new List<string>() { "A", "B", "C", "D" };
            //List<int> yTData = new List<int>() { 10, 10, 30, 40 };
            ////线条颜色
            //Chart4.Series[0].Color = Color.Green;
            ////线条粗细
            //Chart4.Series[0].BorderWidth = 3;
            ////标记点边框颜色      
            //Chart4.Series[0].MarkerBorderColor = Color.Black;
            ////标记点边框大小
            //Chart4.Series[0].MarkerBorderWidth = 3;
            ////标记点中心颜色
            //Chart4.Series[0].MarkerColor = Color.Red;
            ////标记点大小
            //Chart4.Series[0].MarkerSize = 8;
            ////标记点类型     
            //Chart4.Series[0].MarkerStyle = MarkerStyle.Circle;
            ////将文字移到外侧
            //Chart4.Series[0]["PieLabelStyle"] = "Outside";
            ////绘制黑色的连线
            //Chart4.Series[0]["PieLineColor"] = "Black";
            //Chart4.Series[0].Points.DataBindXY(xTData, yTData);
        }
    }
}