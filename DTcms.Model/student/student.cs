using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// 学生主实体类
    /// </summary>
    [Serializable]
    public partial class student
    {
        public student()
        { }
        #region Model
        private int _id;
        private string _no;
        private string _name;
        private string _school;
        private string _score;
        private string _re_score;
        private int? _teacher_id;
        private string _status;
        private string _is_aca;
        private string _attach;
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
        /// 毕业院校
        /// </summary>
        public string school
        {
            set { _school = value; }
            get { return _school; }
        }
        /// <summary>
        /// 笔试成绩
        /// </summary>
        public string score
        {
            set { _score = value; }
            get { return _score; }
        }
        /// <summary>
        /// 复试成绩
        /// </summary>
        public string re_score
        {
            set { _re_score = value; }
            get { return _re_score; }
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
        /// 导师Id
        /// </summary>
        public int? teacher_id
        {
            set { _teacher_id = value; }
            get { return _teacher_id; }
        }
        /// <summary>
        /// 状态
        /// </summary>
        public string status
        {
            set { _status = value; }
            get { return _status; }
        }
        /// <summary>
        /// 是否为学术研究生
        /// </summary>
        public string is_aca
        {
            set { _is_aca = value; }
            get { return _is_aca; }
        }
        /// <summary>
        /// 简历
        /// </summary>
        public string attach
        {
            set { _attach = value; }
            get { return _attach; }
        }

        #endregion Model

    }
}