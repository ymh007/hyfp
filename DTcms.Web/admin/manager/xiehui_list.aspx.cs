using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using DTcms.Web.admin.article;

namespace DTcms.Web.admin.manager
{
    public partial class xiehui_list : Web.UI.ManagePage
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
                ChkAdminLevel("xiehui", DTEnums.ActionEnum.View.ToString()); //检查权限
                Model.xiehui model = GetAdminInfo(); //取得当前管理员信息
                var strWhere = "id>0" + CombSqlTxt(this.keywords);
                RptBind(strWhere, "add_time asc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            BLL.xiehui bll = new BLL.xiehui();
            DataTable dt = bll.GetList(0);
            this.rptList.DataSource = dt;
            this.rptList.DataBind();
        }
        #endregion


        //美化列表
        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                Literal LitFirst = (Literal)e.Item.FindControl("LitFirst");
                HiddenField hidLayer = (HiddenField)e.Item.FindControl("hidLayer");
                string LitStyle = "<span style=\"display:inline-block;width:{0}px;\"></span>{1}{2}";
                string LitImg1 = "<span class=\"folder-open\"></span>";
                string LitImg2 = "<span class=\"folder-line\"></span>";

                int classLayer = Convert.ToInt32(hidLayer.Value);
                if (classLayer == 1)
                {
                    LitFirst.Text = LitImg1;
                }
                else
                {
                    LitFirst.Text = string.Format(LitStyle, (classLayer - 2) * 24, LitImg2, LitImg1);
                }
            }
        }

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

        //保存排序
        protected void btnSave_Click(object sender, EventArgs e)
        {
            BLL.xiehui bll = new BLL.xiehui();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                int sortId;
                if (!int.TryParse(((TextBox)rptList.Items[i].FindControl("txtSortId")).Text.Trim(), out sortId))
                {
                    sortId = 99;
                }
                bll.UpdateField(id, "sort_id=" + sortId.ToString());
            }
            AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "保存导航排序"); //记录日志
            JscriptMsg("保存排序成功！", "xiehui_list.aspx");
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("xiehui_list", DTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0;
            int errorCount = 0;
            BLL.xiehui bll = new BLL.xiehui();
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
            AddAdminLog(DTEnums.ActionEnum.Delete.ToString(), "删除管理员" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("xiehui_list.aspx", "keywords={0}", this.keywords));
        }

        //protected void btnImport_Click(object sender, EventArgs e)
        //{
        //    StringBuilder errorMsg = new StringBuilder(); // 错误信息
        //    try
        //    {
        //        #region 1.获取Excel文件并转换为一个List集合


        //        // 1.1存放Excel文件到本地服务器
        //        string filePath = Server.MapPath(txtImgUrl.Text.Trim()); // 保存文件并获取文件路径

        //        // 单元格抬头
        //        // key：实体对象属性名称，可通过反射获取值
        //        // value：属性对应的中文注解
        //        Dictionary<string, string> cellheader = new Dictionary<string, string> { 
        //            { "Name", "名称" }, 
        //            { "Village", "所属乡" }, 
        //            { "Town", "所属镇" }, 
        //            { "Person", "协会负责人" }, 
        //            { "Tel", "电话" }, 
        //            { "Address", "地址" }, 
        //            { "No", "账号" }, 
        //            { "Password", "密码" }, 
        //        };

        //        // 1.2解析文件，存放到一个List集合里
        //        List<XieHuiEntity> enlist = ExcelHelper.ExcelToEntityList<XieHuiEntity>(cellheader, filePath, out errorMsg);

        //        #endregion
        //        var sucCount = 0;
        //        for (int i = 0; i < enlist.Count; i++)
        //        {
        //            XieHuiEntity en = enlist[i];
        //            string errorMsgStr = "第" + (i + 1) + "行数据检测异常：";
        //            //未填写研究生编号
        //            if (string.IsNullOrWhiteSpace(en.No))
        //            {
        //                continue;
        //            }
        //            Model.xiehui model = new Model.xiehui();
        //            BLL.xiehui bll = new BLL.xiehui();
        //            //该协会账号已经存在
        //            if (bll.Exists(en.No))
        //            {
        //                continue;
        //            }
        //            model.name = en.Name;
        //            model.village = en.Village;
        //            model.town = en.Town;
        //            model.person = en.Person;
        //            model.address = en.Address;
        //            model.no = en.No;
        //            model.add_time = DateTime.Now;

        //            //获得6位的salt加密字符串
        //            model.salt = Utils.GetCheckCode(6);
        //            model.password = DESEncrypt.Encrypt(en.No + "123", model.salt);
        //            //以随机生成的6位字符串做为密钥加密
        //            if (!string.IsNullOrEmpty(en.Password))
        //            {
        //                model.password = DESEncrypt.Encrypt(en.Password, model.salt);
        //            }

        //            bll.Add(model);
        //            sucCount++;
        //        }
        //        //context.Response.Write("{\"status\": 1, \"msg\": \"导入成功！\"}");
        //        JscriptMsg("导入成功" + sucCount + "条", Utils.CombUrlTxt("xiehui_list.aspx", "keywords={0}",
        //       this.keywords));
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
    }
}