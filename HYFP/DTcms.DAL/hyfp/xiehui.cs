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
    /// 数据访问类:xiehui
    /// </summary>
    public partial class xiehui
    {
        public xiehui()
        { }

        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "xiehui");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from xiehui");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(string no)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from xiehui");
            strSql.Append(" where no=@no ");
            SqlParameter[] parameters = {
					new SqlParameter("@no", SqlDbType.NVarChar,50)			};
            parameters[0].Value = no;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.xiehui model)
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
                        strSql.Append("insert into xiehui(");
                        strSql.Append("role_id,role_type,name,village,town,person,tel,address,no,password,salt,add_time,is_lock,parent_id,sort_id)");
                        strSql.Append(" values (");
                        strSql.Append("@role_id,@role_type,@name,@village,@town,@person,@tel,@address,@no,@password,@salt,@add_time,@is_lock,@parent_id,@sort_id)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
                        new SqlParameter("@role_id", SqlDbType.Int,4),
					    new SqlParameter("@role_type", SqlDbType.Int,4),
					    new SqlParameter("@name", SqlDbType.NVarChar,50),
					    new SqlParameter("@village", SqlDbType.NVarChar,50),
					    new SqlParameter("@town", SqlDbType.NVarChar,50),
					    new SqlParameter("@person", SqlDbType.NVarChar,50),
					    new SqlParameter("@tel", SqlDbType.NVarChar,50),
					    new SqlParameter("@address", SqlDbType.NVarChar,200),
					    new SqlParameter("@no", SqlDbType.NVarChar,50),
					    new SqlParameter("@password", SqlDbType.NVarChar,50),
                        new SqlParameter("@salt", SqlDbType.NVarChar,20),
					    new SqlParameter("@add_time", SqlDbType.DateTime),
                        new SqlParameter("@is_lock", SqlDbType.Int),
                        new SqlParameter("@parent_id", SqlDbType.Int),
                        new SqlParameter("@sort_id", SqlDbType.Int)};
                        parameters[0].Value = model.role_id;
                        parameters[1].Value = model.role_type;
                        parameters[2].Value = model.name;
                        parameters[3].Value = model.village;
                        parameters[4].Value = model.town;
                        parameters[5].Value = model.person;
                        parameters[6].Value = model.tel;
                        parameters[7].Value = model.address;
                        parameters[8].Value = model.no;
                        parameters[9].Value = model.password;
                        parameters[10].Value = model.salt;
                        parameters[11].Value = model.add_time;
                        parameters[12].Value = model.is_lock;
                        parameters[13].Value = model.parent_id;
                        parameters[14].Value = model.sort_id;
                        //添加主表数据
                        object obj = DbHelperSQL.GetSingle(conn, trans, strSql.ToString(), parameters); //带事务
                        model.id = Convert.ToInt32(obj);
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
        public bool Update(Model.xiehui model)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update xiehui set ");
            strSql.Append("role_id=@role_id,");
            strSql.Append("role_type=@role_type,");
            strSql.Append("name=@name,");
            strSql.Append("village=@village,");
            strSql.Append("town=@town,");
            strSql.Append("person=@person,");
            strSql.Append("tel=@tel,");
            strSql.Append("address=@address,");
            strSql.Append("no=@no,");
            strSql.Append("password=@password,");
            strSql.Append("salt=@salt,");
            strSql.Append("add_time=@add_time,");
            strSql.Append("is_lock=@is_lock,");
            strSql.Append("parent_id=@parent_id,");
            strSql.Append("sort_id=@sort_id");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@role_id", SqlDbType.Int,4),
					new SqlParameter("@role_type", SqlDbType.Int,4),
					new SqlParameter("@name", SqlDbType.NVarChar,50),
					new SqlParameter("@village", SqlDbType.NVarChar,50),
					new SqlParameter("@town", SqlDbType.NVarChar,50),
					new SqlParameter("@person", SqlDbType.NVarChar,50),
					new SqlParameter("@tel", SqlDbType.NVarChar,50),
					new SqlParameter("@address", SqlDbType.NVarChar,200),
					new SqlParameter("@no", SqlDbType.NVarChar,50),
					new SqlParameter("@password", SqlDbType.NVarChar,50),
                    new SqlParameter("@salt", SqlDbType.NVarChar,20),
					new SqlParameter("@add_time", SqlDbType.DateTime),
                    new SqlParameter("@is_lock", SqlDbType.Int),
                    new SqlParameter("@parent_id", SqlDbType.Int,4),
                    new SqlParameter("@sort_id", SqlDbType.Int,4),
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = model.role_id;
            parameters[1].Value = model.role_type;
            parameters[2].Value = model.name;
            parameters[3].Value = model.village;
            parameters[4].Value = model.town;
            parameters[5].Value = model.person;
            parameters[6].Value = model.tel;
            parameters[7].Value = model.address;
            parameters[8].Value = model.no;
            parameters[9].Value = model.password;
            parameters[10].Value = model.salt;
            parameters[11].Value = model.add_time;
            parameters[12].Value = model.is_lock;
            parameters[13].Value = model.parent_id;
            parameters[14].Value = model.sort_id;
            parameters[15].Value = model.id;

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
        /// 修改一列数据
        /// </summary>
        public bool UpdateField(int id, string strValue)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update xiehui set " + strValue);
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
            strSql.Append("update xiehui set " + strValue);
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
        /// 删除一条数据
        /// </summary>
        public bool Delete(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from xiehui ");
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
            strSql.Append("delete from xiehui ");
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
        public Model.xiehui GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 * from xiehui ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            Model.xiehui model = new Model.xiehui();
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
        /// 根据用户名密码返回一个实体
        /// </summary>
        public Model.xiehui GetModel(string no, string password)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select id from xiehui");
            strSql.Append(" where no=@no and password=@password and is_lock=0");
            SqlParameter[] parameters = {
					new SqlParameter("@no", SqlDbType.NVarChar,100),
                    new SqlParameter("@password", SqlDbType.NVarChar,100)};
            parameters[0].Value = no;
            parameters[1].Value = password;

            object obj = DbHelperSQL.GetSingle(strSql.ToString(), parameters);
            if (obj != null)
            {
                return GetModel(Convert.ToInt32(obj));
            }
            return null;
        }

        /// <summary>
        /// 根据用户名取得Salt
        /// </summary>
        public string GetSalt(string no)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 salt from xiehui");
            strSql.Append(" where no=@no");
            SqlParameter[] parameters = {
                    new SqlParameter("@no", SqlDbType.NVarChar,100)};
            parameters[0].Value = no;
            string salt = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString(), parameters));
            if (string.IsNullOrEmpty(salt))
            {
                return "";
            }
            return salt;
        }


        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        public Model.xiehui DataRowToModel(DataRow row)
        {
            Model.xiehui model = new Model.xiehui();
            if (row != null)
            {
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["role_id"] != null && row["role_id"].ToString() != "")
                {
                    model.role_id = int.Parse(row["role_id"].ToString());
                }
                if (row["role_type"] != null && row["role_type"].ToString() != "")
                {
                    model.role_type = int.Parse(row["role_type"].ToString());
                }
                if (row["name"] != null)
                {
                    model.name = row["name"].ToString();
                }
                if (row["town"] != null)
                {
                    model.town = row["town"].ToString();
                }
                if (row["village"] != null)
                {
                    model.village = row["village"].ToString();
                }
                if (row["person"] != null)
                {
                    model.person = row["person"].ToString();
                }
                if (row["tel"] != null)
                {
                    model.tel = row["tel"].ToString();
                }
                if (row["address"] != null)
                {
                    model.address = row["address"].ToString();
                }
                if (row["no"] != null)
                {
                    model.no = row["no"].ToString();
                }
                if (row["password"] != null)
                {
                    model.password = row["password"].ToString();
                }
                if (row["salt"] != null)
                {
                    model.salt = row["salt"].ToString();
                }
                if (row["add_time"] != null && row["add_time"].ToString() != "")
                {
                    model.add_time = DateTime.Parse(row["add_time"].ToString());
                }
                if (row["parent_id"] != null && row["parent_id"].ToString() != "")
                {
                    model.parent_id = int.Parse(row["parent_id"].ToString());
                }
                if (row["sort_id"] != null && row["sort_id"].ToString() != "")
                {
                    model.sort_id = int.Parse(row["sort_id"].ToString());
                }
            }
            return model;
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
            strSql.Append(" id,name,xiehui,town,person,tel,address,no,password,salt,add_time ");
            strSql.Append(" FROM xiehui ");
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
            strSql.Append("select * FROM xiehui");
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
            strSql.Append("select count(1) FROM xiehui ");
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
            strSql.Append(")AS Row, T.*  from xiehui T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                strSql.Append(" WHERE " + strWhere);
            }
            strSql.Append(" ) TT");
            strSql.AppendFormat(" WHERE TT.Row between {0} and {1}", startIndex, endIndex);
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 根据用户名取得RealName
        /// </summary>
        public string GetRealName(string no)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 name from xiehui");
            strSql.Append(" where no=@no");
            SqlParameter[] parameters = {
                    new SqlParameter("@no", SqlDbType.NVarChar,100)};
            parameters[0].Value = no;
            string realname = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString(), parameters));
            if (string.IsNullOrEmpty(realname))
            {
                return "";
            }
            return realname;
        }

        /// <summary>
        /// 返回协会名称
        /// </summary>
        public string GetName(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 name from xiehui");
            strSql.Append(" where id=" + id);
            string title = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(title))
            {
                return string.Empty;
            }
            return title;
        }

        /// <summary>
        /// 根据村镇查询协会
        /// </summary>
        public string GetId(string town, string xiehui)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 id from xiehui");
            strSql.Append(" where town='" + town + "'");
            strSql.Append(" and xiehui='" + xiehui + "'");
            string id = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(id))
            {
                return string.Empty;
            }
            return id;
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
            strSql.Append(" FROM xiehui");
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
            newData.Columns.Add("town", typeof(string));
            newData.Columns.Add("village", typeof(string));
            newData.Columns.Add("person", typeof(string));
            newData.Columns.Add("tel", typeof(string));
            newData.Columns.Add("address", typeof(string));
            newData.Columns.Add("no", typeof(string));
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
            strSql.Append(" FROM xiehui");
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
            strSql.Append(" FROM xiehui ");
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
            strSql.Append(" FROM xiehui ");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            strSql.Append(" order by " + filedOrder);
            return DbHelperSQL.Query(strSql.ToString());
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
                row["town"] = dr[i]["town"].ToString();
                row["village"] = dr[i]["village"].ToString();
                row["person"] = dr[i]["person"].ToString();
                row["tel"] = dr[i]["tel"].ToString();
                row["address"] = dr[i]["address"].ToString();
                row["no"] = dr[i]["no"].ToString();
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
            parameters[0].Value = "xiehui";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        #endregion  BasicMethod

        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

