using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DTcms.Web.admin.article
{
    /// <summary>
    /// 会员
    /// </summary>
    public class StatisEntity
    {
        /// <summary>
        /// .Ctor
        /// </summary>
        public StatisEntity()
        {

        }

        private string towm;

        /// <summary>
        /// 所属乡镇
        /// </summary>
        public string Town
        {
            get { return towm; }
            set { towm = value; }
        }

        private string village;

        /// <summary>
        /// 所属村
        /// </summary>
        public string Village
        {
            get { return village; }
            set { village = value; }
        }

        private string xiehui;

        /// <summary>
        /// 协会名称
        /// </summary>
        public string XieHui
        {
            get { return xiehui; }
            set { xiehui = value; }
        }

        private string bSubjcet;

        /// <summary>
        /// 科目大类
        /// </summary>
        public string BBSubjcet
        {
            get { return bSubjcet; }
            set { bSubjcet = value; }
        }

        private string sSbuject;

        /// <summary>
        /// 科目小类
        /// </summary>
        public string SSbuject
        {
            get { return sSbuject; }
            set { sSbuject = value; }
        }

        private string amount;

        /// <summary>
        /// 初期余额
        /// </summary>
        public string Amount
        {
            get { return amount; }
            set { amount = value; }
        }

        private string bqJie;

        /// <summary>
        /// 本期发生-借
        /// </summary>
        public string BQJie
        {
            get { return bqJie; }
            set { bqJie = value; }
        }

        private string bqDai;

        /// <summary>
        /// 本期发生-贷
        /// </summary>
        public string BQDai
        {
            get { return bqDai; }
            set { bqDai = value; }
        }

        private string qmJie;
        /// <summary>
        /// 期末余额-借
        /// </summary>
        public string QmAmount
        {
            get { return qmJie; }
            set { qmJie = value; }
        }

        private string qmDai;

        /// <summary>
        /// 期末余额-贷
        /// </summary>
        public string QmDai
        {
            get { return qmDai; }
            set { qmDai = value; }
        }

        private string yhck;

        /// <summary>
        /// 银行存款
        /// </summary>
        public string YHCK
        {
            get { return yhck; }
            set { yhck = value; }
        }

        private string xianjin;

        /// <summary>
        /// 现金
        /// </summary>
        public string XianJin
        {
            get { return xianjin; }
            set { xianjin = value; }
        }

        private string jchzj;

        /// <summary>
        ///  借出互助金
        /// </summary>
        public string JCHZJ
        {
            get { return jchzj; }
            set { jchzj = value; }
        }

        private string zcxj;

        /// <summary>
        /// 资产小计
        /// </summary>
        public string ZCXJ
        {
            get { return zcxj; }
            set { zcxj = value; }
        }

        private string jczb;

        /// <summary>
        /// 借出互助金资金占比率
        /// </summary>
        public string JCZB
        {
            get { return jczb; }
            set { jczb = value; }
        }

        private string rhhz;

        /// <summary>
        /// 会员入会互助金
        /// </summary>
        public string RHHZ
        {
            get { return rhhz; }
            set { rhhz = value; }
        }

        private string rhhzj;

        /// <summary>
        ///  会员入会互助金
        /// </summary>
        public string 会员入会互助金
        {
            get { return rhhzj; }
            set { rhhzj = value; }
        }

        private string zfhzj;

        /// <summary>
        /// 政府拨入互助资金
        /// </summary>
        public string ZFHZJ
        {
            get { return zfhzj; }
            set { zfhzj = value; }
        }

        private string fzxj;

        /// <summary>
        /// 负债小计
        /// </summary>
        public string FZXJ
        {
            get { return fzxj; }
            set { fzxj = value; }
        }

        private string jzc;

        /// <summary>
        /// 净资产
        /// </summary>
        public string JZC
        {
            get { return jzc; }
            set { jzc = value; }
        }

        private string zfbz;

        /// <summary>
        /// 政府补助收入
        /// </summary>
        public string ZFBZ
        {
            get { return zfbz; }
            set { zfbz = value; }
        }

        private string jczy;

        /// <summary>
        /// 借出互助资金占用费收入
        /// </summary>
        public string JCZY
        {
            get { return jczy; }
            set { jczy = value; }
        }

        private string ywgl;
        /// <summary>
        /// 业务管理收入
        /// </summary>
        public string YWGL
        {
            get { return ywgl; }
            set { ywgl = value; }
        }

        private string gyj;

        /// <summary>
        /// 公益金
        /// </summary>
        public string GYJ
        {
            get { return gyj; }
            set { gyj = value; }
        }

        private string srxj;

        /// <summary>
        /// 收入小计
        /// </summary>
        public string SRXJ
        {
            get { return srxj; }
            set { srxj = value; }
        }

        private string hdzc;
        /// <summary>
        /// 业务活动支出
        /// </summary>
        public string HDZC
        {
            get { return hdzc; }
            set { hdzc = value; }
        }

        private string bqjy;
        /// <summary>
        /// 净资产-本期结余
        /// </summary>
        public string BQJY
        {
            get { return bqjy; }
            set { bqjy = value; }
        }
    }
}
