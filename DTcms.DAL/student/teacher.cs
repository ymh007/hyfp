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
    /// 数据访问类:导师
    /// </summary>
    public partial class teacher
    {
        private string databaseprefix; //数据库表名前缀
        public teacher(string _databaseprefix)
        {
            databaseprefix = _databaseprefix;
        }
        #region 基本方法================================
        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from " + databaseprefix + "teacher");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 根据编号查询是否存在
        /// </summary>
        public bool Exists(string no)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from " + databaseprefix + "teacher");
            strSql.Append(" where no=@no");
            SqlParameter[] parameters = {
					new SqlParameter("@no", SqlDbType.NVarChar,100)};
            parameters[0].Value = no;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 返回学术型导师可分配指标数
        /// </summary>
        public string GetResQuota(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 resquota from " + databaseprefix + "teacher");
            strSql.Append(" where id=" + id);
            string quota = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(quota))
            {
                return "";
            }
            return quota;
        }

        /// <summary>
        /// 返回专业型导师可分配指标数
        /// </summary>
        public string GetProResQuota(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 pro_resquota from " + databaseprefix + "teacher");
            strSql.Append(" where id=" + id);
            string quota = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(quota))
            {
                return "";
            }
            return quota;
        }

        /// <summary>
        /// 返回导师姓名
        /// </summary>
        public string GetName(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 name from " + databaseprefix + "teacher");
            strSql.Append(" where id=" + id);
            string name = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(name))
            {
                return "";
            }
            return name;
        }

        /// <summary>
        /// 获取该导师选择学生Ids
        /// </summary>
        public string GetStudentIds(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 students from " + databaseprefix + "teacher");
            strSql.Append(" where id=" + id);
            string students = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(students))
            {
                return "";
            }
            return students;
        }

        /// <summary>
        /// 获取已被选中学生Id列表
        /// </summary>
        public DataSet GetStudents()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT students FROM " + databaseprefix + "teacher");
            strSql.Append(" WHERE students IS NOT NULL");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.teacher model)
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
                        strSql.Append("insert into " + databaseprefix + "teacher(");
                        strSql.Append("no,name,quota,email,add_time,students,resquota,direction,major,is_aca,is_pro,pro_quota,pro_resquota)");
                        strSql.Append(" values (");
                        strSql.Append("@no,@name,@quota,@email,@add_time,@students,@resquota,@direction,@major,@is_aca,@is_pro,@pro_quota,@pro_resquota)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
                                new SqlParameter("@no", SqlDbType.NVarChar,50),
                                new SqlParameter("@name", SqlDbType.NVarChar,50),
                                new SqlParameter("@quota", SqlDbType.NVarChar,50),
                                new SqlParameter("@email", SqlDbType.NVarChar,50),
                                new SqlParameter("@add_time", SqlDbType.DateTime),
                                new SqlParameter("@students", SqlDbType.NVarChar,100),
                                new SqlParameter("@resquota", SqlDbType.NVarChar,100),
                                new SqlParameter("@direction", SqlDbType.NVarChar,50),
                                new SqlParameter("@major", SqlDbType.NVarChar,50),
                                new SqlParameter("@is_aca", SqlDbType.NVarChar,50),
                                new SqlParameter("@is_pro", SqlDbType.NVarChar,50),
                                new SqlParameter("@pro_quota", SqlDbType.NVarChar,50),
                                new SqlParameter("@pro_resquota", SqlDbType.NVarChar,50)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.name;
                        parameters[2].Value = model.quota;
                        parameters[3].Value = model.email;
                        parameters[4].Value = model.add_time;
                        parameters[5].Value = model.students;
                        parameters[6].Value = model.resquota;
                        parameters[7].Value = model.direction;
                        parameters[8].Value = model.major;
                        parameters[9].Value = model.is_aca;
                        parameters[10].Value = model.is_pro;
                        parameters[11].Value = model.pro_quota;
                        parameters[12].Value = model.pro_resquota;
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
        public bool Update(Model.teacher model)
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
                        strSql.Append("update " + databaseprefix + "teacher set ");
                        strSql.Append("no=@no,name=@name,quota=@quota,email=@email,students=@students,resquota=@resquota,direction=@direction,major=@major,is_aca=@is_aca,is_pro=@is_pro,pro_quota=@pro_quota,pro_resquota=@pro_resquota ");
                        strSql.Append(" where id=@id");
                        SqlParameter[] parameters = {
					            new SqlParameter("@no", SqlDbType.NVarChar,50),
					            new SqlParameter("@name", SqlDbType.NVarChar,50),
                                new SqlParameter("@quota", SqlDbType.NVarChar,50),
                                new SqlParameter("@email", SqlDbType.NVarChar,50),
                                new SqlParameter("@students", SqlDbType.NVarChar,100),
                                new SqlParameter("@resquota", SqlDbType.NVarChar,50),
                                new SqlParameter("@direction", SqlDbType.NVarChar,50),
                                new SqlParameter("@major", SqlDbType.NVarChar,50),
                                new SqlParameter("@is_aca", SqlDbType.NVarChar,50),
                                new SqlParameter("@is_pro", SqlDbType.NVarChar,50),
                                new SqlParameter("@pro_quota", SqlDbType.NVarChar,50),
                                new SqlParameter("@pro_resquota", SqlDbType.NVarChar,50),
					            new SqlParameter("@id", SqlDbType.Int,4)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.name;
                        parameters[2].Value = model.quota;
                        parameters[3].Value = model.email;
                        parameters[4].Value = model.students;
                        parameters[5].Value = model.resquota;
                        parameters[6].Value = model.direction;
                        parameters[7].Value = model.major;
                        parameters[8].Value = model.is_aca;
                        parameters[9].Value = model.is_pro;
                        parameters[10].Value = model.pro_quota;
                        parameters[11].Value = model.pro_resquota;
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

            //删除主表
            StringBuilder strSql = new StringBuilder();
            strSql.Append("delete from " + databaseprefix + "teacher ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            StringBuilder managerStrSql = new StringBuilder();
            managerStrSql.Append("delete from " + databaseprefix + "manager ");
            managerStrSql.Append(" where user_name=");
            managerStrSql.Append(" (select no from " + databaseprefix + "teacher where id=@id)");
            SqlParameter[] managerParameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            managerParameters[0].Value = id;
            DbHelperSQL.ExecuteSql(managerStrSql.ToString(), managerParameters);

            int rowCount = DbHelperSQL.ExecuteSql(strSql.ToString(), parameters);
            if (rowCount > 0)
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
        public Model.teacher GetModel(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 id,no,name,quota,email,add_time,students,resquota,direction,major,is_aca,is_pro,pro_quota,pro_resquota ");
            strSql.Append(" from " + databaseprefix + "teacher");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            Model.article model = new Model.article();
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
            strSql.Append(" id,no,name,quota,email,add_time,students,resquota,direction,major,is_aca,is_pro,pro_quota,pro_resquota ");
            strSql.Append(" FROM " + databaseprefix + "teacher ");
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
            strSql.Append("select * FROM " + databaseprefix + "teacher");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            recordCount = Convert.ToInt32(DbHelperSQL.GetSingle(PagingHelper.CreateCountingSql(strSql.ToString())));
            return DbHelperSQL.Query(PagingHelper.CreatePagingSql(recordCount, pageSize, pageIndex, strSql.ToString(), filedOrder));
        }
        #endregion

        #region 私有方法================================
        /// <summary>
        /// 将对象转换为实体
        /// </summary>
        private Model.teacher DataRowToModel(DataRow row)
        {
            Model.teacher model = new Model.teacher();
            if (row != null)
            {
                #region 主表信息======================
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["no"] != null)
                {
                    model.no = row["no"].ToString();
                }
                if (row["name"] != null)
                {
                    model.name = row["name"].ToString();
                }
                if (row["quota"] != null)
                {
                    model.quota = row["quota"].ToString();
                }
                if (row["resquota"] != null)
                {
                    model.resquota = row["resquota"].ToString();
                }
                if (row["email"] != null)
                {
                    model.email = row["email"].ToString();
                }
                if (row["add_time"] != null && row["add_time"].ToString() != "")
                {
                    model.add_time = DateTime.Parse(row["add_time"].ToString());
                }
                if (row["students"] != null)
                {
                    model.students = row["students"].ToString();
                }
                if (row["direction"] != null)
                {
                    model.direction = row["direction"].ToString();
                }
                if (row["major"] != null)
                {
                    model.major = row["major"].ToString();
                }
                if (row["is_aca"] != null)
                {
                    model.is_aca = row["is_aca"].ToString();
                }
                if (row["is_pro"] != null)
                {
                    model.is_pro = row["is_pro"].ToString();
                }
                if (row["pro_quota"] != null)
                {
                    model.pro_quota = row["pro_quota"].ToString();
                }
                if (row["pro_resquota"] != null)
                {
                    model.pro_resquota = row["pro_resquota"].ToString();
                }
                #endregion
            }
            return model;
        }
        #endregion
    }
}

