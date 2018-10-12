using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Web.admin.article
{
    /// <summary>
    /// 会员
    /// </summary>
	public class MemberEntity
	{
        /// <summary>
        /// .Ctor
        /// </summary>
        public MemberEntity()
        {
           
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

        private string name;

        /// <summary>
        /// 名称
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string gender;

        /// <summary>
        /// 性别
        /// </summary>
        public string Gender
        {
            get { return gender; }
            set { gender = value; }
        }

        private string type;

        /// <summary>
        /// 类型
        /// </summary>
        public string Type
        {
            get { return type; }
            set { type = value; }
        }

        private string id_card;

        /// <summary>
        /// 身份证
        /// </summary>
        public string Id_Card
        {
            get { return id_card; }
            set { id_card = value; }
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

        private string village;

        /// <summary>
        /// 所属村
        /// </summary>
        public string Village
        {
            get { return village; }
            set { village = value; }
        }

        private string town;

        /// <summary>
        /// 所属乡镇
        /// </summary>
        public string Town
        {
            get { return town; }
            set { town = value; }
        }

        private string amount;

        /// <summary>
        /// 缴纳会费金额
        /// </summary>
        public string Amount
        {
            get { return amount; }
            set { amount = value; }
        }

        private string remark;
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark
        {
            get { return remark; }
            set { remark = value; }
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
