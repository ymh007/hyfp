using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// daikuan:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class daikuan
    {
        public daikuan()
        { }
        #region Model
        private int _id;
        private int _member_id;
        private string _name;
        private string _level;
        private string _gender;
        private string _tel;
        private string _id_card;
        private string _member_no;
        private decimal? _amount = 0;
        private decimal? _can_amount = 0;
        private decimal? _member_amount = 0;
        private string _purpose;
        private string _lb_person;
        private DateTime? _add_time;
        private DateTime? _audit_time;
        private string _lb_person_names;
        private int _status = 0;
        private int _hk_status = 0;
        private string _reason;
        private decimal? _yh_amount = 0;
        private decimal? _wh_amount = 0;
        private decimal? _zy_amount = 0;
        private decimal? _cq_amount = 0;
        private int _month = 0;
        private string _chanye;
        private string _remark;

        /// <summary>
        /// 驳回原因
        /// </summary>
        public string reason
        {
            set { _reason = value; }
            get { return _reason; }
        }
        /// <summary>
        /// 状态0未还清1已还清2已超期
        /// </summary>
        public int hk_status
        {
            set { _hk_status = value; }
            get { return _hk_status; }
        }
        /// <summary>
        /// 状态0正常1同意借款2驳回借款
        /// </summary>
        public int status
        {
            set { _status = value; }
            get { return _status; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 会员Id
        /// </summary>
        public int member_id
        {
            set { _member_id = value; }
            get { return _member_id; }
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
        /// 会员等级
        /// </summary>
        public string level
        {
            set { _level = value; }
            get { return _level; }
        }
        /// <summary>
        /// 性别
        /// </summary>
        public string gender
        {
            set { _gender = value; }
            get { return _gender; }
        }
        /// <summary>
        /// 电话
        /// </summary>
        public string tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        /// <summary>
        /// 身份证号码
        /// </summary>
        public string id_card
        {
            set { _id_card = value; }
            get { return _id_card; }
        }
        /// <summary>
        /// 会员证号码
        /// </summary>
        public string member_no
        {
            set { _member_no = value; }
            get { return _member_no; }
        }
        /// <summary>
        /// 可借款金额
        /// </summary>
        public decimal? can_amount
        {
            set { _can_amount = value; }
            get { return _can_amount; }
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
        /// 会费金额
        /// </summary>
        public decimal? member_amount
        {
            set { _member_amount = value; }
            get { return _member_amount; }
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
        /// 互助联保人
        /// </summary>
        public string lb_person
        {
            set { _lb_person = value; }
            get { return _lb_person; }
        }
        /// <summary>
        /// 互助联保人
        /// </summary>
        public string lb_person_names
        {
            set { _lb_person_names = value; }
            get { return _lb_person_names; }
        }
        /// <summary>
        /// 添加时间
        /// </summary>
        public DateTime? add_time
        {
            set { _add_time = value; }
            get { return _add_time; }
        }
        /// <summary>
        /// 审核时间
        /// </summary>
        public DateTime? audit_time
        {
            set { _audit_time = value; }
            get { return _audit_time; }
        }
        /// <summary>
        /// 已还金额
        /// </summary>
        public decimal? yh_amount
        {
            set { _yh_amount = value; }
            get { return _yh_amount; }
        }
        /// <summary>
        /// 未还金额
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
        /// 超期占用得
        /// </summary>
        public decimal? cq_amount
        {
            set { _cq_amount = value; }
            get { return _cq_amount; }
        }
        /// <summary>
        /// 借款时长
        /// </summary>
        public int month
        {
            set { _month = value; }
            get { return _month; }
        }
        /// <summary>
        /// 产业规模
        /// </summary>
        public string chanye
        {
            set { _chanye = value; }
            get { return _chanye; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string remark
        {
            set { _remark = value; }
            get { return _remark; }
        }
        #endregion Model

        /// <summary>
        /// 图片相册
        /// </summary>
        private List<daikuan_albums> _albums;
        public List<daikuan_albums> albums
        {
            set { _albums = value; }
            get { return _albums; }
        }

    }
}

