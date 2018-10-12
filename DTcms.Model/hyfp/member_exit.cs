using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// member:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class member_exit
    {
        public member_exit()
        { }
        #region Model
        private int _id;
        private string _no;
        private string _name;
        private string _gender;
        private string _id_card;
        private string _village;
        private string _town;
        private decimal? _amount;
        private DateTime? _add_time;
        private DateTime? _exit_time;
        private string _address;
        private string _birthday;
        private string _education;
        private int _status = 0;
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
        /// 性别
        /// </summary>
        public string gender
        {
            set { _gender = value; }
            get { return _gender; }
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
        /// 退会金额
        /// </summary>
        public decimal? amount
        {
            set { _amount = value; }
            get { return _amount; }
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
        /// 状态
        /// </summary>
        public int status
        {
            set { _status = value; }
            get { return _status; }
        }
        /// <summary>
        /// 申请时间
        /// </summary>
        public DateTime? add_time
        {
            set { _add_time = value; }
            get { return _add_time; }
        }

        /// <summary>
        /// 家庭成员 
        /// </summary>
        private List<member_exit_family> _family;
        public List<member_exit_family> family
        {
            set { _family = value; }
            get { return _family; }
        }
        #endregion Model
    }
}

