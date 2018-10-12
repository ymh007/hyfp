using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using DTcms.DBUtility;
using DTcms.Common;

namespace DTcms.DAL
{
    /// <summary>
    /// ͼƬ���
    /// </summary>
    public partial class daikuan_repay_albums
    {

        /// <summary>
        /// ��������б�
        /// </summary>
        public List<Model.daikuan_repay_albums> GetList(int daikuan_id, int Top)
        {
            List<Model.daikuan_repay_albums> modelList = new List<Model.daikuan_repay_albums>();

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,daikuan_id,thumb_path,original_path,remark,add_time,link_url ");
            strSql.Append(" FROM daikuan_repay_albums ");
            strSql.Append(" where daikuan_id=" + daikuan_id);
            strSql.Append(" order by add_time desc");
            DataTable dt = DbHelperSQL.Query(strSql.ToString()).Tables[0];

            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Model.daikuan_repay_albums model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Model.daikuan_repay_albums();
                    if (dt.Rows[n]["id"] != null && dt.Rows[n]["id"].ToString() != "")
                    {
                        model.id = int.Parse(dt.Rows[n]["id"].ToString());
                    }
                    if (dt.Rows[n]["daikuan_id"] != null && dt.Rows[n]["daikuan_id"].ToString() != "")
                    {
                        model.daikuan_id = int.Parse(dt.Rows[n]["daikuan_id"].ToString());
                    }
                    if (dt.Rows[n]["thumb_path"] != null && dt.Rows[n]["thumb_path"].ToString() != "")
                    {
                        model.thumb_path = dt.Rows[n]["thumb_path"].ToString();
                    }
                    if (dt.Rows[n]["original_path"] != null && dt.Rows[n]["original_path"].ToString() != "")
                    {
                        model.original_path = dt.Rows[n]["original_path"].ToString();
                    }
                    if (dt.Rows[n]["remark"] != null && dt.Rows[n]["remark"].ToString() != "")
                    {
                        model.remark = dt.Rows[n]["remark"].ToString();
                    }
                    if (dt.Rows[n]["link_url"] != null && dt.Rows[n]["link_url"].ToString() != "")
                    {
                        model.link_url = dt.Rows[n]["link_url"].ToString();
                    }
                    if (dt.Rows[0]["add_time"].ToString() != "")
                    {
                        model.add_time = DateTime.Parse(dt.Rows[0]["add_time"].ToString());
                    }
                    modelList.Add(model);
                }
            }
            return modelList;
        }

        /// <summary>
        /// ���Ҳ����ڵ�ͼƬ��ɾ����ɾ����ͼƬ������
        /// </summary>
        public void DeleteList(SqlConnection conn, SqlTransaction trans, List<Model.daikuan_repay_albums> models, int daikuan_id)
        {
            StringBuilder idList = new StringBuilder();
            if (models != null)
            {
                foreach (Model.daikuan_repay_albums modelt in models)
                {
                    if (modelt.id > 0)
                    {
                        idList.Append(modelt.id + ",");
                    }
                }
            }
            string id_list = Utils.DelLastChar(idList.ToString(), ",");
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,thumb_path,original_path from daikuan_repay_albums where daikuan_id=" + daikuan_id);
            if (!string.IsNullOrEmpty(id_list))
            {
                strSql.Append(" and id not in(" + id_list + ")");
            }
            DataSet ds = DbHelperSQL.Query(conn, trans, strSql.ToString());
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                int rows = DbHelperSQL.ExecuteSql(conn, trans, "delete from daikuan_repay_albums where id=" + dr["id"].ToString()); //ɾ�����ݿ�
                if (rows > 0)
                {
                    Utils.DeleteFile(dr["thumb_path"].ToString()); //ɾ������ͼ
                    Utils.DeleteFile(dr["original_path"].ToString()); //ɾ��ԭͼ
                }
            }
        }

        /// <summary>
        /// ɾ�����ͼƬ
        /// </summary>
        public void DeleteFile(List<Model.daikuan_repay_albums> models)
        {
            if (models != null)
            {
                foreach (Model.daikuan_repay_albums modelt in models)
                {
                    Utils.DeleteFile(modelt.thumb_path);
                    Utils.DeleteFile(modelt.original_path);
                }
            }
        }

    }
}

