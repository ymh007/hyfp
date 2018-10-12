using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// subject:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class subject
    {
        public subject()
        { }
        #region Model
        private int _id;
        private int? _sort_id = 99;
        private int? _parent_id;
        private string _name;
        private string _type;
        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 父科目
        /// </summary>
        public int? parent_id
        {
            set { _parent_id = value; }
            get { return _parent_id; }
        }
        /// <summary>
        /// 名称
        /// </summary>
        public string name
        {
            set { _name = value; }
            get { return _name; }
        }
        /// <summary>
        /// 类别
        /// </summary>
        public string type
        {
            set { _type = value; }
            get { return _type; }
        }
        /// <summary>
        /// 名称
        /// </summary>
        public int? sort_id
        {
            set { _sort_id = value; }
            get { return _sort_id; }
        }
        #endregion Model

    }
}

