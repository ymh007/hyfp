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
    public partial class teacher_choose : Web.UI.ManagePage
    {
        private string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        protected string channel_name = string.Empty; //频道名称
        private int id = 0;

        //页面初始化事件
        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = DTRequest.GetQueryString("action");

            //如果是编辑或复制则检查信息是否存在
            if (_action == DTEnums.ActionEnum.Edit.ToString())
            {
                this.action = _action;//修改类型
                this.id = DTRequest.GetQueryInt("id");
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.student().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                RptBind("id>0", "name asc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            BLL.teacher bll = new BLL.teacher();
            if (this.action == DTEnums.ActionEnum.Edit.ToString())
            {
                BLL.student studentBll = new BLL.student();
                Model.student studentModel = studentBll.GetModel(this.id);
                txtIsAsa.Value = studentModel.is_aca;
                //如果是学术型研究生则只能看到学术型导师
                if (studentModel.is_aca == "1")
                {
                    _strWhere += " and is_aca='1' and resquota>0";
                }
                else if (studentModel.is_aca == "0")
                {
                    _strWhere += " and is_pro='1' and pro_resquota>0";
                }
                //导师列表
                this.rptList1.Visible = true;
                this.rptList1.DataSource = bll.GetList(0, _strWhere, _orderby);
                this.rptList1.DataBind();
            }
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
            {
                BLL.student bll = new BLL.student();
                Model.student model = bll.GetModel(this.id);
                if (model.status == "导师已通过您的申请")
                {
                    JscriptMsg("导师已通过您的申请	！", string.Empty);
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
                    JscriptMsg("请选择一名导师！", string.Empty);
                    return;
                }
                if (selectList.Count > 1)
                {
                    JscriptMsg("您只能选择一名导师！", string.Empty);
                    return;
                }
                if (selectList.Count > 0)
                {
                    BLL.teacher teacherBll = new BLL.teacher();
                    var requota = "0";
                    //学术型研究生
                    if (model.is_aca == "1")
                    {
                        requota = teacherBll.GetQuota(selectList[0]);
                    }
                    else
                    {
                        requota = teacherBll.GetProResQuota(selectList[0]);
                    }
                    if (Utils.ObjToInt(requota) == 0)
                    {
                        JscriptMsg("您选择的导师配额已满，请重新选择！", string.Empty);
                        return;
                    }
                    model.teacher_id = selectList[0];
                }
                else
                {
                    JscriptMsg("请选择导师！", string.Empty);
                    return;
                }
                model.status = "待导师确认";
                if (!bll.Update(model))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("选择导师成功！", Utils.CombUrlTxt("student_list.aspx", "keywords={0}&property={1}",
               "", ""));
            }
        }

    }
}