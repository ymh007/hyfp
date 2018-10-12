using System;
using System.Collections.Generic;

namespace DTcms.Model
{
    /// <summary>
    /// manager_level:实体类(属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class village
    {
        public village()
        { }
        #region Model
        private int _id;
        private int? _sort_id = 99;
        private int? _parent_id;
        private string _name;
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
        /// 排序
        /// </summary>
        public int? sort_id
        {
            set { _sort_id = value; }
            get { return _sort_id; }
        }
        #endregion Model

    }
}

