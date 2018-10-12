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
    /// 数据访问类:学生
    /// </summary>
    public partial class student
    {
        private string databaseprefix; //数据库表名前缀
        public student(string _databaseprefix)
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
            strSql.Append("select count(1) from " + databaseprefix + "student");
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
            strSql.Append("select count(1) from " + databaseprefix + "student");
            strSql.Append(" where no=@no");
            SqlParameter[] parameters = {
					new SqlParameter("@no", SqlDbType.NVarChar,100)};
            parameters[0].Value = no;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }

        /// <summary>
        /// 获取名称
        /// </summary>
        public string GetNames(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("declare @s varchar(8000) set @s=''");
            strSql.Append("select @s=@s+name+','");
            strSql.Append("from dt_student");
            strSql.Append(" WHERE CONVERT(NVARCHAR(50),id) IN(");
            strSql.Append("select * from dbo.f_split((select students from dt_teacher where id=" + id + "),','))");
            strSql.Append("select left(@s,len(@s)-1)");
            string names = Convert.ToString(DbHelperSQL.GetSingle(strSql.ToString()));
            if (string.IsNullOrEmpty(names))
            {
                return "";
            }
            return names;
        }

        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.student model)
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
                        strSql.Append("insert into " + databaseprefix + "student(");
                        strSql.Append("no,name,school,score,re_score,add_time,teacher_id,status,is_aca,attach)");
                        strSql.Append(" values (");
                        strSql.Append("@no,@name,@school,@score,@re_score,@add_time,@teacher_id,@status,@is_aca,@attach)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
                                new SqlParameter("@no", SqlDbType.NVarChar,50),
                                new SqlParameter("@name", SqlDbType.NVarChar,50),
                                new SqlParameter("@school", SqlDbType.NVarChar,50),
                                new SqlParameter("@score", SqlDbType.NVarChar,50),
                                new SqlParameter("@re_score", SqlDbType.NVarChar,50),
                                new SqlParameter("@add_time", SqlDbType.DateTime),
                                new SqlParameter("@teacher_id", SqlDbType.Int,4),
                                new SqlParameter("@status", SqlDbType.NVarChar,50),
                                new SqlParameter("@is_aca", SqlDbType.NVarChar,50),
                                new SqlParameter("@attach", SqlDbType.NVarChar,50)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.name;
                        parameters[2].Value = model.school;
                        parameters[3].Value = model.score;
                        parameters[4].Value = model.re_score;
                        parameters[5].Value = model.add_time;
                        parameters[6].Value = model.teacher_id;
                        parameters[7].Value = model.status;
                        parameters[8].Value = model.is_aca;
                        parameters[9].Value = model.attach;
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
        public bool Update(Model.student model)
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
                        strSql.Append("update " + databaseprefix + "student set ");
                        strSql.Append("no=@no,name=@name,school=@school,score=@score,re_score=@re_score,teacher_id=@teacher_id,status=@status,is_aca=@is_aca,attach=@attach ");
                        strSql.Append(" where id=@id");
                        SqlParameter[] parameters = {
					            new SqlParameter("@no", SqlDbType.NVarChar,50),
					            new SqlParameter("@name", SqlDbType.NVarChar,50),
                                new SqlParameter("@school", SqlDbType.NVarChar,50),
                                new SqlParameter("@score", SqlDbType.NVarChar,50),
                                new SqlParameter("@re_score", SqlDbType.NVarChar,50),
                                new SqlParameter("@teacher_id", SqlDbType.Int,4),
                                new SqlParameter("@status", SqlDbType.NVarChar,50),
                                new SqlParameter("@is_aca", SqlDbType.NVarChar,50),
                                new SqlParameter("@attach", SqlDbType.NVarChar,50),
					            new SqlParameter("@id", SqlDbType.Int,4)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.name;
                        parameters[2].Value = model.school;
                        parameters[3].Value = model.score;
                        parameters[4].Value = model.re_score;
                        parameters[5].Value = model.teacher_id;
                        parameters[6].Value = model.status;
                        parameters[7].Value = model.is_aca;
                        parameters[8].Value = model.attach;
                        parameters[9].Value = model.id;
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
            strSql.Append("delete from " + databaseprefix + "student ");
            strSql.Append(" where id=@id");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)};
            parameters[0].Value = id;

            StringBuilder managerStrSql = new StringBuilder();
            managerStrSql.Append("delete from " + databaseprefix + "manager ");
            managerStrSql.Append(" where user_name=");
            managerStrSql.Append(" (select no from " + databaseprefix + "student where id=@id)");
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
        /// 撤回导师选择
        /// </summary>
        public bool Cancel(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("update " + databaseprefix + "student set");
            strSql.Append(" teacher_id='',status=''");
            strSql.Append(" where id=" + id);
            int rowCount = DbHelperSQL.ExecuteSql(strSql.ToString());
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
        public Model.student GetModel(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select top 1 id,no,name,school,score,re_score,add_time,teacher_id,status,is_aca,attach ");
            strSql.Append(" from " + databaseprefix + "student");
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
            strSql.Append(" id,no,name,school,score,re_score,add_time,teacher_id,status,is_aca,attach ");
            strSql.Append(" FROM " + databaseprefix + "student ");
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
            strSql.Append("select * FROM " + databaseprefix + "student");
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
        private Model.student DataRowToModel(DataRow row)
        {
            Model.student model = new Model.student();
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
                if (row["school"] != null)
                {
                    model.school = row["school"].ToString();
                }
                if (row["score"] != null)
                {
                    model.score = row["score"].ToString();
                }
                if (row["name"] != null)
                {
                    model.re_score = row["re_score"].ToString();
                }
                if (row["teacher_id"] != null && row["teacher_id"].ToString() != "")
                {
                    model.teacher_id = int.Parse(row["teacher_id"].ToString());
                }
                if (row["status"] != null)
                {
                    model.status = row["status"].ToString();
                }
                if (row["is_aca"] != null)
                {
                    model.is_aca = row["is_aca"].ToString();
                }
                if (row["attach"] != null)
                {
                    model.attach = row["attach"].ToString();
                }
                if (row["add_time"] != null && row["add_time"].ToString() != "")
                {
                    model.add_time = DateTime.Parse(row["add_time"].ToString());
                }
                #endregion
            }
            return model;
        }
        #endregion
    }
}

