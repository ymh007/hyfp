using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// member:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class member
    {
        public member()
        { }
        #region Model
        private int _id;
        private string _no;
        private string _img_url;
        private string _name;
        private string _gender;
        private string _type;
        private string _level;
        private string _id_card;
        private string _tel;
        private string _village;
        private string _town;
        private decimal? _amount;
        private decimal? _can_amount;
        private DateTime? _date;
        private string _remark;
        private decimal? _yh_amount;
        private DateTime? _add_time;
        private decimal? _sum_amount;
        private decimal? _peigu;
        private int _is_delete = 0;
        private string _address;
        private string _birthday;
        private string _education;
        private string _shenqingbiao;
        private string _pingzheng;
        private string _shenfenzheng;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 会员证号码
        /// </summary>
        public string no
        {
            set { _no = value; }
            get { return _no; }
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
        /// 身份证正面图
        /// </summary>
        public string img_url
        {
            set { _img_url = value; }
            get { return _img_url; }
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
        /// 会员类别
        /// </summary>
        public string type
        {
            set { _type = value; }
            get { return _type; }
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
        /// 身份证号码
        /// </summary>
        public string id_card
        {
            set { _id_card = value; }
            get { return _id_card; }
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
        /// 所属村
        /// </summary>
        public string village
        {
            set { _village = value; }
            get { return _village; }
        }
        /// <summary>
        /// 所属乡镇
        /// </summary>
        public string town
        {
            set { _town = value; }
            get { return _town; }
        }
        /// <summary>
        /// 缴纳会费金额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
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
        /// 缴纳会费时间
        /// </summary>
        public DateTime? date
        {
            set { _date = value; }
            get { return _date; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string remark
        {
            set { _remark = value; }
            get { return _remark; }
        }
        /// <summary>
        /// 家庭住址
        /// </summary>
        public string address
        {
            set { _address = value; }
            get { return _address; }
        }
        /// <summary>
        /// 出生年月
        /// </summary>
        public string birthday
        {
            set { _birthday = value; }
            get { return _birthday; }
        }
        /// <summary>
        /// 文化程度
        /// </summary>
        public string education
        {
            set { _education = value; }
            get { return _education; }
        }
        /// <summary>
        /// 入会申请表
        /// </summary>
        public string shenqingbiao
        {
            set { _shenqingbiao = value; }
            get { return _shenqingbiao; }
        }
        /// <summary>
        /// 缴纳互助金凭证
        /// </summary>
        public string pingzheng
        {
            set { _pingzheng = value; }
            get { return _pingzheng; }
        }
        /// <summary>
        /// 身份证扫描件
        /// </summary>
        public string shenfenzheng
        {
            set { _shenfenzheng = value; }
            get { return _shenfenzheng; }
        }
        /// <summary>
        /// 优惠金额
        /// </summary>
        public decimal? yh_amount
        {
            set { _yh_amount = value; }
            get { return _yh_amount; }
        }
        /// <summary>
        /// 配股
        /// </summary>
        public decimal? peigu
        {
            set { _peigu = value; }
            get { return _peigu; }
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
        /// 是否删除
        /// </summary>
        public int is_delete
        {
            set { _is_delete = value; }
            get { return _is_delete; }
        }
        /// <summary>
        /// 业务审核文件
        /// </summary>
        private List<member_albums> _albums;
        public List<member_albums> albums
        {
            set { _albums = value; }
            get { return _albums; }
        }

        /// <summary>
        /// 财务凭证
        /// </summary>
        private List<member_cw_albums> _cw_albums;
        public List<member_cw_albums> cw_albums
        {
            set { _cw_albums = value; }
            get { return _cw_albums; }
        }

        /// <summary>
        /// 家庭成员 
        /// </summary>
        private List<member_family> _family;
        public List<member_family> family
        {
            set { _family = value; }
            get { return _family; }
        }
        #endregion Model

        /// <summary>
        /// 借款总额
        /// </summary>
        public decimal? sum_amount
        {
            set { _sum_amount = value; }
            get { return _sum_amount; }
        }

    }
}

