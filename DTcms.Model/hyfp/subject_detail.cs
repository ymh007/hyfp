using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// account:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class subject_detail
    {
        public subject_detail()
        { }
        #region Model
        private int _id;
        private int? _b_subject;
        private int? _s_subject;
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
        /// 科目大类
        /// </summary>
        public int? b_subject
        {
            set { _b_subject = value; }
            get { return _b_subject; }
        }
        /// <summary>
        /// 科目小类
        /// </summary>
        public int? s_subject
        {
            set { _s_subject = value; }
            get { return _s_subject; }
        }
        /// <summary>
        /// 贷
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
        }
        #endregion Model

    }
}

