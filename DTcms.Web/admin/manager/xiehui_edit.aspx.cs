using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using System.Web.UI.HtmlControls;
using System.Text;

namespace DTcms.Web.admin.xiehui
{
    public partial class xiehui_edit : Web.UI.ManagePage
    {
        string defaultpassword = "0|0|0|0"; //默认显示密码
        private string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;

        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = DTRequest.GetQueryString("action");
            this.id = DTRequest.GetQueryInt("id");

            if (!string.IsNullOrEmpty(_action) && _action == DTEnums.ActionEnum.Edit.ToString())
            {
                this.action = DTEnums.ActionEnum.Edit.ToString();//修改类型
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.xiehui().Exists(this.id))
                {
                    JscriptMsg("类别不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                TreeBind(); //绑定类别
                Model.xiehui model = GetAdminInfo(); //取得管理员信息
                RoleBind(ddlRoleId, model.role_type);
                if (action == DTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
                else
                {
                    if (this.id > 0)
                    {
                        this.ddlParentId.SelectedValue = this.id.ToString();
                    }
                }
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.xiehui bll = new BLL.xiehui();
            DataTable dt = bll.GetList(0);

            this.ddlParentId.Items.Clear();
            this.ddlParentId.Items.Add(new ListItem("无父级", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                int ClassLayer = int.Parse(dr["class_layer"].ToString());
                string Title = dr["name"].ToString().Trim();

                if (ClassLayer == 1)
                {
                    this.ddlParentId.Items.Add(new ListItem(Title, Id));
                }
                else
                {
                    Title = "├ " + Title;
                    Title = Utils.StringOfChar(ClassLayer - 1, "　") + Title;
                    this.ddlParentId.Items.Add(new ListItem(Title, Id));
                }
            }
        }
        #endregion

        #region 角色类型=================================
        private void RoleBind(DropDownList ddl, int role_type)
        {
            BLL.manager_role bll = new BLL.manager_role();
            DataTable dt = bll.GetList("").Tables[0];

            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("请选择角色...", ""));
            foreach (DataRow dr in dt.Rows)
            {
                if (Convert.ToInt32(dr["role_type"]) >= role_type)
                {
                    ddl.Items.Add(new ListItem(dr["role_name"].ToString(), dr["id"].ToString()));
                }
            }

            BLL.village villageBll = new BLL.village();
            DataTable dtVillage = villageBll.GetParentList(0);

            ddlTown.Items.Clear();
            ddlTown.Items.Add(new ListItem("请选择所属乡镇", "0"));
            foreach (DataRow dr in dtVillage.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["name"].ToString().Trim();
                ddlTown.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.xiehui bll = new BLL.xiehui();
            Model.xiehui model = bll.GetModel(_id);
            ddlParentId.SelectedValue = model.parent_id.ToString();
            ddlRoleId.SelectedValue = model.role_id.ToString();
            txtUserName.Text = model.no;
            txtUserName.ReadOnly = true;
            txtUserName.Attributes.Remove("ajaxurl");
            if (!string.IsNullOrEmpty(model.password))
            {
                txtPassword.Attributes["value"] = txtPassword1.Attributes["value"] = defaultpassword;
            }
            txtRealName.Text = model.name;
            ddlTown.SelectedValue = model.town;
            town_Change_Click("", new EventArgs());
            ddlVillage.SelectedValue = model.village;
            txtPerson.Text = model.person;
            txtTel.Text = model.tel;
            txtAddress.Text = model.address;
            if (model.is_lock == 0)
            {
                cbIsLock.Checked = true;
            }
            else
            {
                cbIsLock.Checked = false;
            }
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            Model.xiehui model = new Model.xiehui();
            BLL.xiehui bll = new BLL.xiehui();
            model.parent_id = int.Parse(ddlParentId.SelectedValue);
            model.role_id = int.Parse(ddlRoleId.SelectedValue);
            model.role_type = new BLL.manager_role().GetModel(model.role_id).role_type;
            if (cbIsLock.Checked == true)
            {
                model.is_lock = 0;
            }
            else
            {
                model.is_lock = 1;
            }
            //检测用户名是否重复
            if (bll.Exists(txtUserName.Text.Trim()))
            {
                return false;
            }
            model.no = txtUserName.Text.Trim();
            //获得6位的salt加密字符串
            model.salt = Utils.GetCheckCode(6);
            //以随机生成的6位字符串做为密钥加密
            model.password = DESEncrypt.Encrypt(txtPassword.Text.Trim(), model.salt);
            model.name = txtRealName.Text.Trim();
            model.town = ddlTown.SelectedValue.ToString();
            model.village = ddlVillage.SelectedValue.ToString();
            model.person = txtPerson.Text.Trim();
            model.tel = txtTel.Text.Trim();
            model.address = txtAddress.Text.Trim();
            model.add_time = DateTime.Now;

            if (bll.Add(model) > 0)
            {
                AddAdminLog(DTEnums.ActionEnum.Add.ToString(), "添加账号:" + model.no); //记录日志
                return true;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.xiehui bll = new BLL.xiehui();
            Model.xiehui model = bll.GetModel(_id);
            int parentId = int.Parse(ddlParentId.SelectedValue);
            //如果选择的父ID不是自己,则更改
            if (parentId != model.id)
            {
                model.parent_id = parentId;
            }
            model.role_id = int.Parse(ddlRoleId.SelectedValue);
            model.role_type = new BLL.manager_role().GetModel(model.role_id).role_type;
            if (cbIsLock.Checked == true)
            {
                model.is_lock = 0;
            }
            else
            {
                model.is_lock = 1;
            }
            //判断密码是否更改
            if (txtPassword.Text.Trim() != defaultpassword)
            {
                //获取用户已生成的salt作为密钥加密
                model.password = DESEncrypt.Encrypt(txtPassword.Text.Trim(), model.salt);
            }
            model.name = txtRealName.Text.Trim();
            model.town = ddlTown.SelectedValue.ToString();
            model.village = ddlVillage.SelectedValue.ToString();
            model.person = txtPerson.Text.Trim();
            model.tel = txtTel.Text.Trim();
            model.address = txtAddress.Text.Trim();

            if (bll.Update(model))
            {
                AddAdminLog(DTEnums.ActionEnum.Edit.ToString(), "修改账号:" + model.no); //记录日志
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
                ChkAdminLevel("xiehui", DTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改账号信息成功！", "xiehui_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("xiehui", DTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加账号信息成功！", "xiehui_list.aspx");
            }
        }

        //保存
        public void town_Change_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < 10; i++)
            {
                if (ddlVillage.SelectedValue.ToString() != "0")
                {
                    ddlVillage.Items.Clear();
                    ddlVillage.Items.Add(new ListItem("请选择所属村", "0"));
                    BLL.village subjectBll = new BLL.village();
                    DataTable dtVillage = subjectBll.GetList(Utils.StrToInt(ddlTown.SelectedValue, 0));
                    foreach (DataRow dr in dtVillage.Rows)
                    {
                        string Id = dr["id"].ToString();
                        string Title = dr["name"].ToString().Trim();
                        ddlVillage.Items.Add(new ListItem(Title, Id));
                    }
                }
            }
        }
    }
}