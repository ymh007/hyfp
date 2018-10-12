using System;
using System.Data;
using System.Collections.Generic;
using DTcms.Common;

namespace DTcms.BLL
{
    /// <summary>
    /// subject_detail
    /// </summary>
    public partial class subject_detail
    {
        private readonly DAL.subject_detail dal = new DAL.subject_detail();
        public subject_detail()
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
        /// ����һ������
        /// </summary>
        public int Add(Model.subject_detail model)
        {
            return dal.Add(model);
        }

        /// <summary>
        /// ����һ������
        /// </summary>
        public bool Update(Model.subject_detail model)
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
        /// ɾ��һ������
        /// </summary>
        public bool DeleteList(string idlist)
        {
            return dal.DeleteList(idlist);
        }

        /// <summary>
        /// �õ�һ������ʵ��
        /// </summary>
        public Model.subject_detail GetModel(int id)
        {

            return dal.GetModel(id);
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
        public List<Model.subject_detail> GetModelList(string strWhere)
        {
            DataSet ds = dal.GetList(strWhere);
            return DataTableToList(ds.Tables[0]);
        }
        /// <summary>
        /// ��������б�
        /// </summary>
        public List<Model.subject_detail> DataTableToList(DataTable dt)
        {
            List<Model.subject_detail> modelList = new List<Model.subject_detail>();
            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Model.subject_detail model;
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
        /// ���ݴ���Ŀ��С��Ŀ��ȡ��Ϣ
        /// </summary>
        public Model.subject_detail GetModel(int bSbuject, int sSubject)
        {
            return dal.GetModel(bSbuject, sSubject);
        }
        /// <summary>
        /// ��ҳ��ȡ�����б�
        /// </summary>
        //public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        //{
        //return dal.GetList(PageSize,PageIndex,strWhere);
        //}
        /// <summary>
        /// ��ѯ������ϸ
        /// </summary>
        public Model.subject_detail GetModel(string strWhere)
        {
            return dal.GetModel(strWhere);
        }
        #endregion  BasicMethod
        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

