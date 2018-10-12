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

namespace DTcms.Web.admin.article
{
    public partial class student_choose : Web.UI.ManagePage
    {
        private string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string property = string.Empty;
        protected string keywords = string.Empty;
        protected string prolistview = string.Empty;

        //页面初始化事件
        protected void Page_Init(object sernder, EventArgs e)
        {

        }

        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = DTRequest.GetQueryString("action");
            this.id = DTRequest.GetQueryInt("id");
            Model.manager model = GetAdminInfo();
            if (model.role_id == 1)
            {
                btnCancel.Visible = true;
            }
            else
            {
                btnCancel.Visible = false;
            }
            //如果是编辑或复制则检查信息是否存在
            if (_action == DTEnums.ActionEnum.Edit.ToString())
            {
                this.action = _action;//修改类型
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.teacher().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                BLL.teacher bll = new BLL.teacher();
                var students = bll.GetStudentIds(this.id);
                var strWhere = "";
                if (!string.IsNullOrEmpty(students))
                {
                    strWhere = "and id not in(select * from dbo.f_split((select students from dt_teacher where id=" + this.id + "),','))";
                }
                RptBind("id>0 and teacher_id=" + this.id + strWhere, "name asc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            BLL.student bll = new BLL.student();
            if (this.action == DTEnums.ActionEnum.Edit.ToString())
            {
                BLL.teacher teacherBll = new BLL.teacher();
                var selectStudetns = teacherBll.GetStudentIds(this.id);

                //未选择学生
                this.rptList1.Visible = true;
                this.rptList1.DataSource = bll.GetList(0, _strWhere + " and (status='' or status is null or status='待导师确认')", _orderby);
                this.rptList1.DataBind();
                btnCancel.Visible = false;
            }
            else
            {
                //已选择学生
                this.rptList2.Visible = true;
                this.rptList2.DataSource = bll.GetList(0, " id in(select * from dbo.f_split((select students from dt_teacher where id=" + this.id + "),','))", _orderby);
                this.rptList2.DataBind();
                btnSubmit.Visible = false;
                //btnCancel.Visible = true;
            }
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
            {
                int sucCount = 0; //成功数量
                int errorCount = 0; //失败数量
                BLL.teacher bll = new BLL.teacher();
                Model.teacher model = bll.GetModel(this.id);
                if (Utils.ObjToInt(model.resquota) == 0 && Utils.ObjToInt(model.pro_resquota) == 0)
                {
                    JscriptMsg("您的名额已满！", string.Empty);
                    return;
                }
                var selectList = new List<int>();
                var unSelectList = new List<int>();
                StringBuilder tempStr = new StringBuilder();
                for (int i = 0; i < rptList1.Items.Count; i++)
                {
                    int id = Convert.ToInt32(((HiddenField)rptList1.Items[i].FindControl("hidId")).Value);
                    CheckBox cb = (CheckBox)rptList1.Items[i].FindControl("chkId");
                    if (cb.Checked)
                    {
                        selectList.Add(id);
                        tempStr.Append(id + ",");
                    }
                    else
                    {
                        unSelectList.Add(id);
                    }
                }
                if (selectList.Count == 0)
                {
                    JscriptMsg("请选择研究生！", string.Empty);
                    return;
                }
                if (selectList.Count > Utils.ObjToInt(model.resquota) + Utils.ObjToInt(model.pro_resquota))
                {
                    JscriptMsg("您选中学生过多，超出的您的配额！", string.Empty);
                    btnCancel.Visible = false;
                    return;
                }
                model.students = string.IsNullOrEmpty(model.students) ? Utils.DelLastComma(tempStr.ToString()) : model.students + "," + Utils.DelLastComma(tempStr.ToString());

                var xsQuota = 0;
                var zsQuota = 0;
                foreach (var item in selectList)
                {
                    BLL.student studentBll = new BLL.student();
                    Model.student studentModel = studentBll.GetModel(Utils.ObjToInt(item));
                    //学术型研究生
                    if (studentModel.is_aca == "1")
                    {
                        xsQuota++;
                    }
                    else
                    {
                        zsQuota++;
                    }
                }
                if (xsQuota > Utils.StrToInt(model.resquota, 0))
                {
                    JscriptMsg("您选中学生过多，超出的您您的学硕配额！", string.Empty);
                    btnCancel.Visible = false;
                    return;
                }
                if (zsQuota > Utils.StrToInt(model.pro_resquota, 0))
                {
                    JscriptMsg("您选中学生过多，超出的您您的专硕配额！", string.Empty);
                    btnCancel.Visible = false;
                    return;
                }

                foreach (var item in selectList)
                {
                    BLL.student studentBll = new BLL.student();
                    Model.student studentModel = studentBll.GetModel(Utils.ObjToInt(item));
                    //学术型研究生
                    if (studentModel.is_aca == "1")
                    {
                        model.resquota = (Utils.ObjToInt(model.resquota) - 1).ToString();
                    }
                    else
                    {
                        model.pro_resquota = (Utils.ObjToInt(model.pro_resquota) - 1).ToString();
                    }
                    studentModel.status = "导师已通过您的申请";
                    if (studentBll.Update(studentModel))
                    {
                        sucCount++;
                    }
                    else
                    {
                        errorCount++;
                    }
                }
                foreach (var item in unSelectList)
                {
                    BLL.student studentBll = new BLL.student();
                    Model.student studentModel = studentBll.GetModel(Utils.ObjToInt(item));
                    studentModel.status = "导师未通过您的申请，请再次操作选择其他导师";
                    studentBll.Update(studentModel);
                }

                if (!bll.Update(model))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("选择研究生成功！", Utils.CombUrlTxt("teacher_list.aspx", "keywords={0}&property={1}",
               this.keywords, this.property));
            }
        }

        //取消选择
        protected void btnCalcel_Click(object sender, EventArgs e)
        {
            BLL.teacher bll = new BLL.teacher();
            Model.teacher model = bll.GetModel(this.id);
            var selectList = new List<int>();
            var unSelectList = new List<int>();
            StringBuilder tempStr = new StringBuilder();
            for (int i = 0; i < rptList2.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList2.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList2.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    selectList.Add(id);
                }
                else
                {
                    unSelectList.Add(id);
                    tempStr.Append(id + ",");
                }
            }
            if (selectList.Count == 0)
            {
                JscriptMsg("请选择研究生！", string.Empty);
                return;
            }
            model.students = Utils.DelLastComma(tempStr.ToString());

            foreach (var item in selectList)
            {
                BLL.student studentBll = new BLL.student();
                Model.student studentModel = studentBll.GetModel(Utils.ObjToInt(item));

                //学术型研究生
                if (studentModel.is_aca == "1")
                {
                    model.resquota = (Utils.ObjToInt(model.resquota) + 1).ToString();
                }
                else
                {
                    model.pro_resquota = (Utils.ObjToInt(model.pro_resquota) + 1).ToString();
                }

                studentModel.status = "导师未通过您的申请，请再次操作选择其他导师";
                studentBll.Update(studentModel);
            }

            if (!bll.Update(model))
            {
                JscriptMsg("保存过程中发生错误啦！", string.Empty);
                return;
            }
            JscriptMsg("取消选择研究生成功！", Utils.CombUrlTxt("teacher_list.aspx", "keywords={0}&property={1}",
               this.keywords, this.property));
        }
    }
}