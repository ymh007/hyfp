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
    public partial class student_edit : Web.UI.ManagePage
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
            if (_action == DTEnums.ActionEnum.Edit.ToString() || _action == DTEnums.ActionEnum.Copy.ToString() || _action == DTEnums.ActionEnum.Build.ToString())
            {
                txtNo.ReadOnly = true;
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
                if (action == DTEnums.ActionEnum.Edit.ToString() || _action == DTEnums.ActionEnum.Build.ToString()) //修改
                {
                    ShowInfo(this.id);
                    //上传简历
                    if (_action == DTEnums.ActionEnum.Build.ToString())
                    {
                        txtNo.ReadOnly = true;
                        txtName.ReadOnly = true;
                        txtSchool.ReadOnly = true;
                        txtScore.ReadOnly = true;
                        txtReScore.ReadOnly = true;
                        txtAddTime.ReadOnly = true;
                        rblIsAca.Enabled = false;
                    }
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.student bll = new BLL.student();
            Model.student model = bll.GetModel(_id);

            txtNo.Text = model.no;
            txtName.Text = model.name;
            txtSchool.Text = model.school;
            txtScore.Text = model.score;
            txtReScore.Text = model.re_score;
            txtAttach.Text = model.attach;
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
            rblIsAca.SelectedValue = model.is_aca.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.student model = new Model.student();
            BLL.student bll = new BLL.student();

            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.school = txtSchool.Text.Trim();
            model.score = txtScore.Text.Trim();
            model.re_score = txtReScore.Text.Trim();
            model.attach = txtAttach.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.is_aca = Utils.ObjectToStr(rblIsAca.SelectedValue);
            //该研究生已经存在
            if (bll.Exists(model.no))
            {
                JscriptMsg("编号不能重复！", string.Empty);
                return result;
            }

            if (bll.Add(model) > 0)
            {
                Model.manager manModel = new Model.manager();
                BLL.manager manBll = new BLL.manager();
                //不存在用户则进行提前加
                if (!manBll.Exists(model.no))
                {
                    manModel.role_id = 2;
                    manModel.role_type = new BLL.manager_role().GetModel(manModel.role_id).role_type;
                    manModel.is_lock = 0;
                    manModel.user_name = model.no;
                    manModel.real_name = model.name;
                    //获得6位的salt加密字符串
                    manModel.salt = Utils.GetCheckCode(6);
                    //以随机生成的6位字符串做为密钥加密
                    manModel.password = DESEncrypt.Encrypt(model.no + "123", manModel.salt);
                    manModel.real_name = model.name;
                    manModel.add_time = DateTime.Now;
                    manBll.Add(manModel);
                }

                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加研究生" + model.name); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.student bll = new BLL.student();
            Model.student model = bll.GetModel(_id);

            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.school = txtSchool.Text.Trim();
            model.score = txtScore.Text.Trim();
            model.re_score = txtReScore.Text.Trim();
            model.attach = txtAttach.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.is_aca = Utils.ObjectToStr(rblIsAca.SelectedValue);

            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改研究生" + model.name); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == DTEnums.ActionEnum.Edit.ToString() || action == DTEnums.ActionEnum.Build.ToString()) //修改
            {
                if (action != DTEnums.ActionEnum.Build.ToString())
                {
                    ChkAdminLevel("student", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                }
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "student_list.aspx?channel_id=" + 0);
            }
            else //添加
            {
                ChkAdminLevel("student", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "student_list.aspx?channel_id=" + 0);
            }
        }

    }
}