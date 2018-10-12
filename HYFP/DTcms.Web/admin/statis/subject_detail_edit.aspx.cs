using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using System.Web.UI.HtmlControls;
using System.Text;

namespace DTcms.Web.admin.statis
{
    public partial class subject_detail_edit : Web.UI.ManagePage
    {
        private string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;

        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = DTRequest.GetQueryString("action");
            if (!string.IsNullOrEmpty(_action) && _action == DTEnums.ActionEnum.Edit.ToString())
            {
                this.action = DTEnums.ActionEnum.Edit.ToString();//修改类型
                if (!int.TryParse(Request.QueryString["id"] as string, out this.id))
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.subject_detail().Exists(this.id))
                {
                    JscriptMsg("记录不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                TreeBind();


                ChkAdminLevel("subject_detail_list", DTEnums.ActionEnum.View.ToString()); //检查权限
                //Model.subject_detail model = GetAdminInfo(); //取得科目明细信息
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                    subjcet_Change_Click(sender, e);
                }
            }
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

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.subject_detail bll = new BLL.subject_detail();
            Model.subject_detail model = bll.GetModel(_id);
            ddlBSubject.SelectedValue = model.b_subject.ToString();
            ddlSSubject.SelectedValue = model.s_subject.ToString();
            txtAmount.Text = model.amount.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.subject_detail model = new Model.subject_detail();
            BLL.subject_detail bll = new BLL.subject_detail();

            model.b_subject = Utils.StrToInt(ddlBSubject.SelectedValue.ToString(), 0);
            model.s_subject = Utils.StrToInt(ddlSSubject.SelectedValue.ToString(), 0);
            model.amount = Utils.StrToDecimal(Utils.ObjectToStr(txtAmount.Text.Trim()), 0);

            if (bll.Add(model) > 0)
            {
                //AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加科目明细频道内容"); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.subject_detail bll = new BLL.subject_detail();
            Model.subject_detail model = bll.GetModel(_id);
            model.b_subject = Utils.StrToInt(ddlBSubject.SelectedValue.ToString(), 0);
            model.s_subject = Utils.StrToInt(ddlSSubject.SelectedValue.ToString(), 0);
            model.amount = Utils.StrToDecimal(Utils.ObjectToStr(txtAmount.Text.Trim()), 0);
            if (bll.Update(model))
            {
                //AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改科目明细"); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
            {
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改科目明细成功！", "subject_detail_list.aspx");
            }
            else //添加
            {
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加科目明细成功！", "subject_detail_list.aspx");
            }
        }

        //保存
        public void subjcet_Change_Click(object sender, EventArgs e)
        {
            if (ddlBSubject.SelectedValue.ToString() != "0")
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