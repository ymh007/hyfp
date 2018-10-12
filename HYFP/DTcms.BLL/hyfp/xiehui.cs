using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    /// <summary>
    /// xiehui
    /// </summary>
    public partial class xiehui
    {
        private readonly DAL.xiehui dal = new DAL.xiehui();
        public xiehui()
        { }
        #region  BasicMethod

        /// <summary>
        /// �õ����ID
        /// </summary>
        public int GetMaxId()
        {
            return dal.GetMaxId();
        }

        /// <summary>
        /// �Ƿ���ڸü�¼
        /// </summary>
        public bool Exists(int id)
        {
            return dal.Exists(id);
        }

        /// <summary>
        /// �Ƿ���ڸü�¼
        /// </summary>
        public bool Exists(string no)
        {
            return dal.Exists(no);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public int Add(Model.xiehui model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public bool Update(Model.xiehui model)
        {
            return dal.Update(model);
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
        /// ɾ��һ������
        /// </summary>
        public bool Delete(int id)
        {

            return dal.Delete(id);
        }
        /// <summary>
        /// ɾ��һ������
        /// </summary>
        public bool DeleteList(string idlist)
        {
            return dal.DeleteList(idlist);
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public Model.xiehui GetModel(int id)
        {

            return dal.GetModel(id);
        }

        /// <summary>
        /// �����û������뷵��һ��ʵ��
        /// </summary>
        public Model.xiehui GetModel(string user_name, string password)
        {
            return dal.GetModel(user_name, password);
        }

        /// <summary>
        /// �����û������뷵��һ��ʵ��
        /// </summary>
        public Model.xiehui GetModel(string user_name, string password, bool is_encrypt)
        {
            //���һ���Ƿ���Ҫ����
            if (is_encrypt)
            {
                //��ȡ�ø��û��������Կ
                string salt = dal.GetSalt(user_name);
                if (string.IsNullOrEmpty(salt))
                {
                    return null;
                }
                //�����Ľ��м������¸�ֵ
                password = DESEncrypt.Encrypt(password, salt);
            }
            return dal.GetModel(user_name, password);
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
        /// ���ǰ��������
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            return dal.GetList(Top, strWhere, filedOrder);
        }

        /// <summary>
        /// ��ò�ѯ��ҳ����
        /// </summary>
        public DataSet GetList(int pageSize, int pageIndex, string strWhere, string filedOrder, out int recordCount)
        {
            return dal.GetList(pageSize, pageIndex, strWhere, filedOrder, out recordCount);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public List<Model.xiehui> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public List<Model.xiehui> DataTableToList(DataTable dt)
        {
            List<Model.xiehui> modelList = new List<Model.xiehui>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Model.xiehui model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = dal.DataRowToModel(dt.Rows[n]);
                    if (model != null)
                    {
                        modelList.Add(model);
                    }
                }
            }
            return modelList;
        }

        /// <summary>
        /// ��������б�
        /// </summary>
        public DataSet GetAllList()
        {
            return GetList("");
        }

        /// <summary>
        /// ��ҳ��ȡ�����б�
        /// </summary>
        public int GetRecordCount(string strWhere)
        {
            return dal.GetRecordCount(strWhere);
        }
        /// <summary>
        /// ��ҳ��ȡ�����б�
        /// </summary>
        public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
        {
            return dal.GetListByPage(strWhere, orderby, startIndex, endIndex);
        }

        /// <summary>
        /// �����û���ȡ��RealName
        /// </summary>
        public string GetRealName(string no)
        {
            return dal.GetRealName(no);
        }
        /// <summary>
        /// ����Э������
        /// </summary>
        public string GetName(int id)
        {
            return dal.GetName(id);
        }
        /// <summary>
        /// ���ݴ����ѯЭ��
        /// </summary>
        public string GetId(string town, string village)
        {
            return dal.GetId(town, village);
        }
        #endregion  BasicMethod
        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

