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
    public partial class teacher_edit : Web.UI.ManagePage
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
            if (_action == DTEnums.ActionEnum.Edit.ToString() || _action == DTEnums.ActionEnum.Copy.ToString())
            {
                txtNo.ReadOnly = true;
                this.action = _action;//修改类型
                this.id = DTRequest.GetQueryInt("id");
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
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.teacher bll = new BLL.teacher();
            Model.teacher model = bll.GetModel(_id);

            txtNo.Text = model.no;
            txtName.Text = model.name;
            txtQuota.Text = model.quota;
            txtEmail.Text = model.email;
            txtDirection.Text = model.direction;
            txtMajor.Text = model.major;
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
            rblIsAca.SelectedValue = model.is_aca.ToString();
            rblIsPro.SelectedValue = model.is_pro.ToString();
            txtProQuota.Text = model.pro_quota;
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.teacher model = new Model.teacher();
            BLL.teacher bll = new BLL.teacher();

            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.quota = txtQuota.Text.Trim();
            model.email = txtEmail.Text.Trim();
            model.direction = txtDirection.Text.Trim();
            model.major = txtMajor.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.is_aca = Utils.ObjectToStr(rblIsAca.SelectedValue);
            model.is_pro = Utils.ObjectToStr(rblIsPro.SelectedValue);
            model.pro_quota = txtProQuota.Text.Trim(); ;
            model.resquota = model.quota;
            model.pro_resquota = model.pro_quota;
            //该导师已经存在
            if (bll.Exists(model.no))
            {
                JscriptMsg("工号不能重复！", string.Empty);
                return result;
            }
            if (bll.Add(model) > 0)
            {
                Model.manager manModel = new Model.manager();
                BLL.manager manBll = new BLL.manager();
                //不存在用户则进行提前加
                if (!manBll.Exists(model.no))
                {
                    manModel.role_id = 3;
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
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加导师" + model.name); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.teacher bll = new BLL.teacher();
            Model.teacher model = bll.GetModel(_id);

            model.no = txtNo.Text.Trim();
            model.name = txtName.Text.Trim();
            model.email = txtEmail.Text.Trim();
            model.direction = txtDirection.Text.Trim();
            model.major = txtMajor.Text.Trim();
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.is_aca = Utils.ObjectToStr(rblIsAca.SelectedValue);
            model.is_pro = Utils.ObjectToStr(rblIsPro.SelectedValue);

            var quota = txtQuota.Text.Trim();
            //如果增加导师指标,则对应增加剩余指标
            if (Utils.ObjToInt(quota) != Utils.ObjToInt(model.quota))
            {
                if (model.is_aca == "0")
                {
                    JscriptMsg("该导师不是学术型导师，无法修改学硕指标！", string.Empty);
                    return false;
                }
                if (Utils.ObjToInt(quota) > Utils.ObjToInt(model.quota))
                {
                    //增加指标数
                    var addQuota = Utils.ObjToInt(quota) - Utils.ObjToInt(model.quota);
                    model.resquota = Utils.ObjectToStr(Utils.ObjToInt(model.resquota) + addQuota);
                    model.quota = quota;
                }
                else
                {
                    //减少指标数
                    var resQuota = Utils.ObjToInt(model.quota) - Utils.ObjToInt(quota);
                    var resquota = Utils.ObjToInt(model.resquota) - resQuota;
                    if (resquota < 0)
                    {
                        JscriptMsg("由于您是减少指标，请先取消相应研究生的选择以确保指标正常！", string.Empty);
                        return false;
                    }
                    model.resquota = Utils.ObjectToStr(resquota);
                    model.quota = quota;
                }
            }
            var proQuota = txtProQuota.Text.Trim();
            //如果增加导师指标,则对应增加剩余指标
            if (Utils.ObjToInt(proQuota) != Utils.ObjToInt(model.pro_quota))
            {
                if (model.is_pro == "0")
                {
                    JscriptMsg("该导师不是专业型导师，无法修改专硕指标！", string.Empty);
                    return false;
                }
                if (Utils.ObjToInt(proQuota) > Utils.ObjToInt(model.pro_quota))
                {
                    //增加指标数
                    var addQuota = Utils.ObjToInt(proQuota) - Utils.ObjToInt(model.pro_quota);
                    model.pro_resquota = Utils.ObjectToStr(Utils.ObjToInt(model.pro_resquota) + addQuota);
                    model.pro_quota = proQuota;
                }
                else
                {
                    //减少指标数
                    var resQuota = Utils.ObjToInt(model.pro_quota) - Utils.ObjToInt(proQuota);
                    var resquota = Utils.ObjToInt(model.pro_resquota) - resQuota;
                    if (resquota < 0)
                    {
                        JscriptMsg("由于您是减少指标，请先取消相应研究生的选择以确保指标正常！", string.Empty);
                        return false;
                    }
                    model.pro_resquota = Utils.ObjectToStr(resquota);
                    model.pro_quota = proQuota;
                }
            }


            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改导师" + model.name); //记录日志
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
                ChkAdminLevel("teacher", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "teacher_list.aspx?channel_id=" + 0);
            }
            else //添加
            {
                ChkAdminLevel("teacher", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "teacher_list.aspx?channel_id=" + 0);
            }
        }

    }
}