using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// daikuan_audit:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class daikuan_audit
    {
        public daikuan_audit()
        { }
        #region Model
        private int _id;
        private string _name;
        private string _member_no;
        private decimal? _amount;
        private string _purpose;
        private string _tel;
        private string _village;
        private int? _status;
        private string _reason;
        private DateTime? _add_time;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 姓名
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 会员号
        /// </summary>
        public string member_no
        {
            set { _member_no = value; }
            get { return _member_no; }
        }
        /// <summary>
        /// 借款金额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
        }
        /// <summary>
        /// 借款用途
        /// </summary>
        public string purpose
        {
            set { _purpose = value; }
            get { return _purpose; }
        }
        /// <summary>
        /// 联系方式
        /// </summary>
        public string tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        /// <summary>
        /// 所属村镇
        /// </summary>
        public string village
        {
            set { _village = value; }
            get { return _village; }
        }
        /// <summary>
        /// 状态
        /// </summary>
        public int? status
        {
            set { _status = value; }
            get { return _status; }
        }
        /// <summary>
        /// 驳回理由
        /// </summary>
        public string reason
        {
            set { _reason = value; }
            get { return _reason; }
        }
        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime? add_time
        {
            set { _add_time = value; }
            get { return _add_time; }
        }
        #endregion Model

    }
}

