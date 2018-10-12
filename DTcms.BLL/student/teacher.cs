using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    /// <summary>
    /// ��ʦ����
    /// </summary>
    public partial class teacher
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //���վ��������Ϣ
        private readonly DAL.teacher dal;

        public teacher()
        {
            dal = new DAL.teacher(siteConfig.sysdatabaseprefix);
        }

        #region ��������================================
        /// <summary>
        /// �Ƿ���ڸü�¼
        /// </summary>
        public bool Exists(int id)
        {
            return dal.Exists(id);
        }

        /// <summary>
        /// ���ݱ�Ų�ѯ�Ƿ����
        /// </summary>
        public bool Exists(string no)
        {
            return dal.Exists(no);
        }

        /// <summary>
        /// ���ص�ʦ����
        /// </summary>
        public string GetName(int id)
        {
            return dal.GetName(id);
        }

        /// <summary>
        /// ����רҵ�͵�ʦ���
        /// </summary>
        public string GetQuota(int id)
        {
            return dal.GetResQuota(id);
        }

        /// <summary>
        /// ����ѧ���͵�ʦ���
        /// </summary>
        public string GetProResQuota(int id)
        {
            return dal.GetProResQuota(id);
        }

        /// <summary>
        /// ��ȡ�ѱ�ѡ��ѧ��Id�б�
        /// </summary>
        public DataSet GetStudents()
        {
            return dal.GetStudents();
        }

        // <summary>
        /// ��ȡ�õ�ʦѡ��ѧ��Ids
        /// </summary>
        public string GetStudentIds(int id)
        {
            return dal.GetStudentIds(id);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public int Add(Model.teacher model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public bool Update(Model.teacher model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// ɾ��һ������
        /// </summary>
        public bool Delete(int id)
        {
            bool result = dal.Delete(id);
            return result;
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public Model.teacher GetModel(int id)
        {
            return dal.GetModel(id);
        }

        /// <summary>
        /// ���ǰ��������
        /// </summary>
        public DataTable GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder).Tables[0];
        }

        /// <summary>
        /// ��ò�ѯ��ҳ����
        /// </summary>
        public DataSet GetList(int pageSize, int pageIndex, string strWhere, string filedOrder, out int recordCount)
        {
            return dal.GetList(pageSize, pageIndex, strWhere, filedOrder, out recordCount);
        }

        #endregion
    }
}