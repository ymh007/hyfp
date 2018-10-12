using System;
namespace DTcms.Model
{
    /// <summary>
    /// 家庭关系
    /// </summary>
    [Serializable]
    public partial class member_exit_family
    {
        public member_exit_family()
        { }
        #region Model
        private int _id;
        private int _member_id = 0;
        private string _name = "";
        private string _gender = "";
        private string _relationship = "";
        private string _education = "";
        private string _birthday;
        /// <summary>
        /// 自增ID
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
        /// 家庭关系
        /// </summary>
        public string relationship
        {
            set { _relationship = value; }
            get { return _relationship; }
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
        /// 出生年月
        /// </summary>
        public string birthday
        {
            set { _birthday = value; }
            get { return _birthday; }
        }
        #endregion Model

    }
}