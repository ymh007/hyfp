using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Web.admin.article
{
    /// <summary>
    /// 用户实体类
    /// </summary>
    public class TeacherEntity
    {
        /// <summary>
        /// .Ctor
        /// </summary>
        public TeacherEntity()
        {

        }

        private string no;

        /// <summary>
        /// 编号
        /// </summary>
        public string No
        {
            get { return no; }
            set { no = value; }
        }

        private string name;

        /// <summary>
        /// 姓名
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string quota;

        /// <summary>
        /// 分配指标
        /// </summary>
        public string Quota
        {
            get { return quota; }
            set { quota = value; }
        }

        private string email;

        /// <summary>
        /// 邮箱
        /// </summary>
        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        private string direction;

        /// <summary>
        /// 研究方向
        /// </summary>
        public string Direction
        {
            get { return direction; }
            set { direction = value; }
        }

        private string major;

        /// <summary>
        /// 专业
        /// </summary>
        public string Major
        {
            get { return major; }
            set { major = value; }
        }

        private string password;

        /// <summary>
        /// 密码
        /// </summary>
        public string Password
        {
            get { return password; }
            set { password = value; }
        }

        private string students;
        /// <summary>
        /// 选择学生
        /// </summary>
        public string Students
        {
            get { return students; }
            set { students = value; }
        }

        private string isAca;

        /// <summary>
        /// 是否为学术型导师
        /// </summary>
        public string IsAca
        {
            get { return isAca; }
            set { isAca = value; }
        }

        private string isPro;

        /// <summary>
        /// 是否为专业性导师
        /// </summary>
        public string IsPro
        {
            get { return isPro; }
            set { isPro = value; }
        }

        private string proQuota;

        /// <summary>
        /// 专硕分配指标
        /// </summary>
        public string ProQuota
        {
            get { return proQuota; }
            set { proQuota = value; }
        }

        private bool _isExcelVaildateOK = true;

        /// <summary>
        /// Excel验证是否通过，默认为true
        /// <para>true：通过；false：不通过</para>
        /// </summary>
        public bool IsExcelVaildateOK
        {
            get { return _isExcelVaildateOK; }
            set { _isExcelVaildateOK = value; }
        }
    }
}
