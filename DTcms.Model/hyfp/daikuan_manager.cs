using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// daikuan_manager:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class daikuan_manager
    {
        public daikuan_manager()
        { }
        #region Model
        private int _id;
        private string _name;
        private DateTime? _start_date;
        private decimal? _amount;
        private decimal? _wh_amount;
        private decimal? _zy_amount;
        private decimal? _cq_amount;
        private string _status;
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
        /// 借款人姓名
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 借款初始时间
        /// </summary>
        public DateTime? start_date
        {
            set { _start_date = value; }
            get { return _start_date; }
        }
        /// <summary>
        /// 已还款金额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
        }
        /// <summary>
        /// 未还款金额
        /// </summary>
        public decimal? wh_amount
        {
            set { _wh_amount = value; }
            get { return _wh_amount; }
        }
        /// <summary>
        /// 互助金占用费
        /// </summary>
        public decimal? zy_amount
        {
            set { _zy_amount = value; }
            get { return _zy_amount; }
        }
        /// <summary>
        /// 超期占用费
        /// </summary>
        public decimal? cq_amount
        {
            set { _cq_amount = value; }
            get { return _cq_amount; }
        }
        /// <summary>
        /// 状态
        /// </summary>
        public string status
        {
            set { _status = value; }
            get { return _status; }
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

