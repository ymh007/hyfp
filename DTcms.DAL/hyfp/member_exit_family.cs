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
    /// 图片相册
    /// </summary>
    public partial class member_exit_family
    {

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public List<Model.member_exit_family> GetList(int account_id, int Top)
        {
            List<Model.member_exit_family> modelList = new List<Model.member_exit_family>();

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,member_id,name,gender,relationship,birthday,education ");
            strSql.Append(" FROM member_exit_family ");
            strSql.Append(" where member_id=" + account_id);
            DataTable dt = DbHelperSQL.Query(strSql.ToString()).Tables[0];

            int rowsCount = dt.Rows.Count;
            if (rowsCount > 0)
            {
                Model.member_exit_family model;
                for (int n = 0; n < rowsCount; n++)
                {
                    model = new Model.member_exit_family();
                    if (dt.Rows[n]["id"] != null && dt.Rows[n]["id"].ToString() != "")
                    {
                        model.id = int.Parse(dt.Rows[n]["id"].ToString());
                    }
                    if (dt.Rows[n]["member_id"] != null && dt.Rows[n]["member_id"].ToString() != "")
                    {
                        model.member_id = int.Parse(dt.Rows[n]["member_id"].ToString());
                    }
                    if (dt.Rows[n]["name"] != null && dt.Rows[n]["name"].ToString() != "")
                    {
                        model.name = dt.Rows[n]["name"].ToString();
                    }
                    if (dt.Rows[n]["gender"] != null && dt.Rows[n]["gender"].ToString() != "")
                    {
                        model.gender = dt.Rows[n]["gender"].ToString();
                    }
                    if (dt.Rows[n]["relationship"] != null && dt.Rows[n]["relationship"].ToString() != "")
                    {
                        model.relationship = dt.Rows[n]["relationship"].ToString();
                    }
                    if (dt.Rows[n]["birthday"] != null && dt.Rows[n]["birthday"].ToString() != "")
                    {
                        model.birthday = dt.Rows[n]["birthday"].ToString();
                    }
                    if (dt.Rows[0]["education"].ToString() != "")
                    {
                        model.education = dt.Rows[n]["education"].ToString();
                    }
                    modelList.Add(model);
                }
            }
            return modelList;
        }

        /// <summary>
        /// 查找不存在的图片并删除已删除的图片及数据
        /// </summary>
        public void DeleteList(SqlConnection conn, SqlTransaction trans, List<Model.member_exit_family> models, int account_id)
        {
            StringBuilder idList = new StringBuilder();
            if (models != null)
            {
                foreach (Model.member_exit_family modelt in models)
                {
                    if (modelt.id > 0)
                    {
                        idList.Append(modelt.id + ",");
                    }
                }
            }
            string id_list = Utils.DelLastChar(idList.ToString(), ",");
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,member_id,name,gender,relationship,birthday,education  from member_exit_family where member_id=" + account_id);
            if (!string.IsNullOrEmpty(id_list))
            {
                strSql.Append(" and id not in(" + id_list + ")");
            }
            DataSet ds = DbHelperSQL.Query(conn, trans, strSql.ToString());
        }

    }
}

