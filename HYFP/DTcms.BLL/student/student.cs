using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    /// <summary>
    /// ��������
    /// </summary>
    public partial class student
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //���վ��������Ϣ
        private readonly DAL.student dal;

        public student()
        {
            dal = new DAL.student(siteConfig.sysdatabaseprefix);
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
        /// ��ȡ����
        /// </summary>
        public string GetNames(int id)
        {
            return dal.GetNames(id);
        }

        /// <summary>
        /// ���ݱ�Ų�ѯ�Ƿ����
        /// </summary>
        public bool Exists(string no)
        {
            return dal.Exists(no);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public int Add(Model.student model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public bool Update(Model.student model)
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
        /// ���ص�ʦѡ��
        /// </summary>
        public bool Cancel(int id)
        {
            bool result = dal.Cancel(id);
            return result;
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public Model.student GetModel(int id)
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