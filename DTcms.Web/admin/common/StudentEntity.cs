using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Web.admin.article
{
    /// <summary>
    /// 用户实体类
    /// </summary>
	public class StudentEntity
	{
        /// <summary>
        /// .Ctor
        /// </summary>
        public StudentEntity()
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

        private string school;

        /// <summary>
        /// 毕业院校
        /// </summary>
        public string School
        {
            get { return school; }
            set { school = value; }
        }

        private string score;

        /// <summary>
        /// 笔试成绩
        /// </summary>
        public string Score
        {
            get { return score; }
            set { score = value; }
        }

        private string reScore;

        /// <summary>
        /// 复试成绩
        /// </summary>
        public string ReScore
        {
            get { return reScore; }
            set { reScore = value; }
        }

        private string isAca;

        /// <summary>
        /// 是否为学术
        /// </summary>
        public string IsAca
        {
            get { return isAca; }
            set { isAca = value; }
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
