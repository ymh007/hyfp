using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// daikuan_set:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class daikuan_set
    {
        public daikuan_set()
        { }
        #region Model
        private int _id;
        private int? _xiehui_id;
        private decimal? _rate;
        private decimal? _over_rate;
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
        /// 协会
        /// </summary>
        public int? xiehui_id
        {
            set { _xiehui_id = value; }
            get { return _xiehui_id; }
        }
        /// <summary>
        /// 借款利率
        /// </summary>
        public decimal? rate
        {
            set { _rate = value; }
            get { return _rate; }
        }
        /// <summary>
        /// 超期利率
        /// </summary>
        public decimal? over_rate
        {
            set { _over_rate = value; }
            get { return _over_rate; }
        }
        /// <summary>
        /// 借款限额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
        }
        #endregion Model

    }
}

