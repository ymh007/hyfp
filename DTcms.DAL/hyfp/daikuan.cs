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
    /// 数据访问类:daikuan
    /// </summary>
    public partial class daikuan
    {
        public daikuan()
        { }

        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "daikuan");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from daikuan");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.daikuan model)
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
                        strSql.Append("insert into daikuan(");
                        strSql.Append("name,level,gender,tel,id_card,member_no,amount,purpose,lb_person,add_time,audit_time,member_id,lb_person_names,status,reason,hk_status,yh_amount,wh_amount,zy_amount,cq_amount,can_amount,month,member_amount,chanye,remark)");
                        strSql.Append(" values (");
                        strSql.Append("@name,@level,@gender,@tel,@id_card,@member_no,@amount,@purpose,@lb_person,@add_time,@audit_time,@member_id,@lb_person_names,@status,@reason,@hk_status,@yh_amount,@wh_amount,@zy_amount,@cq_amount,@can_amount,@month,@member_amount,@chanye,@remark)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
					    new SqlParameter("@name", SqlDbType.NVarChar,50),
                        new SqlParameter("@level", SqlDbType.NVarChar,50),
					    new SqlParameter("@gender", SqlDbType.NVarChar,50),
					    new SqlParameter("@tel", SqlDbType.NVarChar,50),
					    new SqlParameter("@id_card", SqlDbType.NVarChar,50),
					    new SqlParameter("@member_no", SqlDbType.NVarChar,50),
					    new SqlParameter("@amount", SqlDbType.Decimal,9),
					    new SqlParameter("@purpose", SqlDbType.NVarChar,50),
					    new SqlParameter("@lb_person", SqlDbType.NVarChar,50),
                        new SqlParameter("@add_time", SqlDbType.DateTime),
					    new SqlParameter("@audit_time", SqlDbType.DateTime),
                        new SqlParameter("@member_id", SqlDbType.Int),
                        new SqlParameter("@lb_person_names", SqlDbType.NVarChar,50),
                        new SqlParameter("@status", SqlDbType.TinyInt,1),
                        new SqlParameter("@reason", SqlDbType.NVarChar,200),
                        new SqlParameter("@hk_status", SqlDbType.TinyInt,1),
                        new SqlParameter("@yh_amount", SqlDbType.Decimal),
                        new SqlParameter("@wh_amount", SqlDbType.Decimal),
                        new SqlParameter("@zy_amount", SqlDbType.Decimal),
                        new SqlParameter("@cq_amount", SqlDbType.Decimal),
                        new SqlParameter("@can_amount", SqlDbType.Decimal),
                        new SqlParameter("@month", SqlDbType.Decimal),
                        new SqlParameter("@member_amount", SqlDbType.Decimal),
                        new SqlParameter("@chanye", SqlDbType.NVarChar,50),
                        new SqlParameter("@remark", SqlDbType.NVarChar)};
                        parameters[0].Value = model.name;
                        parameters[1].Value = model.level;
                        parameters[2].Value = model.gender;
                        parameters[3].Value = model.tel;
                        parameters[4].Value = model.id_card;
                        parameters[5].Value = model.member_no;
                        parameters[6].Value = model.amount;
                        parameters[7].Value = model.purpose;
                        parameters[8].Value = model.lb_person;
                        parameters[9].Value = model.add_time;
                        parameters[10].Value = model.audit_time;
                        parameters[11].Value = model.member_id;
                        parameters[12].Value = model.lb_person_names;
                        parameters[13].Value = model.status;
                        parameters[14].Value = model.reason;
                        parameters[15].Value = model.hk_status;
                        parameters[16].Value = model.yh_amount;
                        parameters[17].Value = model.wh_amount;
                        parameters[18].Value = model.zy_amount;
                        parameters[19].Value = model.cq_amount;
                        parameters[20].Value = model.can_amount;
                        parameters[21].Value = model.month;
                        parameters[22].Value = model.member_amount;
                        parameters[23].Value = model.chanye;
                        parameters[24].Value = model.remark;
                        //添加主表数据
                        object obj = DbHelperSQL.GetSingle(conn, trans, strSql.ToString(), parameters); //带事务
                        model.id = Convert.ToInt32(obj);
                        #endregion

                        #region 添加图片相册====================
                        if (model.albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.daikuan_albums modelt in model.albums)
                            {
                                strSql3 = new StringBuilder();
                                strSql3.Append("insert into daikuan_albums(");
                                strSql3.Append("daikuan_id,thumb_path,original_path,remark,link_url)");
                                strSql3.Append(" values (");
                                strSql3.Append("@daikuan_id,@thumb_path,@original_path,@remark,@link_url)");
                                SqlParameter[] parameters3 = {
					                new SqlParameter("@daikuan_id", SqlDbType.Int,4),
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
        public bool Update(Model.daikuan model)
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
                        strSql.Append("update daikuan set ");
                        strSql.Append("name=@name,");
                        strSql.Append("level=@level,");
                        strSql.Append("gender=@gender,");
                        strSql.Append("tel=@tel,");
                        strSql.Append("id_card=@id_card,");
                        strSql.Append("member_no=@member_no,");
                        strSql.Append("amount=@amount,");
                        strSql.Append("purpose=@purpose,");
                        strSql.Append("lb_person=@lb_person,");
                        strSql.Append("add_time=@add_time,");
                        strSql.Append("audit_time=@audit_time,");
                        strSql.Append("member_id=@member_id,");
                        strSql.Append("lb_person_names=@lb_person_names,");
                        strSql.Append("status=@status,");
                        strSql.Append("reason=@reason,");
                        strSql.Append("hk_status=@hk_status,");
                        strSql.Append("yh_amount=@yh_amount,");
                        strSql.Append("wh_amount=@wh_amount,");
                        strSql.Append("zy_amount=@zy_amount,");
                        strSql.Append("cq_amount=@cq_amount,");
                        strSql.Append("can_amount=@can_amount,");
                        strSql.Append("month=@month,");
                        strSql.Append("member_amount=@member_amount,");
                        strSql.Append("chanye=@chanye,");
                        strSql.Append("remark=@remark");
                        strSql.Append(" where id=@id ");
                        SqlParameter[] parameters = {
					    new SqlParameter("@name", SqlDbType.NVarChar,50),
                        new SqlParameter("@level", SqlDbType.NVarChar,50),
					    new SqlParameter("@gender", SqlDbType.NVarChar,50),
					    new SqlParameter("@tel", SqlDbType.NVarChar,50),
					    new SqlParameter("@id_card", SqlDbType.NVarChar,50),
					    new SqlParameter("@member_no", SqlDbType.NVarChar,50),
					    new SqlParameter("@amount", SqlDbType.Decimal,9),
					    new SqlParameter("@purpose", SqlDbType.NVarChar,50),
					    new SqlParameter("@lb_person", SqlDbType.NVarChar,50),
					    new SqlParameter("@add_time", SqlDbType.DateTime),
                        new SqlParameter("@audit_time", SqlDbType.DateTime),
                        new SqlParameter("@member_id", SqlDbType.Int),
                        new SqlParameter("@lb_person_names", SqlDbType.NVarChar,50),
                        new SqlParameter("@status", SqlDbType.TinyInt,1),
                        new SqlParameter("@hk_status", SqlDbType.TinyInt,1),
                        new SqlParameter("@reason", SqlDbType.NVarChar,200),
                        new SqlParameter("@yh_amount", SqlDbType.Decimal),
                        new SqlParameter("@wh_amount", SqlDbType.Decimal),
                        new SqlParameter("@zy_amount", SqlDbType.Decimal),
                        new SqlParameter("@cq_amount", SqlDbType.Decimal),
                        new SqlParameter("@can_amount", SqlDbType.Decimal),
                        new SqlParameter("@month", SqlDbType.Int,4),
                        new SqlParameter("@member_amount", SqlDbType.Decimal),
                        new SqlParameter("@chanye", SqlDbType.NVarChar,50),
                        new SqlParameter("@remark", SqlDbType.NVarChar),
					    new SqlParameter("@id", SqlDbType.Int,4)};
                        parameters[0].Value = model.name;
                        parameters[1].Value = model.level;
                        parameters[2].Value = model.gender;
                        parameters[3].Value = model.tel;
                        parameters[4].Value = model.id_card;
                        parameters[5].Value = model.member_no;
                        parameters[6].Value = model.amount;
                        parameters[7].Value = model.purpose;
                        parameters[8].Value = model.lb_person;
                        parameters[9].Value = model.add_time;
                        parameters[10].Value = model.audit_time;
                        parameters[11].Value = model.member_id;
                        parameters[12].Value = model.lb_person_names;
                        parameters[13].Value = model.status;
                        parameters[14].Value = model.hk_status;
                        parameters[15].Value = model.reason;
                        parameters[16].Value = model.yh_amount;
                        parameters[17].Value = model.wh_amount;
                        parameters[18].Value = model.zy_amount;
                        parameters[19].Value = model.cq_amount;
                        parameters[20].Value = model.can_amount;
                        parameters[21].Value = model.month;
                        parameters[22].Value = model.member_amount;
                        parameters[23].Value = model.chanye;
                        parameters[24].Value = model.remark;
                        parameters[25].Value = model.id;
                        DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
                        #endregion

                        #region 修改图片相册==========================
                        //删除已删除的图片
                        new daikuan_albums().DeleteList(conn, trans, model.albums, model.id);
                        //添加/修改相册
                        if (model.albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.daikuan_albums modelt in model.albums)
                            {
                                strSql3 = new StringBuilder();
                                if (modelt.id > 0)
                                {
                                    strSql3.Append("update daikuan_albums set ");
                                    strSql3.Append("daikuan_id=@daikuan_id,");
                                    strSql3.Append("thumb_path=@thumb_path,");
                                    strSql3.Append("original_path=@original_path,");
                                    strSql3.Append("remark=@remark,");
                                    strSql3.Append("link_url=@link_url");
                                    strSql3.Append(" where id=@id");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@daikuan_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200),
                                            new SqlParameter("@id", SqlDbType.Int,4)};
                                    parameters3[0].Value = modelt.daikuan_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    parameters3[5].Value = modelt.id;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                                else
                                {
                                    strSql3.Append("insert into daikuan_albums(");
                                    strSql3.Append("daikuan_id,thumb_path,original_path,remark,link_url)");
                                    strSql3.Append(" values (");
                                    strSql3.Append("@daikuan_id,@thumb_path,@original_path,@remark,@link_url)");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@daikuan_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200)};
                                    parameters3[0].Value = modelt.daikuan_id;
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
            strSql.Append("delete from daikuan ");
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
            strSql.Append("delete from daikuan ");
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
        public Model.daikuan GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 * from daikuan");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            Model.daikuan model = new Model.daikuan();
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
        public Model.daikuan DataRowToModel(DataRow row)
        {
            Model.daikuan model = new Model.daikuan();
            if (row != null)
            {
                if (row["status"] != null && row["status"].ToString() != "")
                {
                    model.status = int.Parse(row["status"].ToString());
                }
                if (row["id"] != null && row["id"].ToString() != "")
                {
                    model.id = int.Parse(row["id"].ToString());
                }
                if (row["member_id"] != null && row["member_id"].ToString() != "")
                {
                    model.member_id = int.Parse(row["member_id"].ToString());
                }
                if (row["name"] != null)
                {
                    model.name = row["name"].ToString();
                }
                if (row["level"] != null)
                {
                    model.level = row["level"].ToString();
                }
                if (row["gender"] != null)
                {
                    model.gender = row["gender"].ToString();
                }
                if (row["tel"] != null)
                {
                    model.tel = row["tel"].ToString();
                }
                if (row["id_card"] != null)
                {
                    model.id_card = row["id_card"].ToString();
                }
                if (row["member_no"] != null)
                {
                    model.member_no = row["member_no"].ToString();
                }
                if (row["amount"] != null && row["amount"].ToString() != "")
                {
                    model.amount = decimal.Parse(row["amount"].ToString());
                }
                if (row["member_amount"] != null && row["member_amount"].ToString() != "")
                {
                    model.member_amount = decimal.Parse(row["member_amount"].ToString());
                }
                if (row["month"] != null && row["month"].ToString() != "")
                {
                    model.month = int.Parse(row["month"].ToString());
                }
                if (row["can_amount"] != null && row["can_amount"].ToString() != "")
                {
                    model.can_amount = decimal.Parse(row["can_amount"].ToString());
                }
                if (row["purpose"] != null)
                {
                    model.purpose = row["purpose"].ToString();
                }
                if (row["lb_person"] != null)
                {
                    model.lb_person = row["lb_person"].ToString();
                }
                if (row["lb_person_names"] != null)
                {
                    model.lb_person_names = row["lb_person_names"].ToString();
                }
                if (row["add_time"] != null && row["add_time"].ToString() != "")
                {
                    model.add_time = DateTime.Parse(row["add_time"].ToString());
                }
                if (row["audit_time"] != null && row["audit_time"].ToString() != "")
                {
                    model.audit_time = DateTime.Parse(row["audit_time"].ToString());
                }
                if (row["reason"] != null)
                {
                    model.reason = row["reason"].ToString();
                }
                if (row["hk_status"] != null && row["hk_status"].ToString() != "")
                {
                    model.hk_status = int.Parse(row["hk_status"].ToString());
                }
                if (row["yh_amount"] != null)
                {
                    model.yh_amount = Utils.StrToDecimal(row["yh_amount"].ToString(), 0);
                }
                if (row["wh_amount"] != null)
                {
                    model.wh_amount = Utils.StrToDecimal(row["wh_amount"].ToString(), 0);
                }
                if (row["zy_amount"] != null)
                {
                    model.zy_amount = Utils.StrToDecimal(row["zy_amount"].ToString(), 0);
                }
                if (row["cq_amount"] != null)
                {
                    model.cq_amount = Utils.StrToDecimal(row["cq_amount"].ToString(), 0);
                }
                if (row["chanye"] != null)
                {
                    model.chanye = row["chanye"].ToString();
                }
                if (row["remark"] != null)
                {
                    model.remark = row["remark"].ToString();
                }
                //相册信息
                model.albums = new daikuan_albums().GetList(model.id, 0);
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
            strSql.Append(" FROM daikuan ");
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
            strSql.Append(" FROM daikuan ");
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
            strSql.Append("select * FROM daikuan");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            recordCount = Convert.ToInt32(DbHelperSQL.GetSingle(PagingHelper.CreateCountingSql(strSql.ToString())));
            return DbHelperSQL.Query(PagingHelper.CreatePagingSql(recordCount, pageSize, pageIndex, strSql.ToString(), filedOrder));
        }

        /// <summary>
        /// 获得查询分页数据
        /// </summary>
        public DataSet GetWarnList(int pageSize, int pageIndex, string strWhere, string filedOrder, out int recordCount)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select *,DATEDIFF(day, getdate(),(DATEADD(month,[month],audit_time))) day FROM daikuan");
            if (strWhere.Trim() != "")
            {
                strSql.Append(" where " + strWhere);
            }
            recordCount = Convert.ToInt32(DbHelperSQL.GetSingle(PagingHelper.CreateCountingSql(strSql.ToString())));
            return DbHelperSQL.Query(PagingHelper.CreatePagingSql(recordCount, pageSize, pageIndex, strSql.ToString(), filedOrder));
        }

        /// <summary>
        /// 获得查询分页数据
        /// </summary>
        public DataSet GetMemberList(int pageSize, int pageIndex, string strWhere, string filedOrder, out int recordCount)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT member_id,name,member_no,gender,member_amount,SUM(amount) sum_amount,SUM(yh_amount) sum_yh_amount,SUM(wh_amount) sum_wh_amount,SUM(zy_amount) sum_zy_amount,status FROM dbo.daikuan");
            strSql.Append(" WHERE status=1 GROUP BY member_id,name,gender,member_no,member_amount,status");
            recordCount = Convert.ToInt32(DbHelperSQL.GetSingle(PagingHelper.CreateCountingSql(strSql.ToString())));
            return DbHelperSQL.Query(PagingHelper.CreatePagingSql(recordCount, pageSize, pageIndex, strSql.ToString(), filedOrder));
        }

        /// <summary>
        /// 获取记录总数
        /// </summary>
        public int GetRecordCount(string strWhere)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) FROM daikuan ");
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
            strSql.Append(")AS Row, T.*  from daikuan T ");
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
            strSql.Append("update daikuan set " + strValue);
            strSql.Append(" where id=" + id);
            DbHelperSQL.ExecuteSql(strSql.ToString());
        }

        /// <summary>
        /// 是否还清借款
        /// </summary>
        public int IsPayOff(int member_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT SUM(wh_amount) sum_wh_amount FROM dbo.daikuan ");
            strSql.Append("WHERE status=1 AND member_id= " + member_id);
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
        /// 联保人是否还清借款
        /// </summary>
        public int IsLBPayOff(int member_id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("SELECT SUM(wh_amount) sum_wh_amount FROM dbo.daikuan ");
            strSql.Append("WHERE CONVERT(NVARCHAR(50),member_id) IN ");
            strSql.Append("(select * from dbo.f_split((select TOP 1 lb_person from daikuan where member_id=" + member_id + "),','))");
            strSql.Append("AND dbo.daikuan.status=1 ");
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
            parameters[0].Value = "daikuan";
            parameters[1].Value = "id";
            parameters[2].Value = PageSize;
            parameters[3].Value = PageIndex;
            parameters[4].Value = 0;
            parameters[5].Value = 0;
            parameters[6].Value = strWhere;	
            return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
        }*/

        #endregion  BasicMethod


    }
}

