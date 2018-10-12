﻿using System;
namespace DTcms.Model
{
    /// <summary>
    /// 附件表
    /// </summary>
    [Serializable]
    public partial class member_albums
    {
        public member_albums()
        { }
        #region Model
        private int _id;
        private int _member_id = 0;
        private string _thumb_path = "";
        private string _original_path = "";
        private string _remark = "";
        private string _link_url = "";
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
        public int member_id
        {
            set { _member_id = value; }
            get { return _member_id; }
        }
        /// <summary>
        /// 缩略图地址
        /// </summary>
        public string thumb_path
        {
            set { _thumb_path = value; }
            get { return _thumb_path; }
        }
        /// <summary>
        /// 原图地址
        /// </summary>
        public string original_path
        {
            set { _original_path = value; }
            get { return _original_path; }
        }
        /// <summary>
        /// 图片描述
        /// </summary>
        public string remark
        {
            set { _remark = value; }
            get { return _remark; }
        }
        /// <summary>
        /// 连接地址
        /// </summary>
        public string link_url
        {
            set { _link_url = value; }
            get { return _link_url; }
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

    }
}