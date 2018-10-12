using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    /// <summary>
    /// 导师内容
    /// </summary>
    public partial class teacher
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //获得站点配置信息
        private readonly DAL.teacher dal;

        public teacher()
        {
            dal = new DAL.teacher(siteConfig.sysdatabaseprefix);
        }

        #region 基本方法================================
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            return dal.Exists(id);
        }

        /// <summary>
        /// 根据编号查询是否存在
        /// </summary>
        public bool Exists(string no)
        {
            return dal.Exists(no);
        }

        /// <summary>
        /// 返回导师姓名
        /// </summary>
        public string GetName(int id)
        {
            return dal.GetName(id);
        }

        /// <summary>
        /// 返回专业型导师配额
        /// </summary>
        public string GetQuota(int id)
        {
            return dal.GetResQuota(id);
        }

        /// <summary>
        /// 返回学术型导师配额
        /// </summary>
        public string GetProResQuota(int id)
        {
            return dal.GetProResQuota(id);
        }

        /// <summary>
        /// 获取已被选中学生Id列表
        /// </summary>
        public DataSet GetStudents()
        {
            return dal.GetStudents();
        }

        // <summary>
        /// 获取该导师选择学生Ids
        /// </summary>
        public string GetStudentIds(int id)
        {
            return dal.GetStudentIds(id);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.teacher model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Model.teacher model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {
            bool result = dal.Delete(id);
            return result;
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Model.teacher GetModel(int id)
        {
            return dal.GetModel(id);
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataTable GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder).Tables[0];
        }

        /// <summary>
        /// 获得查询分页数据
        /// </summary>
        public DataSet GetList(int pageSize, int pageIndex, string strWhere, string filedOrder, out int recordCount)
        {
            return dal.GetList(pageSize, pageIndex, strWhere, filedOrder, out recordCount);
        }

        #endregion
    }
}