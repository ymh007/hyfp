using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;

namespace DTcms.Web.admin.dialog
{
    public partial class teacher_print : Web.UI.ManagePage
    {
        private int teacher_id = 0;
        protected Model.teacher model = new Model.teacher();
        protected Model.xiehui adminModel = new Model.xiehui();

        protected void Page_Load(object sender, EventArgs e)
        {
            teacher_id = DTRequest.GetQueryIntValue("teacher_id");
            if (teacher_id == 0)
            {
                JscriptMsg("传输参数不正确！", "back");
                return;
            }
            if (!new BLL.teacher().Exists(teacher_id))
            {
                JscriptMsg("订单不存在或已被删除！", "back");
                return;
            }
            if (!Page.IsPostBack)
            {
                ShowInfo(teacher_id);
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int teacher_id)
        {
            BLL.teacher bll = new BLL.teacher();
            model = bll.GetModel(teacher_id);
            adminModel = GetAdminInfo();
            this.rptList.DataSource = bll.GetList(0, "id=" + teacher_id, " name ");
            this.rptList.DataBind();

            BLL.student studentBll = new BLL.student();
            var students = bll.GetStudentIds(teacher_id);
            var strWhere = "";
            if (!string.IsNullOrEmpty(students))
            {
                strWhere = " id in(select * from dbo.f_split((select students from dt_teacher where id=" + teacher_id + "),','))";
                this.rptList1.DataSource = studentBll.GetList(0, strWhere, "name asc");
                this.rptList1.DataBind();
            }
           
        }
        #endregion
    }
}