using System;
using System.Data;
using System.Text;
using System.Collections.Generic;
using System.Data.SqlClient;
using DTcms.DBUtility;
using DTcms.Common;

namespace DTcms.DAL
{
    /// <summary>
    /// 数据访问类:account
    /// </summary>
    public partial class account
    {
        public account()
        { }
        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "account");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from account");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.account model)
        {
            using (SqlConnection conn = new SqlConnection(DbHelperSQL.connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    try
                    {
                        #region 添加主表数据====================
                        StringBuilder strSql = new StringBuilder();
                        strSql.Append("insert into account(");
                        strSql.Append("xiehui_id,date,b_subject,s_subject,zhaiyao,jie,dai)");
                        strSql.Append(" values (");
                        strSql.Append("@xiehui_id,@date,@b_subject,@s_subject,@zhaiyao,@jie,@dai)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
					    new SqlParameter("@xiehui_id", SqlDbType.Int,4),
					    new SqlParameter("@date", SqlDbType.DateTime),
					    new SqlParameter("@b_subject", SqlDbType.Int,4),
					    new SqlParameter("@s_subject", SqlDbType.Int,4),
					    new SqlParameter("@zhaiyao", SqlDbType.NVarChar,200),
					    new SqlParameter("@jie", SqlDbType.Decimal,9),
					    new SqlParameter("@dai", SqlDbType.Decimal,9)};
                        parameters[0].Value = model.xiehui_id;
                        parameters[1].Value = model.date;
                        parameters[2].Value = model.b_subject;
                        parameters[3].Value = model.s_subject;
                        parameters[4].Value = model.zhaiyao;
                        parameters[5].Value = model.jie;
                        parameters[6].Value = model.dai;
                        //添加主表数据
                        object obj = DbHelperSQL.GetSingle(conn, trans, strSql.ToString(), parameters); //带事务
                        model.id = Convert.ToInt32(obj);
                        #endregion

                        #region 添加图片相册====================
                        if (model.albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.account_albums modelt in model.albums)
                            {
                                strSql3 = new StringBuilder();
                                strSql3.Append("insert into account_albums(");
                                strSql3.Append("account_id,thumb_path,original_path,remark,link_url)");
                                strSql3.Append(" values (");
                                strSql3.Append("@account_id,@thumb_path,@original_path,@remark,@link_url)");
                                SqlParameter[] parameters3 = {
					                new SqlParameter("@account_id", SqlDbType.Int,4),
					                new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                   new SqlParameter("@link_url", SqlDbType.NVarChar,200)};
                                parameters3[0].Value = model.id;
                                parameters3[1].Value = modelt.thumb_path;
                                parameters3[2].Value = modelt.original_path;
                                parameters3[3].Value = modelt.remark;
                                parameters3[4].Value = modelt.link_url;
                                DbHelperSQL.GetSingle(conn, trans, strSql3.ToString(), parameters3); //带事务
                            }
                        }
                        #endregion

                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        return 0;
                    }
                }
            }
            return model.id;
        }
        /// <summary>
        /// 更新一条数据
        /// </summary>
        public bool Update(Model.account model)
        {
            using (SqlConnection conn = new SqlConnection(DbHelperSQL.connectionString))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    try
                    {
                        #region 修改主表数据==========================
                        StringBuilder strSql = new StringBuilder();
                        strSql.Append("update account set ");
                        strSql.Append("xiehui_id=@xiehui_id,");
                        strSql.Append("date=@date,");
                        strSql.Append("b_subject=@b_subject,");
                        strSql.Append("s_subject=@s_subject,");
                        strSql.Append("zhaiyao=@zhaiyao,");
                        strSql.Append("jie=@jie,");
                        strSql.Append("dai=@dai");
                        strSql.Append(" where id=@id ");
                        SqlParameter[] parameters = {
					    new SqlParameter("@xiehui_id", SqlDbType.Int,4),
					    new SqlParameter("@date", SqlDbType.DateTime),
					    new SqlParameter("@b_subject", SqlDbType.Int,4),
					    new SqlParameter("@s_subject", SqlDbType.Int,4),
					    new SqlParameter("@zhaiyao", SqlDbType.NVarChar,200),
					    new SqlParameter("@jie", SqlDbType.Decimal,9),
					    new SqlParameter("@dai", SqlDbType.Decimal,9),
					    new SqlParameter("@id", SqlDbType.Int,4)};
                        parameters[0].Value = model.xiehui_id;
                        parameters[1].Value = model.date;
                        parameters[2].Value = model.b_subject;
                        parameters[3].Value = model.s_subject;
                        parameters[4].Value = model.zhaiyao;
                        parameters[5].Value = model.jie;
                        parameters[6].Value = model.dai;
                        parameters[7].Value = model.id;
                        DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
                        #endregion

                        #region 修改图片相册==========================
                        //删除已删除的图片
                        new account_albums().DeleteList(conn, trans, model.albums, model.id);
                        //添加/修改相册
                        if (model.albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.account_albums modelt in model.albums)
                            {
                                strSql3 = new StringBuilder();
                                if (modelt.id > 0)
                                {
                                    strSql3.Append("update account_albums set ");
                                    strSql3.Append("account_id=@account_id,");
                                    strSql3.Append("thumb_path=@thumb_path,");
                                    strSql3.Append("original_path=@original_path,");
                                    strSql3.Append("remark=@remark,");
                                    strSql3.Append("link_url=@link_url");
                                    strSql3.Append(" where id=@id");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@account_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200),
                                            new SqlParameter("@id", SqlDbType.Int,4)};
                                    parameters3[0].Value = modelt.account_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    parameters3[5].Value = modelt.id;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                                else
                                {
                                    strSql3.Append("insert into account_albums(");
                                    strSql3.Append("account_id,thumb_path,original_path,remark,link_url)");
                                    strSql3.Append(" values (");
                                    strSql3.Append("@account_id,@thumb_path,@original_path,@remark,@link_url)");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@account_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200)};
                                    parameters3[0].Value = modelt.account_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                            }
                        }
                        #endregion

                        trans.Commit();
                    }
                    catch
                    {
                        trans.Rollback();
                        return false;
                    }
                }
            }
            return true;
        }

        /// <summary>
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from account ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            int rows = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        /// <summary>
        /// 批量删除数据
        /// </summary>
        public bool DeleteList(string idlist)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from account ");
            strSql.Append(" where id in (" + idlist + ")  ");
            int rows = DbHelperSQL.ExecuteSql(strSql.ToString());
            if (rows > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Model.account GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 id,xiehui_id,date,b_subject,s_subject,zhaiyao,jie,dai from account ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            Model.account model = new Model.account();
            DataSet ds = DbHelperSQL.Query(strSql.ToString(), parameters);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return DataRowToModel(ds.Tables[0].Rows[0]);
            }
            else
            {
                return null;
            }
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Model.account DataRowToModel(DataRow row)
        {
            Model.account model = new Model.account();
            if (row != null)
            {
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["xiehui_id"] != null && row["xiehui_id"].ToString() != "")
                {
                    model.xiehui_id = int.Parse(row["xiehui_id"].ToString());
                }
                if (row["date"] != null && row["date"].ToString() != "")
                {
                    model.date = DateTime.Parse(row["date"].ToString());
                }
                if (row["b_subject"] != null && row["b_subject"].ToString() != "")
                {
                    model.b_subject = int.Parse(row["b_subject"].ToString());
                }
                if (row["s_subject"] != null && row["s_subject"].ToString() != "")
                {
                    model.s_subject = int.Parse(row["s_subject"].ToString());
                }
                if (row["zhaiyao"] != null)
                {
                    model.zhaiyao = row["zhaiyao"].ToString();
                }
                if (row["jie"] != null && row["jie"].ToString() != "")
                {
                    model.jie = decimal.Parse(row["jie"].ToString());
                }
                if (row["dai"] != null && row["dai"].ToString() != "")
                {
                    model.dai = decimal.Parse(row["dai"].ToString());
                }
            }
            //附件信息
            model.albums = new account_albums().GetList(model.id, 0);
            return model;
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,xiehui_id,date,b_subject,s_subject,zhaiyao,jie,dai ");
            strSql.Append(" FROM account ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得前几行数据
        /// </summary>
        public DataSet GetList(int Top, string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select ");
            if (Top > 0)
            {
                strSql.Append(" top " + Top.ToString());
            }
            strSql.Append(" id,xiehui_id,date,b_subject,s_subject,zhaiyao,jie,dai ");
            strSql.Append(" FROM account ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得查询分页数据
        /// </summary>
        public DataSet GetList(int pageSize, int pageIndex, string strWhere, string filedOrder, out int recordCount)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * FROM account");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            recordCount = Convert.ToInt32(DbHelperSQL.GetSingle(PagingHelper.CreateCountingSql(strSql.ToString())));
            return DbHelperSQL.Query(PagingHelper.CreatePagingSql(recordCount, pageSize, pageIndex, strSql.ToString(), filedOrder));
        }

        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetRecordCount(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) FROM account ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            object obj = DbHelperSQL.GetSingle(strSql.ToString());
            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetListByPage(string strWhere, string orderby, int startIndex, int endIndex)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT * FROM ( ");
            strSql.Append(" SELECT ROW_NUMBER() OVER (");
            if (!string.IsNullOrEmpty(orderby.Trim()))
            {
                strSql.Append("order by T." + orderby);
            }
            else
            {
                strSql.Append("order by T.id desc");
            }
            strSql.Append(")AS Row, T.*  from account T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                strSql.Append(" WHERE " + strWhere);
            }
            strSql.Append(" ) TT");
            strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 获得统计数据列表
        /// </summary>
        public DataSet GetStatisList(string date, int xiehui_id, int bSubject, int sSubject)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT b_subject,s_subject,xiehui_id,SUM(jie) jie,SUM(dai) dai ");
            strSql.Append(" FROM account ");
            strSql.Append(" WHERE date=' " + date + "'");
            if (bSubject != 0)
            {
                strSql.Append(" and  b_subject=" + bSubject);
            }
            if (sSubject != 0)
            {
                strSql.Append(" and s_subject=" + sSubject);
            }
            if (xiehui_id != 0)
            {
                strSql.Append(" and  xiehui_id=" + xiehui_id);
            }
            strSql.Append(" GROUP BY b_subject,s_subject,xiehui_id ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /*
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        public DataSet GetList(int PageSize,int PageIndex,string strWhere)
        {
            SqlParameter[] parameters = {
                    new SqlParameter("@tblName", SqlDbType.VarChar, 255),
                    new SqlParameter("@fldName", SqlDbType.VarChar, 255),
                    new SqlParameter("@PageSize", SqlDbType.Int),
                    new SqlParameter("@PageIndex", SqlDbType.Int),
                    new SqlParameter("@IsReCount", SqlDbType.Bit),
                    new SqlParameter("@OrderType", SqlDbType.Bit),
                    new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
                    };
            parameters[0].Value = "account";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        /// <summary>
        /// 查询记账明细
        /// </summary>
        public Model.account GetModel(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 * from account");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }

            Model.account model = new Model.account();
            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                return DataRowToModel(ds.Tables[0].Rows[0]);
            }
            else
            {
                return null;
            }
        }
        #endregion  BasicMethod

        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

