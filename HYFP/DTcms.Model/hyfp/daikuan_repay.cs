using System;
using System.Collections.Generic;
namespace DTcms.Model
{
    /// <summary>
    /// 还款管理
    /// </summary>
    [Serializable]
    public partial class daikuan_repay
    {
        public daikuan_repay()
        { }
        #region Model
        private int _id;
        private int _daikuan_id = 0;
        private decimal? _amount;
        private decimal? _wh_amount;
        private decimal? _zy_amount;
        private decimal? _cq_amount;
        private DateTime _add_time = DateTime.Now;
        /// <summary>
        /// 自增ID
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 文章ID
        /// </summary>
        public int daikuan_id
        {
            set { _daikuan_id = value; }
            get { return _daikuan_id; }
        }
        /// <summary>
        /// 已还金额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
        }
        /// <summary>
        /// 上传时间
        /// </summary>
        public DateTime add_time
        {
            set { _add_time = value; }
            get { return _add_time; }
        }
        #endregion Model

        /// <summary>
        /// 图片相册
        /// </summary>
        private List<daikuan_repay_albums> _albums;
        public List<daikuan_repay_albums> albums
        {
            set { _albums = value; }
            get { return _albums; }
        }
    }
}