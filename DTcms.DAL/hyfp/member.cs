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
    /// 数据访问类:member
    /// </summary>
    public partial class member
    {
        public member()
        { }
        #region  BasicMethod

        /// <summary>
        /// 得到最大ID
        /// </summary>
        public int GetMaxId()
        {
            return DbHelperSQL.GetMaxID("id", "member");
        }

        /// <summary>
        /// 是否存在该记录
        /// </summary>
        public bool Exists(int id)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select count(1) from member");
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
            strSql.Append("select count(1) from member");
            strSql.Append(" where no=@no ");
            SqlParameter[] parameters = {
					new SqlParameter("@no", SqlDbType.NVarChar,50)			};
            parameters[0].Value = no;

            return DbHelperSQL.Exists(strSql.ToString(), parameters);
        }


        /// <summary>
        /// 增加一条数据
        /// </summary>
        public int Add(Model.member model)
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
                        strSql.Append("insert into member(");
                        strSql.Append("no,name,gender,type,level,id_card,tel,town,village,amount,can_amount,date,remark,yh_amount,peigu,add_time,is_delete,img_url,address,birthday,education,shenqingbiao,pingzheng,shenfenzheng)");
                        strSql.Append(" values (");
                        strSql.Append("@no,@name,@gender,@type,@level,@id_card,@tel,@town,@village,@amount,@can_amount,@date,@remark,@yh_amount,@peigu,@add_time,@is_delete,@img_url,@address,@birthday,@education,@shenqingbiao,@pingzheng,@shenfenzheng)");
                        strSql.Append(";select @@IDENTITY");
                        SqlParameter[] parameters = {
					            new SqlParameter("@no", SqlDbType.NVarChar,50),
					            new SqlParameter("@name", SqlDbType.NVarChar,50),
					            new SqlParameter("@gender", SqlDbType.NVarChar,50),
					            new SqlParameter("@type", SqlDbType.NVarChar,50),
                                new SqlParameter("@level", SqlDbType.NVarChar,50),
					            new SqlParameter("@id_card", SqlDbType.NVarChar,50),
					            new SqlParameter("@tel", SqlDbType.NVarChar,50),
                                new SqlParameter("@town", SqlDbType.NVarChar,50),
					            new SqlParameter("@village", SqlDbType.NVarChar,50),
					            new SqlParameter("@amount", SqlDbType.Decimal,9),
					            new SqlParameter("@can_amount", SqlDbType.Decimal,9),
					            new SqlParameter("@date", SqlDbType.DateTime),
					            new SqlParameter("@remark", SqlDbType.NVarChar,200),
					            new SqlParameter("@yh_amount", SqlDbType.Decimal),
                                new SqlParameter("@peigu", SqlDbType.Decimal),
					            new SqlParameter("@add_time", SqlDbType.DateTime),
                                new SqlParameter("@is_delete", SqlDbType.Int,4),
                                new SqlParameter("@img_url", SqlDbType.NVarChar,50),
                                new SqlParameter("@address", SqlDbType.NVarChar,50),
                                new SqlParameter("@birthday", SqlDbType.NVarChar,50),
                                new SqlParameter("@education", SqlDbType.NVarChar,50),
                                new SqlParameter("@shenqingbiao", SqlDbType.NVarChar,50),
                                new SqlParameter("@pingzheng", SqlDbType.NVarChar,50),
                                new SqlParameter("@shenfenzheng", SqlDbType.NVarChar,50)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.name;
                        parameters[2].Value = model.gender;
                        parameters[3].Value = model.type;
                        parameters[4].Value = model.level;
                        parameters[5].Value = model.id_card;
                        parameters[6].Value = model.tel;
                        parameters[7].Value = model.town;
                        parameters[8].Value = model.village;
                        parameters[9].Value = model.amount;
                        parameters[10].Value = model.can_amount;
                        parameters[11].Value = model.date;
                        parameters[12].Value = model.remark;
                        parameters[13].Value = model.yh_amount;
                        parameters[14].Value = model.peigu;
                        parameters[15].Value = model.add_time;
                        parameters[16].Value = model.is_delete;
                        parameters[17].Value = model.img_url;
                        parameters[18].Value = model.address;
                        parameters[19].Value = model.birthday;
                        parameters[20].Value = model.education;
                        parameters[21].Value = model.shenqingbiao;
                        parameters[22].Value = model.pingzheng;
                        parameters[23].Value = model.shenfenzheng;
                        //添加主表数据
                        object obj = DbHelperSQL.GetSingle(conn, trans, strSql.ToString(), parameters); //带事务
                        model.id = Convert.ToInt32(obj);
                        #endregion

                        #region 添加图片相册====================
                        if (model.albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_albums modelt in model.albums)
                            {
                                strSql3 = new StringBuilder();
                                strSql3.Append("insert into member_albums(");
                                strSql3.Append("member_id,thumb_path,original_path,remark,link_url)");
                                strSql3.Append(" values (");
                                strSql3.Append("@member_id,@thumb_path,@original_path,@remark,@link_url)");
                                SqlParameter[] parameters3 = {
					                new SqlParameter("@member_id", SqlDbType.Int,4),
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

                        #region 添加财务凭证====================
                        if (model.cw_albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_cw_albums modelt in model.cw_albums)
                            {
                                strSql3 = new StringBuilder();
                                strSql3.Append("insert into member_cw_albums(");
                                strSql3.Append("member_id,thumb_path,original_path,remark,link_url)");
                                strSql3.Append(" values (");
                                strSql3.Append("@member_id,@thumb_path,@original_path,@remark,@link_url)");
                                SqlParameter[] parameters3 = {
					                new SqlParameter("@member_id", SqlDbType.Int,4),
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

                        #region 添加家庭成员====================
                        if (model.family != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_family modelt in model.family)
                            {
                                strSql3 = new StringBuilder();
                                strSql3.Append("insert into member_family(");
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
        public bool Update(Model.member model)
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
                        strSql.Append("update member set ");
                        strSql.Append("no=@no,");
                        strSql.Append("name=@name,");
                        strSql.Append("gender=@gender,");
                        strSql.Append("type=@type,");
                        strSql.Append("level=@level,");
                        strSql.Append("id_card=@id_card,");
                        strSql.Append("tel=@tel,");
                        strSql.Append("town=@town,");
                        strSql.Append("village=@village,");
                        strSql.Append("amount=@amount,");
                        strSql.Append("can_amount=@can_amount,");
                        strSql.Append("date=@date,");
                        strSql.Append("remark=@remark,");
                        strSql.Append("yh_amount=@yh_amount,");
                        strSql.Append("peigu=@peigu,");
                        strSql.Append("add_time=@add_time,");
                        strSql.Append("is_delete=@is_delete,");
                        strSql.Append("img_url=@img_url,");
                        strSql.Append("address=@address,");
                        strSql.Append("birthday=@birthday,");
                        strSql.Append("education=@education,");
                        strSql.Append("shenqingbiao=@shenqingbiao,");
                        strSql.Append("pingzheng=@pingzheng,");
                        strSql.Append("shenfenzheng=@shenfenzheng");
                        strSql.Append(" where id=@id ");
                        SqlParameter[] parameters = {
					        new SqlParameter("@no", SqlDbType.NVarChar,50),
					        new SqlParameter("@name", SqlDbType.NVarChar,50),
					        new SqlParameter("@gender", SqlDbType.NVarChar,50),
					        new SqlParameter("@type", SqlDbType.NVarChar,50),
                            new SqlParameter("@level", SqlDbType.NVarChar,50),
					        new SqlParameter("@id_card", SqlDbType.NVarChar,50),
					        new SqlParameter("@tel", SqlDbType.NVarChar,50),
                            new SqlParameter("@town", SqlDbType.NVarChar,50),
					        new SqlParameter("@village", SqlDbType.NVarChar,50),
					        new SqlParameter("@amount", SqlDbType.Decimal,9),
					        new SqlParameter("@can_amount", SqlDbType.Decimal,9),
					        new SqlParameter("@date", SqlDbType.DateTime),
					        new SqlParameter("@remark", SqlDbType.NVarChar,200),
					        new SqlParameter("@yh_amount", SqlDbType.Decimal),
                            new SqlParameter("@peigu", SqlDbType.Decimal),
					        new SqlParameter("@add_time", SqlDbType.DateTime),
                            new SqlParameter("@is_delete", SqlDbType.Int,4),
                            new SqlParameter("@img_url", SqlDbType.NVarChar,50),
                            new SqlParameter("@address", SqlDbType.NVarChar,50),
                            new SqlParameter("@birthday", SqlDbType.NVarChar,50),
                            new SqlParameter("@education", SqlDbType.NVarChar,50),
                            new SqlParameter("@shenqingbiao", SqlDbType.NVarChar,50),
                            new SqlParameter("@pingzheng", SqlDbType.NVarChar,50),
                            new SqlParameter("@shenfenzheng", SqlDbType.NVarChar,50),
					        new SqlParameter("@id", SqlDbType.Int,4)};
                        parameters[0].Value = model.no;
                        parameters[1].Value = model.name;
                        parameters[2].Value = model.gender;
                        parameters[3].Value = model.type;
                        parameters[4].Value = model.level;
                        parameters[5].Value = model.id_card;
                        parameters[6].Value = model.tel;
                        parameters[7].Value = model.town;
                        parameters[8].Value = model.village;
                        parameters[9].Value = model.amount;
                        parameters[10].Value = model.can_amount;
                        parameters[11].Value = model.date;
                        parameters[12].Value = model.remark;
                        parameters[13].Value = model.yh_amount;
                        parameters[14].Value = model.peigu;
                        parameters[15].Value = model.add_time;
                        parameters[16].Value = model.is_delete;
                        parameters[17].Value = model.img_url;
                        parameters[18].Value = model.address;
                        parameters[19].Value = model.birthday;
                        parameters[20].Value = model.education;
                        parameters[21].Value = model.shenqingbiao;
                        parameters[22].Value = model.pingzheng;
                        parameters[23].Value = model.shenfenzheng;
                        parameters[24].Value = model.id;
                        DbHelperSQL.ExecuteSql(conn, trans, strSql.ToString(), parameters);
                        #endregion

                        #region 修改图片相册==========================
                        //删除已删除的图片
                        new member_albums().DeleteList(conn, trans, model.albums, model.id);
                        //添加/修改相册
                        if (model.albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_albums modelt in model.albums)
                            {
                                strSql3 = new StringBuilder();
                                if (modelt.id > 0)
                                {
                                    strSql3.Append("update member_albums set ");
                                    strSql3.Append("member_id=@member_id,");
                                    strSql3.Append("thumb_path=@thumb_path,");
                                    strSql3.Append("original_path=@original_path,");
                                    strSql3.Append("remark=@remark,");
                                    strSql3.Append("link_url=@link_url");
                                    strSql3.Append(" where id=@id");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@member_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200),
                                            new SqlParameter("@id", SqlDbType.Int,4)};
                                    parameters3[0].Value = modelt.member_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    parameters3[5].Value = modelt.id;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                                else
                                {
                                    strSql3.Append("insert into member_albums(");
                                    strSql3.Append("member_id,thumb_path,original_path,remark,link_url)");
                                    strSql3.Append(" values (");
                                    strSql3.Append("@member_id,@thumb_path,@original_path,@remark,@link_url)");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@member_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200)};
                                    parameters3[0].Value = modelt.member_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                            }
                        }
                        #endregion

                        #region 修改图片相册==========================
                        //删除已删除的图片
                        new member_albums().DeleteList(conn, trans, model.albums, model.id);
                        //添加/修改相册
                        if (model.cw_albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_cw_albums modelt in model.cw_albums)
                            {
                                strSql3 = new StringBuilder();
                                if (modelt.id > 0)
                                {
                                    strSql3.Append("update member_cw_albums set ");
                                    strSql3.Append("member_id=@member_id,");
                                    strSql3.Append("thumb_path=@thumb_path,");
                                    strSql3.Append("original_path=@original_path,");
                                    strSql3.Append("remark=@remark,");
                                    strSql3.Append("link_url=@link_url");
                                    strSql3.Append(" where id=@id");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@member_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200),
                                            new SqlParameter("@id", SqlDbType.Int,4)};
                                    parameters3[0].Value = modelt.member_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    parameters3[5].Value = modelt.id;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                                else
                                {
                                    strSql3.Append("insert into member_cw_albums(");
                                    strSql3.Append("member_id,thumb_path,original_path,remark,link_url)");
                                    strSql3.Append(" values (");
                                    strSql3.Append("@member_id,@thumb_path,@original_path,@remark,@link_url)");
                                    SqlParameter[] parameters3 = {
					                        new SqlParameter("@member_id", SqlDbType.Int,4),
					                        new SqlParameter("@thumb_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@original_path", SqlDbType.NVarChar,255),
					                        new SqlParameter("@remark", SqlDbType.NVarChar,500),
                                            new SqlParameter("@link_url", SqlDbType.NVarChar,200)};
                                    parameters3[0].Value = modelt.member_id;
                                    parameters3[1].Value = modelt.thumb_path;
                                    parameters3[2].Value = modelt.original_path;
                                    parameters3[3].Value = modelt.remark;
                                    parameters3[4].Value = modelt.link_url;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                            }
                        }
                        #endregion

                        #region 修改家庭成员==========================
                        new member_family().DeleteList(conn, trans, model.family, model.id);
                        if (model.cw_albums != null)
                        {
                            StringBuilder strSql3;
                            foreach (Model.member_family modelt in model.family)
                            {
                                strSql3 = new StringBuilder();
                                if (modelt.id > 0)
                                {
                                    strSql3.Append("update member_family set ");
                                    strSql3.Append("member_id=@member_id,");
                                    strSql3.Append("name=@name,");
                                    strSql3.Append("gender=@gender,");
                                    strSql3.Append("relationship=@relationship,");
                                    strSql3.Append("birthday=@birthday,");
                                    strSql3.Append("education=@education");
                                    strSql3.Append(" where id=@id");
                                    SqlParameter[] parameters3 = {
					                       new SqlParameter("@member_id", SqlDbType.Int,4),
					                        new SqlParameter("@name", SqlDbType.NVarChar,50),
					                        new SqlParameter("@gender", SqlDbType.NVarChar,50),
					                        new SqlParameter("@relationship", SqlDbType.NVarChar,50),
                                            new SqlParameter("@birthday", SqlDbType.NVarChar,50),
                                            new SqlParameter("@education", SqlDbType.NVarChar,50),
                                            new SqlParameter("@id", SqlDbType.Int,4)};
                                    parameters3[0].Value = modelt.member_id;
                                    parameters3[1].Value = modelt.name;
                                    parameters3[2].Value = modelt.gender;
                                    parameters3[3].Value = modelt.relationship;
                                    parameters3[4].Value = modelt.birthday;
                                    parameters3[5].Value = modelt.education;
                                    parameters3[6].Value = modelt.id;
                                    DbHelperSQL.ExecuteSql(conn, trans, strSql3.ToString(), parameters3);
                                }
                                else
                                {
                                    strSql3 = new StringBuilder();
                                    strSql3.Append("insert into member_family(");
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
            strSql.Append("delete from member ");
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
            strSql.Append("delete from member ");
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
        public Model.member GetModel(int id)
        {

            StringBuilder strSql = new StringBuilder();
            strSql.Append("select  top 1 * from member ");
            strSql.Append(" where id=@id ");
            SqlParameter[] parameters = {
					new SqlParameter("@id", SqlDbType.Int,4)			};
            parameters[0].Value = id;

            Model.member model = new Model.member();
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
        public Model.member DataRowToModel(DataRow row)
        {
            Model.member model = new Model.member();
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
                if (row["name"] != null)
                {
                    model.name = row["name"].ToString();
                }
                if (row["gender"] != null)
                {
                    model.gender = row["gender"].ToString();
                }
                if (row["type"] != null)
                {
                    model.type = row["type"].ToString();
                }
                if (row["level"] != null)
                {
                    model.level = row["level"].ToString();
                }
                if (row["id_card"] != null)
                {
                    model.id_card = row["id_card"].ToString();
                }
                if (row["tel"] != null)
                {
                    model.tel = row["tel"].ToString();
                }
                if (row["town"] != null)
                {
                    model.town = row["town"].ToString();
                }
                if (row["village"] != null)
                {
                    model.village = row["village"].ToString();
                }
                if (row["amount"] != null && row["amount"].ToString() != "")
                {
                    model.amount = decimal.Parse(row["amount"].ToString());
                }
                if (row["can_amount"] != null && row["can_amount"].ToString() != "")
                {
                    model.can_amount = decimal.Parse(row["can_amount"].ToString());
                }
                if (row["date"] != null && row["date"].ToString() != "")
                {
                    model.date = DateTime.Parse(row["date"].ToString());
                }
                if (row["remark"] != null)
                {
                    model.remark = row["remark"].ToString();
                }
                if (row["yh_amount"] != null && row["yh_amount"].ToString() != "")
                {
                    model.yh_amount = decimal.Parse(row["yh_amount"].ToString());
                }
                if (row["peigu"] != null && row["peigu"].ToString() != "")
                {
                    model.peigu = decimal.Parse(row["peigu"].ToString());
                }
                if (row["add_time"] != null && row["add_time"].ToString() != "")
                {
                    model.add_time = DateTime.Parse(row["add_time"].ToString());
                }
                if (row["img_url"] != null)
                {
                    model.img_url = row["img_url"].ToString();
                }
                if (row["address"] != null)
                {
                    model.address = row["address"].ToString();
                }
                if (row["birthday"] != null)
                {
                    model.birthday = row["birthday"].ToString();
                }
                if (row["education"] != null)
                {
                    model.education = row["education"].ToString();
                }
                if (row["shenqingbiao"] != null)
                {
                    model.shenqingbiao = row["shenqingbiao"].ToString();
                }
                if (row["pingzheng"] != null)
                {
                    model.pingzheng = row["pingzheng"].ToString();
                }
                if (row["shenfenzheng"] != null)
                {
                    model.shenfenzheng = row["shenfenzheng"].ToString();
                }

                //附件信息
                model.albums = new member_albums().GetList(model.id, 0);

                model.cw_albums = new member_cw_albums().GetList(model.id, 0);

                model.family = new member_family().GetList(model.id, 0);
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
            strSql.Append(" FROM member ");
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
            strSql.Append(" FROM member ");
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
            strSql.Append("select * FROM member");
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
            strSql.Append("select count(1) FROM member ");
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
            strSql.Append(")AS Row, T.*  from member T ");
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
            strSql.Append("update member set " + strValue);
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
            parameters[0].Value = "member";
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
            strSql.Append("select type,count(*) count from member ");
            strSql.Append("group by type ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 统计金银蓝卡会员
        /// </summary>
        public DataSet GetListByLevel()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select level,count(*) count from member ");
            strSql.Append("group by level ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        /// <summary>
        /// 统计各镇会员
        /// </summary>
        public DataSet GetListByTown()
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append("select town,count(*) count from member ");
            strSql.Append("group by town ");
            return DbHelperSQL.Query(strSql.ToString());
        }

        #endregion  BasicMethod
        #region  ExtensionMethod

        #endregion  ExtensionMethod
    }
}

