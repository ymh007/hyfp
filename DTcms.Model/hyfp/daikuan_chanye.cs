using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// daikuan_set:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class daikuan_chanye
    {
        public daikuan_chanye()
        { }
        #region Model
        private int _id;
        private string _name;
        private DateTime? _add_time;
        private decimal? _amount;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 等级名称
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 借款限额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
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

