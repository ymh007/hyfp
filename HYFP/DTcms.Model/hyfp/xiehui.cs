using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// xiehui:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class xiehui
    {
        public xiehui()
        { }
        #region Model
        private int _id;
        private int _role_id;
        private int _role_type = 2;
        private string _name;
        private string _village;
        private string _town;
        private string _person;
        private string _tel;
        private string _address;
        private string _no;
        private string _password;
        private DateTime? _add_time;
        private string _salt;
        private int _is_lock = 0;
        private int? _sort_id = 99;
        private int? _parent_id;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 角色ID
        /// </summary>
        public int role_id
        {
            set { _role_id = value; }
            get { return _role_id; }
        }
        /// <summary>
        /// 管理员类型1超管2系管
        /// </summary>
        public int role_type
        {
            set { _role_type = value; }
            get { return _role_type; }
        }
        /// <summary>
        /// 协会名称
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 协会所属村
        /// </summary>
        public string village
        {
            set { _village = value; }
            get { return _village; }
        }
        /// <summary>
        /// 镇
        /// </summary>
        public string town
        {
            set { _town = value; }
            get { return _town; }
        }
        /// <summary>
        /// 协会负责人
        /// </summary>
        public string person
        {
            set { _person = value; }
            get { return _person; }
        }
        /// <summary>
        /// 负责人电话
        /// </summary>
        public string tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        /// <summary>
        /// 协会地址
        /// </summary>
        public string address
        {
            set { _address = value; }
            get { return _address; }
        }
        /// <summary>
        /// 协会账号
        /// </summary>
        public string no
        {
            set { _no = value; }
            get { return _no; }
        }
        /// <summary>
        /// 协会密码
        /// </summary>
        public string password
        {
            set { _password = value; }
            get { return _password; }
        }
        /// <summary>
        /// 6位随机字符串,加密用到
        /// </summary>
        public string salt
        {
            set { _salt = value; }
            get { return _salt; }
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
        /// 是否锁定
        /// </summary>
        public int is_lock
        {
            set { _is_lock = value; }
            get { return _is_lock; }
        }
        /// <summary>
        /// 父Id
        /// </summary>
        public int? parent_id
        {
            set { _parent_id = value; }
            get { return _parent_id; }
        }
        /// <summary>
        /// 排序Id
        /// </summary>
        public int? sort_id
        {
            set { _sort_id = value; }
            get { return _sort_id; }
        }
        #endregion Model

    }
}

