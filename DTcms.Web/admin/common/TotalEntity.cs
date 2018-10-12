using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Web.admin.article
{
    /// <summary>
    /// 汇总数据
    /// </summary>
    public class TotalEntity
    {
        /// <summary>
        /// .Ctor
        /// </summary>
        public TotalEntity()
        {

        }


        //发生多少笔贷款，有多少户，新增会员多少，退会多少

        private int daikuanCount;

        /// <summary>
        /// 带框数量
        /// </summary>
        public int DaikuanCount
        {
            get { return daikuanCount; }
            set { daikuanCount = value; }
        }

        private int memberCount;

        /// <summary>
        /// 多少户
        /// </summary>
        public int MemberCount
        {
            get { return memberCount; }
            set { memberCount = value; }
        }

        private int newMemCount;

        /// <summary>
        /// 新增会员数量
        /// </summary>
        public int NewMemCount
        {
            get { return newMemCount; }
            set { newMemCount = value; }
        }

        private int exitCount;

        /// <summary>
        /// 退会数量
        /// </summary>
        public int ExitCount
        {
            get { return exitCount; }
            set { exitCount = value; }
        }
    }
}
