using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using DTcms.DBUtility;
using DTcms.Common;

namespace DTcms.DAL
{
    /// <summary>
    /// 数据访问类:后台导航菜单
    /// </summary>
    public partial class account_manager
    {
        private string databaseprefix; //数据库表名前缀
        public account_manager(string _databaseprefix)
        {
            databaseprefix = _databaseprefix;
        }

        #region 基本方法===============================
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from account_manager");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 查询是否存在该记录
        /// </summary>
        public bool Exists(string name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from account_manager");
            strSql.Append(" where name=@name ");
            SqlParameter[] parameters = {
					new SqlParameter("@name", SqlDbType.VarChar,50)};
            parameters[0].Value = name;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.account_manager model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("insert into account_manager(");
            strSql.Append("parent_id,name,type,sort_id)");
            strSql.Append(" values (");
            strSql.Append("@parent_id,@name,@type,@sort_id)");
            strSql.Append(";select @@IDENTITY");
            SqlParameter[] parameters = {
                        new SqlParameter("@parent_id", SqlDbType.Int,4),
                        new SqlParameter("@name", SqlDbType.NVarChar,50),
					    new SqlParameter("@type", SqlDbType.NVarChar,50),
                        new SqlParameter("@sort_id", SqlDbType.Int,4)};
            parameters[0].Value = model.parent_id;
            parameters[1].Value = model.name;
            parameters[2].Value = model.type;
            parameters[3].Value = model.sort_id;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
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
        /// 更新一条数据
        /// </summary>
        public bool Update(Model.account_manager model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update account_manager set ");
            strSql.Append("parent_id=@parent_id,");
            strSql.Append("name=@name,");
            strSql.Append("type=@type,");
            strSql.Append("sort_id=@sort_id");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@parent_id", SqlDbType.Int,4),
					new SqlParameter("@name", SqlDbType.NVarChar,50),
					new SqlParameter("@type", SqlDbType.NVarChar,50),
					new SqlParameter("@sort_id", SqlDbType.Int,4),
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = model.parent_id;
            parameters[1].Value = model.name;
            parameters[2].Value = model.type;
            parameters[3].Value = model.sort_id;
            parameters[4].Value = model.id;

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
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from account_manager");
            strSql.Append(" where id in(" + GetIds(id) + ")");

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
        public Model.account_manager GetModel(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 *");
            strSql.Append(" from account_manager ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            Model.account_manager model = new Model.account_manager();
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
        public Model.account_manager GetModel(string name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 *");
            strSql.Append(" from account_manager ");
            strSql.Append(" where name=@name");
            SqlParameter[] parameters = {
					new SqlParameter("@name", SqlDbType.NVarChar,50)};
            parameters[0].Value = name;

            Model.account_manager model = new Model.account_manager();
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
        /// 获取类别列表
        /// </summary>
        /// <param name="parent_id">父ID</param>
        /// <param name="nav_type">导航类别</param>
        /// <returns>DataTable</returns>
        public DataTable GetList(int parent_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select *");
            strSql.Append(" FROM account_manager");
            strSql.Append(" order by sort_id asc,id desc");
            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            //重组列表
            DataTable oldData = ds.Tables[0] as DataTable;
            if (oldData == null)
            {
                return null;
            }
            //创建一个新的DataTable增加一个深度字段
            DataTable newData = new DataTable();
            newData.Columns.Add("id", typeof(int));
            newData.Columns.Add("parent_id", typeof(int));
            newData.Columns.Add("class_layer", typeof(int));
            newData.Columns.Add("name", typeof(string));
            newData.Columns.Add("type", typeof(string));
            newData.Columns.Add("sort_id", typeof(int));
            //调用迭代组合成DAGATABLE
            GetChilds(oldData, newData, parent_id, 0);
            return newData;
        }

        /// <summary>
        /// 获取类别列表
        /// </summary>
        /// <param name="parent_id">父ID</param>
        /// <param name="nav_type">导航类别</param>
        /// <returns>DataTable</returns>
        public DataTable GetParentList(int parent_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select *");
            strSql.Append(" FROM account_manager");
            strSql.Append(" where parent_id=" + parent_id);
            strSql.Append(" order by sort_id asc,id desc");
            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            return ds.Tables[0];
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM account_manager ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            return DbHelperSQL.Query(strSql.ToString());
        }
        /// <summary>
        /// 获得数据列表
        /// </summary>
        public DataSet GetList(string strWhere, string filedOrder)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select * ");
            strSql.Append(" FROM account_manager ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
        }
        #endregion

        #region 扩展方法===============================
        /// <summary>
        /// 根据导航的名称查询其ID
        /// </summary>
        public int GetNavId(string nav_name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 id from account_manager");
            strSql.Append(" where name=@nav_name");
            SqlParameter[] parameters = {
					new SqlParameter("@nav_name", SqlDbType.NVarChar,50)};
            parameters[0].Value = nav_name;
            string str = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString(), parameters));
            return Utils.StrToInt(str, 0);
        }

        /// <summary>
        /// 获取父类下的所有子类ID(含自己本身)
        /// </summary>
        public string GetIds(int parent_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id,parent_id");
            strSql.Append(" FROM account_manager");
            DataSet ds = DbHelperSQL.Query(strSql.ToString());
            string ids = parent_id.ToString() + ",";
            GetChildIds(ds.Tables[0], parent_id, ref ids);
            return ids.TrimEnd(',');
        }

        /// <summary>
        /// 获取父类下的所有子类ID(含自己本身)
        /// </summary>
        public string GetIds(string name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 id from account_manager");
            strSql.Append(" where name=@name");
            SqlParameter[] parameters = {
					new SqlParameter("@name", SqlDbType.NVarChar,50)};
            parameters[0].Value = name;
            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj != null)
            {
                return GetIds(Convert.ToInt32(obj));
            }
            return string.Empty;
        }

        /// <summary>
        /// 修改一列数据
        /// </summary>
        public bool UpdateField(int id, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update account_manager set " + strValue);
            strSql.Append(" where id=" + id);
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
        /// 修改一列数据
        /// </summary>
        public bool UpdateField(string name, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update account_manager set " + strValue);
            strSql.Append(" where name='" + name + "'");
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
        /// 修改一条记录，带事务
        /// </summary>
        public bool Update(SqlConnection conn, SqlTransaction trans, string old_name, string new_name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update account_manager set name=@new_name");
            strSql.Append(" where name=@old_name");
            SqlParameter[] parameters = {
					            new SqlParameter("@new_name", SqlDbType.NVarChar,50),
					            new SqlParameter("@old_name", SqlDbType.NVarChar,50)};
            parameters[0].Value = new_name;
            parameters[1].Value = old_name;
            int rows = DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
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
        /// 修改一条记录，带事务
        /// </summary>
        public bool Update(SqlConnection conn, SqlTransaction trans, string old_name, string new_name, string title, int sort_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update account_manager set");
            strSql.Append(" name=@new_name,");
            strSql.Append(" title=@title,");
            strSql.Append(" sort_id=@sort_id");
            strSql.Append(" where name=@old_name");
            SqlParameter[] parameters = {
					new SqlParameter("@new_name", SqlDbType.NVarChar,50),
                    new SqlParameter("@title", SqlDbType.NVarChar,100),
                    new SqlParameter("@sort_id", SqlDbType.Int,4),
                    new SqlParameter("@old_name", SqlDbType.NVarChar,50)};
            parameters[0].Value = new_name;
            parameters[1].Value = title;
            parameters[2].Value = sort_id;
            parameters[3].Value = old_name;
            int rows = DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
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
        /// 修改一条记录，带事务
        /// </summary>
        public bool Update(SqlConnection conn, SqlTransaction trans, string old_name, int parent_id, string nav_name, string title, int sort_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update account_manager set");
            strSql.Append(" parent_id=@parent_id,");
            strSql.Append(" name=@name,");
            strSql.Append(" title=@title,");
            strSql.Append(" sort_id=@sort_id");
            strSql.Append(" where name=@old_name");
            SqlParameter[] parameters = {
					new SqlParameter("@parent_id", SqlDbType.Int,4),
					new SqlParameter("@name", SqlDbType.NVarChar,50),
                    new SqlParameter("@title", SqlDbType.NVarChar,100),
                    new SqlParameter("@sort_id", SqlDbType.Int,4),
                    new SqlParameter("@old_name", SqlDbType.NVarChar,50)};
            parameters[0].Value = parent_id;
            parameters[1].Value = nav_name;
            parameters[2].Value = title;
            parameters[3].Value = sort_id;
            parameters[4].Value = old_name;
            int rows = DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
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
        /// 得到一个对象实体，带事务
        /// </summary>
        public Model.account_manager GetModel(SqlConnection conn, SqlTransaction trans, string nav_name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 *");
            strSql.Append(" from account_manager ");
            strSql.Append(" where name=@nav_name");
            SqlParameter[] parameters = {
					new SqlParameter("@nav_name", SqlDbType.NVarChar,50)};
            parameters[0].Value = nav_name;

            Model.account_manager model = new Model.account_manager();
            DataSet ds = DbHelperSQL.Query(conn, trans, strSql.ToString(), parameters);
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
        /// 删除一条数据，带事务
        /// </summary>
        public bool Delete(SqlConnection conn, SqlTransaction trans, string nav_name)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from account_manager");
            strSql.Append(" where name=@name");
            SqlParameter[] parameters = {
					new SqlParameter("@name", SqlDbType.NVarChar,50)};
            parameters[0].Value = nav_name;

            int rows = DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
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
        /// 返回科目名称
        /// </summary>
        public string GetName(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 name from account_manager");
            strSql.Append(" where id=" + id);
            string title = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(title))
            {
                return string.Empty;
            }
            return title;
        }
        #endregion

        #region 私有方法===============================
        /// <summary>
        /// 组合成对象实体
        /// </summary>
        private Model.account_manager DataRowToModel(DataRow row)
        {
            Model.account_manager model = new Model.account_manager();
            if (row != null)
            {
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["parent_id"] != null && row["parent_id"].ToString() != "")
                {
                    model.parent_id = int.Parse(row["parent_id"].ToString());
                }
                if (row["type"] != null)
                {
                    model.type = row["type"].ToString();
                }
                if (row["name"] != null)
                {
                    model.name = row["name"].ToString();
                }
                if (row["sort_id"] != null && row["sort_id"].ToString() != "")
                {
                    model.sort_id = int.Parse(row["sort_id"].ToString());
                }
            }
            return model;
        }

        /// <summary>
        /// 从内存中取得所有下级类别列表（自身迭代）
        /// </summary>
        private void GetChilds(DataTable oldData, DataTable newData, int parent_id, int class_layer)
        {
            class_layer++;
            DataRow[] dr = oldData.Select("parent_id=" + parent_id);
            for (int i = 0; i < dr.Length; i++)
            {
                //添加一行数据
                DataRow row = newData.NewRow();
                row["id"] = int.Parse(dr[i]["id"].ToString());
                row["parent_id"] = int.Parse(dr[i]["parent_id"].ToString());
                row["class_layer"] = class_layer;
                row["name"] = dr[i]["name"].ToString();
                row["type"] = dr[i]["type"].ToString();
                row["sort_id"] = int.Parse(dr[i]["sort_id"].ToString());
                newData.Rows.Add(row);
                //调用自身迭代
                this.GetChilds(oldData, newData, int.Parse(dr[i]["id"].ToString()), class_layer);
            }
        }

        /// <summary>
        /// 获取父类下的所有子类ID
        /// </summary>
        private void GetChildIds(DataTable dt, int parent_id, ref string ids)
        {
            DataRow[] dr = dt.Select("parent_id=" + parent_id);
            for (int i = 0; i < dr.Length; i++)
            {
                ids += dr[i]["id"].ToString() + ",";
                //调用自身迭代
                this.GetChildIds(dt, int.Parse(dr[i]["id"].ToString()), ref ids);
            }
        }
        #endregion
    }
}

