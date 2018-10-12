using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;

namespace DTcms.Web.admin.article
{
    public partial class teacher_list : Web.UI.ManagePage
    {
        protected int channel_id;
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string property = string.Empty;
        protected string keywords = string.Empty;
        protected string prolistview = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pageSize = GetPageSize(10); //每页数量
            this.prolistview = Utils.GetCookie("article_list_view"); //显示方式
            if (!Page.IsPostBack)
            {
                RptBind("id>0", "id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = DTRequest.GetQueryInt("page", 1);
            Model.manager model = GetAdminInfo();
            labRoleId.Value = model.role_id.ToString();
            string strWhere = "";
            if (model.role_id == 3)
            {
                strWhere = " and no='" + model.user_name + "'";
            }
            //图表或列表显示
            BLL.teacher bll = new BLL.teacher();
            this.rptList1.DataSource = bll.GetList(this.pageSize, this.page, _strWhere + strWhere, _orderby, out this.totalCount);
            this.rptList1.DataBind();

            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("teacher_list.aspx", "property={0}&page={1}",
                this.property, "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("article_page_size", "DTcmsPage"), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    return _pagesize;
                }
            }
            return _default_size;
        }
        #endregion

        //设置操作
        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(((HiddenField)e.Item.FindControl("hidId")).Value);
            BLL.article bll = new BLL.article();
            Model.article model = bll.GetModel(id);
        }

        //设置分页数量
        protected void txtPageNum_TextChanged(object sender, EventArgs e)
        {
            int _pagesize;
            if (int.TryParse(txtPageNum.Text.Trim(), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    Utils.WriteCookie("article_page_size", "DTcmsPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("teacher_list.aspx", "keywords={0}&property={1}",
                 this.keywords, this.property));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("teacher", DTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.teacher bll = new BLL.teacher();
            Repeater rptList = new Repeater();
            rptList = this.rptList1;

            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    var model = bll.GetModel(id);
                    if (!string.IsNullOrEmpty(model.students))
                    {
                        JscriptMsg("导师【" + model.name + "】已经选择学生，无法删除！", "back");
                        return;
                    }

                    BLL.student studentBll = new BLL.student();
                    var studentList = studentBll.GetList(0, " teacher_id!='' and teacher_id is not null", "id asc");
                    var teacherIdList = new List<string>();
                    foreach (DataRow item in studentList.Rows)
                    {
                        teacherIdList.Add(Utils.ObjectToStr(item["teacher_id"]));
                    }
                    if (teacherIdList.Contains(id.ToString()))
                    {
                        JscriptMsg("导师【" + model.name + "】已经被学生选择，无法删除！", "back");
                        return;
                    }
                    if (bll.Delete(id))
                    {
                        sucCount++;
                    }
                    else
                    {
                        errorCount++;
                    }
                }
            }
            AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "删除导师资料成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("teacher_list.aspx", "keywords={0}&property={1}",
               this.keywords, this.property));
        }

        #region 数据导入
        protected void btnImport_Click(object sender, EventArgs e)
        {
            StringBuilder errorMsg = new StringBuilder(); // 错误信息
            try
            {
                #region 1.获取Excel文件并转换为一个List集合

                // 1.1存放Excel文件到本地服务器
                string filePath = Server.MapPath(txtImgUrl.Text.Trim()); // 保存文件并获取文件路径

                // 单元格抬头
                // key：实体对象属性名称，可通过反射获取值
                // value：属性对应的中文注解
                Dictionary<string, string> cellheader = new Dictionary<string, string> { 
                    { "No", "导师工号" }, 
                    { "Name", "姓名" }, 
                    { "IsAca", "是否为学术型导师" },
                    { "Quota", "学硕分配指标" }, 
                    { "IsPro", "是否为专业性导师" },
                    { "ProQuota", "专硕分配指标" },
                    { "Email", "邮箱" }, 
                    { "Direction", "研究方向" }, 
                    { "Major", "专业" }, 
                    { "Password", "密码" }, 
                };

                // 1.2解析文件，存放到一个List集合里
                List<TeacherEntity> enlist = ExcelHelper.ExcelToEntityList<TeacherEntity>(cellheader, filePath, out errorMsg);

                #endregion
                var sucCount = 0;
                for (int i = 0; i < enlist.Count; i++)
                {
                    TeacherEntity en = enlist[i];
                    string errorMsgStr = "第" + (i + 1) + "行数据检测异常：";
                    //未填写研究生编号
                    if (string.IsNullOrWhiteSpace(en.No))
                    {
                        continue;
                    }
                    Model.teacher model = new Model.teacher();
                    BLL.teacher bll = new BLL.teacher();
                    //该研究生已经存在
                    if (bll.Exists(en.No))
                    {
                        continue;
                    }
                    model.no = en.No;
                    model.name = en.Name;
                    model.quota = en.Quota;
                    model.resquota = en.Quota;
                    model.email = en.Email;
                    model.direction = en.Direction;
                    model.major = en.Major;
                    model.is_aca = en.IsAca;
                    model.is_pro = en.IsPro;
                    model.pro_quota = en.ProQuota;
                    model.pro_resquota = en.ProQuota;
                    model.add_time = DateTime.Now;
                    bll.Add(model);
                    sucCount++;

                    Model.manager manModel = new Model.manager();
                    BLL.manager manBll = new BLL.manager();
                    //该用户已经存在
                    if (manBll.Exists(en.No))
                    {
                        continue;
                    }
                    manModel.role_id = 3;
                    manModel.role_type = new BLL.manager_role().GetModel(manModel.role_id).role_type;
                    manModel.is_lock = 0;
                    manModel.user_name = en.No;
                    manModel.real_name = en.Name;
                    //获得6位的salt加密字符串
                    manModel.salt = Utils.GetCheckCode(6);
                    //以随机生成的6位字符串做为密钥加密
                    manModel.password = DESEncrypt.Encrypt(en.Password, manModel.salt);
                    manModel.real_name = en.Name;
                    manModel.add_time = DateTime.Now;
                    manBll.Add(manModel);
                }
                //context.Response.Write("{\"status\": 1, \"msg\": \"导入成功！\"}");
                JscriptMsg("导入成功" + sucCount + "条", Utils.CombUrlTxt("teacher_list.aspx", "keywords={0}&property={1}",
               this.keywords, this.property));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        #endregion
    }
}