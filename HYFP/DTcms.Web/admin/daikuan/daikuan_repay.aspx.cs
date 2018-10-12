using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DTcms.Common;
using System.Web.UI.HtmlControls;
using System.Text;

namespace DTcms.Web.admin.daikuan
{
    public partial class daikuan_repay : Web.UI.ManagePage
    {
        protected string action = DTEnums.ActionEnum.Add.ToString(); //操作类型
        protected int id = 0;
        protected string keywords = string.Empty;
        protected string choose_id = string.Empty;
        protected string type = string.Empty;
        protected string lb_ids = string.Empty;

        protected void Page_Init(object sernder, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.id = Utils.StrToInt(DTRequest.GetQueryString("id"), 0);
            BLL.daikuan bll = new BLL.daikuan();
            var model = bll.GetModel(id);
            txtDkAmount.Text = model.amount.ToString();
            txtYhAmount.Text = model.yh_amount.ToString();
            txtWhAmount.Text = model.wh_amount.ToString();
        }

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            BLL.daikuan bll = new BLL.daikuan();
            BLL.daikuan_repay repayBll = new BLL.daikuan_repay();
            var model = bll.GetModel(id);

            var repayModel = new Model.daikuan_repay();
            repayModel.daikuan_id = id;
            repayModel.amount = Utils.StrToDecimal(txtAmount.Text.Trim(), 0);
            repayModel.add_time = DateTime.Now;

            model.yh_amount += repayModel.amount;
            model.wh_amount = model.amount + model.zy_amount - model.yh_amount;
            if (repayModel.amount == 0)
            {
                JscriptMsg("请填写正确金额！", "daikuan_repay.aspx?id=" + this.id);
                return;
            }
            if (model.yh_amount > model.amount + model.zy_amount)
            {
                JscriptMsg("已还金额超出借款金额！", "daikuan_repay.aspx?id=" + this.id);
                return;
            }
            if (model.wh_amount > 0)
            {
                model.hk_status = 0;
            }
            if (model.wh_amount == 0)
            {
                model.hk_status = 1;
            }

            #region 保存相册====================
            string[] albumArr = Request.Form.GetValues("hid_photo_name");
            string[] remarkArr = Request.Form.GetValues("hid_photo_remark");
            string[] link_urlArr = Request.Form.GetValues("hid_photo_link_url");
            if (albumArr != null && albumArr.Length > 0)
            {
                List<Model.daikuan_repay_albums> ls = new List<Model.daikuan_repay_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    if (imgArr.Length == 3)
                    {
                        if (!string.IsNullOrEmpty(link_urlArr[i]))
                        {
                            ls.Add(new Model.daikuan_repay_albums { original_path = imgArr[1], thumb_path = imgArr[2], link_url = link_urlArr[i] });
                        }
                        if (!string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.daikuan_repay_albums { original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.daikuan_repay_albums { original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                repayModel.albums = ls;
            }
            #endregion

            repayBll.Add(repayModel);
            if (bll.Update(model))
            {
                JscriptMsg("还款成功！", "daikuan_manager_list.aspx");
            }
        }
    }
}