using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// 导师主实体类
    /// </summary>
    [Serializable]
    public partial class teacher
    {
        public teacher()
        { }
        #region Model
        private int _id;
        private string _no;
        private string _name;
        private string _quota;
        private string _resquota;
        private string _email;
        private string _direction;
        private string _major;
        private string _students;
        private string _is_aca;
        private string _is_pro;
        private string _pro_quota;
        private string _pro_resquota;
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
        /// 研究生编号
        /// </summary>
        public string no
        {
            set { _no = value; }
            get { return _no; }
        }
        /// <summary>
        /// 研究生姓名
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 学硕分配指标
        /// </summary>
        public string quota
        {
            set { _quota = value; }
            get { return _quota; }
        }
        /// <summary>
        /// 剩余学硕分配指标
        /// </summary>
        public string resquota
        {
            set { _resquota = value; }
            get { return _resquota; }
        }
        /// <summary>
        /// 邮箱
        /// </summary>
        public string email
        {
            set { _email = value; }
            get { return _email; }
        }
        /// <summary>
        /// 研究方向
        /// </summary>
        public string direction
        {
            set { _direction = value; }
            get { return _direction; }
        }
        /// <summary>
        /// 专业
        /// </summary>
        public string major
        {
            set { _major = value; }
            get { return _major; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime add_time
        {
            set { _add_time = value; }
            get { return _add_time; }
        }
        /// <summary>
        /// 选择学生
        /// </summary>
        public string students
        {
            get { return _students; }
            set { _students = value; }
        }
        /// <summary>
        /// 学术型导师
        /// </summary>
        public string is_aca
        {
            get { return _is_aca; }
            set { _is_aca = value; }
        }
        /// <summary>
        /// 专业型导师
        /// </summary>
        public string is_pro
        {
            get { return _is_pro; }
            set { _is_pro = value; }
        }
        /// <summary>
        /// 专硕分配指标
        /// </summary>
        public string pro_quota
        {
            get { return _pro_quota; }
            set { _pro_quota = value; }
        }
        /// <summary>
        /// 剩余专硕分配指标
        /// </summary>
        public string pro_resquota
        {
            get { return _pro_resquota; }
            set { _pro_resquota = value; }
        }
        #endregion Model

    }
}