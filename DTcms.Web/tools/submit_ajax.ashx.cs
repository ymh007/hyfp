using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web;
using System.Web.SessionState;
using DTcms.Web.UI;
using DTcms.Common;
using DTcms.Web.admin.article;

namespace DTcms.Web.tools
{
    /// <summary>
    /// submit_ajax 的摘要说明
    /// </summary>
    public class submit_ajax : IHttpHandler, IRequiresSessionState
    {
        Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig();
        Model.userconfig userConfig = new BLL.userconfig().loadConfig();

        public void ProcessRequest(HttpContext context)
        {
            //取得处事类型
            string action = DTRequest.GetQueryString("action");

            switch (action)
            {
                case "sign_article_click": //签收
                    sign_article_click(context);
                    break;
                case "send_message_click": //留言
                    send_message_click(context);
                    break;
                case "send_complaint_click": //投诉建议
                    send_complaint_click(context);
                    break;
            }
        }

        #region 签收文章
        private void sign_article_click(HttpContext context)
        {
            var username = DTRequest.GetString("username");
            var password = DTRequest.GetString("password");

            BLL.xiehui bll = new BLL.xiehui();
            Model.xiehui model = bll.GetModel(username, password, true);
            if (model == null)
            {
                context.Response.Write("{\"status\": 2, \"msg\": \"用户名或密码有误，请重试！\"}");
                return;
            }

            BLL.article bllArticle = new BLL.article();
            var id = DTRequest.GetInt("id", 0);
            var articleModel = bllArticle.GetModel(id);
            articleModel.status = 2;
            articleModel.sign_user_name += username + "|" + DateTime.Now.ToString() + ",";
            //判断当前用户是否已签收过
            var isUserSign = bllArticle.GetList(1, " id=" + id + " and sign_user_name like '%" + username + "|%'", "add_time desc").Tables[0].Rows.Count;
            if (isUserSign > 0)
            {
                context.Response.Write("{\"status\": 0, \"msg\": \"对不起，该用户已经签收！\"}");
                return;
            }
            if (bllArticle.Update(articleModel))
            {
                context.Response.Write("{\"status\": 1, \"msg\": \"恭喜您，签收成功！\"}");
                return;
            }
            context.Response.Write("{\"status\": 0, \"msg\": \"对不起，签收过程中发生错误！\"}");
        }
        #endregion

        #region 发送留言
        private void send_message_click(HttpContext context)
        {
            Model.article model = new Model.article();
            BLL.article bll = new BLL.article();

            //姓名
            var name = DTRequest.GetString("name");
            //电话
            var tel = DTRequest.GetString("tel");
            //部门
            var department = DTRequest.GetString("dept");
            //email
            var email = DTRequest.GetString("email");
            //留言内容
            var message = DTRequest.GetString("message");
            var entrance = DTRequest.GetString("entrance");
            model.channel_id = 10;
            model.category_id = 47;
            model.title = message;
            model.status = 1;

            model.fields = new Dictionary<string, string>();
            model.fields.Add("name", name);
            model.fields.Add("tel", tel);
            model.fields.Add("department", department);
            model.fields.Add("email", email);
            model.fields.Add("entrance", entrance);
            model.zhaiyao = message;
            model.content = message;

            if (bll.Add(model) > 0)
            {
                context.Response.Write("{\"status\": 1, \"msg\": \"恭喜您，留言成功！\"}");
                return;
            }
            context.Response.Write("{\"status\": 0, \"msg\": \"对不起，保存过程中发生错误！\"}");
        }
        #endregion

        #region 投诉建议
        private void send_complaint_click(HttpContext context)
        {
            Model.article model = new Model.article();
            BLL.article bll = new BLL.article();

            //姓名
            var name = DTRequest.GetString("name");
            //电话
            var tel = DTRequest.GetString("tel");
            //email
            var email = DTRequest.GetString("email");
            //投诉建议
            var message = DTRequest.GetString("message");

            model.channel_id = 10;
            model.category_id = 48;
            model.title = message;
            model.status = 0;

            model.fields = new Dictionary<string, string>();
            model.fields.Add("name", name);
            model.fields.Add("tel", tel);
            model.fields.Add("email", email);
            model.zhaiyao = message;
            model.content = message;

            if (bll.Add(model) > 0)
            {
                context.Response.Write("{\"status\": 1, \"msg\": \"恭喜您，投诉建议成功！\"}");
                return;
            }
            context.Response.Write("{\"status\": 0, \"msg\": \"对不起，保存过程中发生错误！\"}");
        }
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}