using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// account:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class account
    {
        public account()
        { }
        #region Model
        private int _id;
        private int? _xiehui_id;
        private DateTime? _date;
        private int? _b_subject;
        private int? _s_subject;
        private string _zhaiyao;
        private decimal? _jie;
        private decimal? _dai;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 协会名称
        /// </summary>
        public int? xiehui_id
        {
            set { _xiehui_id = value; }
            get { return _xiehui_id; }
        }
        /// <summary>
        /// 日期
        /// </summary>
        public DateTime? date
        {
            set { _date = value; }
            get { return _date; }
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
        /// 摘要
        /// </summary>
        public string zhaiyao
        {
            set { _zhaiyao = value; }
            get { return _zhaiyao; }
        }
        /// <summary>
        /// 借
        /// </summary>
        public decimal? jie
        {
            set { _jie = value; }
            get { return _jie; }
        }
        /// <summary>
        /// 贷
        /// </summary>
        public decimal? dai
        {
            set { _dai = value; }
            get { return _dai; }
        }
        #endregion Model

        /// <summary>
        /// 图片相册
        /// </summary>
        private List<account_albums> _albums;
        public List<account_albums> albums
        {
            set { _albums = value; }
            get { return _albums; }
        }

    }
}

