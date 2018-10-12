using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    /// <summary>
    /// ϵͳ�����˵�
    /// </summary>
    public partial class subject
    {
        private readonly Model.siteconfig siteConfig = new BLL.siteconfig().loadConfig(); //���վ��������Ϣ
        private readonly DAL.subject dal;
        public subject()
        {
            dal = new DAL.subject(siteConfig.sysdatabaseprefix);
        }

        #region ��������===============================
        /// <summary>
        /// �Ƿ���ڸü�¼
        /// </summary>
        public bool Exists(int id)
        {
            return dal.Exists(id);
        }

        /// <summary>
        /// ��ѯ�����Ƿ����
        /// </summary>
        public bool Exists(string name)
        {
            return dal.Exists(name);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public int Add(Model.subject model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public bool Update(Model.subject model)
        {
            return dal.Update(model);
        }

        /// <summary>
        /// ɾ��һ������
        /// </summary>
        public bool Delete(int id)
        {
            return dal.Delete(id);
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public Model.subject GetModel(int id)
        {
            return dal.GetModel(id);
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public Model.subject GetModel(string name)
        {
            return dal.GetModel(name);
        }

        /// <summary>
        /// ȡ����������б�
        /// </summary>
        /// <param name="parent_id">��ID</param>
        /// <param name="nav_type">�������</param>
        /// <returns>DataTable</returns>
        public DataTable GetList(int parent_id)
        {
            return dal.GetList(parent_id);
        }
        /// <summary>
        /// ��ȡ����б�
        /// </summary>
        /// <param name="parent_id">��ID</param>
        /// <param name="nav_type">�������</param>
        /// <returns>DataTable</returns>
        public DataTable GetParentList(int parent_id)
        {
            return dal.GetParentList(parent_id);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            return dal.GetList(strWhere);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public DataSet GetList(string strWhere, string filedOrder)
        {
            return dal.GetList(strWhere, filedOrder);
        }
        #endregion

        #region ��չ����===============================
        /// <summary>
        /// ���ݵ��������Ʋ�ѯ��ID
        /// </summary>
        /// <param name="nav_name">�˵�����</param>
        /// <returns>int</returns>
        public int GetNavId(string nav_name)
        {
            return dal.GetNavId(nav_name);
        }


        /// <summary>
        /// �޸�һ������
        /// </summary>
        public bool UpdateField(int id, string strValue)
        {
            return dal.UpdateField(id, strValue);
        }

        /// <summary>
        /// �޸�һ������
        /// </summary>
        public bool UpdateField(string name, string strValue)
        {
            return dal.UpdateField(name, strValue);
        }
        /// <summary>
        /// ���ؿ�Ŀ����
        /// </summary>
        public string GetName(int id)
        {
            return dal.GetName(id);
        }
        #endregion
    }
}

