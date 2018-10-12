using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Web.admin.article
{
    /// <summary>
    /// 协会账号
    /// </summary>
	public class XieHuiEntity
	{
        /// <summary>
        /// .Ctor
        /// </summary>
        public XieHuiEntity()
        {
           
        }

        private string name;

        /// <summary>
        /// 名称
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string village;

        /// <summary>
        /// 所属乡
        /// </summary>
        public string Village
        {
            get { return village; }
            set { village = value; }
        }

        private string town;

        /// <summary>
        /// 所属镇
        /// </summary>
        public string Town
        {
            get { return town; }
            set { town = value; }
        }

        private string person;

        /// <summary>
        /// 协会负责人
        /// </summary>
        public string Person
        {
            get { return person; }
            set { person = value; }
        }

        private string tel;

        /// <summary>
        /// 电话
        /// </summary>
        public string Tel
        {
            get { return tel; }
            set { tel = value; }
        }

        private string address;

        /// <summary>
        /// 地址
        /// </summary>
        public string Address
        {
            get { return address; }
            set { address = value; }
        }

        private string no;

        /// <summary>
        /// 账号
        /// </summary>
        public string No
        {
            get { return no; }
            set { no = value; }
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
