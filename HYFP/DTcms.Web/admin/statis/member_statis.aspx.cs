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
    public partial class member_statis : Web.UI.ManagePage
    {
        protected void Page_Load(object sender, EventArgs e)
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
        }
    }
}