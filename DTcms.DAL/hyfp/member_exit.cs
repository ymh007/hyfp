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
    /// 数据访问类:member_exit
    /// </summary>
    public partial class member_exit
    {
        public member_exit()
        { }
        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "member_exit");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from member_exit");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(string no)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from member_exit");
            strSql.Append(" where no=@no ");
            SqlParameter[] parameters = {
					new SqlParameter("@no", SqlDbType.NVarChar,50)			};
            parameters[0].Value = no;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.member_exit model)
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
                        strSql.Append("insert into member_exit(");
                        strSql.Append("no,town,village,address,name,gender,birthday,education,id_card,amount,add_time,status)");
                        strSql.Append(" values (");
                        strSql.Append("@no,@town,@village,@address,@name,@gender,@birthday,@education,@id_card,@amount,@add_time,@status)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
					            new SqlParameter("@no", SqlDbType.NVarChar,50),
					            new SqlParameter("@town", SqlDbType.NVarChar,50),
					            new SqlParameter("@village", SqlDbType.NVarChar,50),
					            new SqlParameter("@address", SqlDbType.NVarChar,50),
                                new SqlParameter("@name", SqlDbType.NVarChar,50),
					            new SqlParameter("@gender", SqlDbType.NVarChar,50),
					            new SqlParameter("@birthday", SqlDbType.NVarChar,50),
                                new SqlParameter("@education", SqlDbType.NVarChar,50),
					            new SqlParameter("@id_card", SqlDbType.NVarChar,50),
					            new SqlParameter("@amount", SqlDbType.Decimal,9),
					            new SqlParameter("@add_time", SqlDbType.DateTime),
                                new SqlParameter("@status", SqlDbType.TinyInt)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.town;
                        parameters[2].Value = model.village;
                        parameters[3].Value = model.address;
                        parameters[4].Value = model.name;
                        parameters[5].Value = model.gender;
                        parameters[6].Value = model.birthday;
                        parameters[7].Value = model.education;
                        parameters[8].Value = model.id_card;
                        parameters[9].Value = model.amount;
                        parameters[10].Value = model.add_time;
                        parameters[11].Value = model.status;
                        //添加主表数据
                        object obj = DbHelperSQL.GetSingle(conn, trans, strSql.ToString(), parameters); //带事务
                        model.id = Convert.ToInt32(obj);
                        #endregion

                        #region 添加家庭成员====================
                        if (model.family != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_exit_family modelt in model.family)
                            {
                                strSql3 = new StringBuilder();
                                strSql3.Append("insert into member_exit_family(");
                                strSql3.Append("member_id,name,gender,relationship,birthday,education)");
                                strSql3.Append(" values (");
                                strSql3.Append("@member_id,@name,@gender,@relationship,@birthday,@education)");
                                SqlParameter[] parameters3 = {
					                new SqlParameter("@member_id", SqlDbType.Int,4),
					                new SqlParameter("@name", SqlDbType.NVarChar,50),
					                new SqlParameter("@gender", SqlDbType.NVarChar,50),
					                new SqlParameter("@relationship", SqlDbType.NVarChar,50),
                                    new SqlParameter("@birthday", SqlDbType.NVarChar,50),
                                    new SqlParameter("@education", SqlDbType.NVarChar,50)};
                                parameters3[0].Value = model.id;
                                parameters3[1].Value = modelt.name;
                                parameters3[2].Value = modelt.gender;
                                parameters3[3].Value = modelt.relationship;
                                parameters3[4].Value = modelt.birthday;
                                parameters3[4].Value = modelt.education;
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
        public bool Update(Model.member_exit model)
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
                        strSql.Append("update member_exit set ");
                        strSql.Append("no=@no,");
                        strSql.Append("town=@town,");
                        strSql.Append("village=@village,");
                        strSql.Append("address=@address,");
                        strSql.Append("name=@name,");
                        strSql.Append("gender=@gender,");
                        strSql.Append("birthday=@birthday,");
                        strSql.Append("education=@education,");
                        strSql.Append("id_card=@id_card,");
                        strSql.Append("amount=@amount,");
                        strSql.Append("add_time=@add_time,");
                        strSql.Append("status=@status");
                        strSql.Append(" where id=@id ");
                        SqlParameter[] parameters = {
					       new SqlParameter("@no", SqlDbType.NVarChar,50),
					            new SqlParameter("@town", SqlDbType.NVarChar,50),
					            new SqlParameter("@village", SqlDbType.NVarChar,50),
					            new SqlParameter("@address", SqlDbType.NVarChar,50),
                                new SqlParameter("@name", SqlDbType.NVarChar,50),
					            new SqlParameter("@gender", SqlDbType.NVarChar,50),
					            new SqlParameter("@birthday", SqlDbType.NVarChar,50),
                                new SqlParameter("@education", SqlDbType.NVarChar,50),
					            new SqlParameter("@id_card", SqlDbType.NVarChar,50),
					            new SqlParameter("@amount", SqlDbType.Decimal,9),
					            new SqlParameter("@add_time", SqlDbType.DateTime),
                                new SqlParameter("@status", SqlDbType.TinyInt),
					        new SqlParameter("@id", SqlDbType.Int,4)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.town;
                        parameters[2].Value = model.village;
                        parameters[3].Value = model.address;
                        parameters[4].Value = model.name;
                        parameters[5].Value = model.gender;
                        parameters[6].Value = model.birthday;
                        parameters[7].Value = model.education;
                        parameters[8].Value = model.id_card;
                        parameters[9].Value = model.amount;
                        parameters[10].Value = model.add_time;
                        parameters[11].Value = model.status;
                        parameters[12].Value = model.id;
                        DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
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
            strSql.Append("delete from member_exit ");
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
            strSql.Append("delete from member_exit ");
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
        public Model.member_exit GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 * from member_exit ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            Model.member_exit model = new Model.member_exit();
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
        public Model.member_exit DataRowToModel(DataRow row)
        {
            Model.member_exit model = new Model.member_exit();
            if (row != null)
            {
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["no"] != null)
                {
                    model.no = row["no"].ToString();
                }
                if (row["town"] != null)
                {
                    model.town = row["town"].ToString();
                }
                if (row["village"] != null)
                {
                    model.village = row["village"].ToString();
                }
                if (row["address"] != null)
                {
                    model.address = row["address"].ToString();
                }
                if (row["name"] != null)
                {
                    model.name = row["name"].ToString();
                }
                if (row["gender"] != null)
                {
                    model.gender = row["gender"].ToString();
                }
                if (row["birthday"] != null)
                {
                    model.birthday = row["birthday"].ToString();
                }
                if (row["education"] != null)
                {
                    model.education = row["education"].ToString();
                }
                if (row["id_card"] != null)
                {
                    model.id_card = row["id_card"].ToString();
                }
                if (row["amount"] != null && row["amount"].ToString() != "")
                {
                    model.amount = decimal.Parse(row["amount"].ToString());
                }
                if (row["add_time"] != null && row["add_time"].ToString() != "")
                {
                    model.add_time = DateTime.Parse(row["add_time"].ToString());
                }
                if (row["status"] != null && row["status"].ToString() != "")
                {
                    model.status = int.Parse(row["status"].ToString());
                }
                model.family = new member_exit_family().GetList(model.id, 0);
            }
            return model;
        }

        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM member_exit ");
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
            strSql.Append(" * ");
            strSql.Append(" FROM member_exit ");
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
            strSql.Append("select * FROM member_exit");
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
            strSql.Append("select count(1) FROM member_exit ");
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
            strSql.Append(")AS Row, T.*  from member_exit T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                strSql.Append(" WHERE " + strWhere);
            }
            strSql.Append(" ) TT");
            strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 修改一列数据
        /// </summary>
        public void UpdateField(int id, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update member_exit set " + strValue);
            strSql.Append(" where id=" + id);
            DbHelperSQL.ExecuteSql(strSql.ToString());
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
            parameters[0].Value = "member_exit";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        /// <summary>
        /// 统计贫困/非贫困会员
        /// </summary>
        public DataSet GetListByType()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select type,count(*) count from member_exit ");
            strSql.Append("group by type ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 统计金银蓝卡会员
        /// </summary>
        public DataSet GetListByLevel()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select level,count(*) count from member_exit ");
            strSql.Append("group by level ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 统计各镇会员
        /// </summary>
        public DataSet GetListByTown()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select town,count(*) count from member_exit ");
            strSql.Append("group by town ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        #endregion  BasicMethod
        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

