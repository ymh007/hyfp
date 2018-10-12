<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>会员借款审批表</title>
    <link rel="stylesheet" href="../skin/css/global.css">
    <link rel="stylesheet" href="../skin/css/application.css">
    <script src="../skin/js/jquery-1.11.1.min.js"></script>
</head>
<body>
    <div class="loan-1200">
        <h1 class="center margin-b-20">陕西省汉阴县
            <select name="village" class="village">
                <option>请选择</option>
            </select>村扶贫互助资金协会会员借款审批表
        </h1>
        <div class="text-r margin-b-20">
                <select id="agesye">
                        <option value="0">请选择年份</option>
                </select>年
        </div>
        <div class="display-i-b pct-w20 margin-b-20">
            姓名：<input type="text">
        </div><div class="display-i-b pct-w10 margin-b-20">
                <label>性别：</label>
                <label>男<input type="radio" name="radio" value="0"></label>
                <label>女<input type="radio" name="radio" value="1"></label>
            </div><div class="display-i-b pct-w10 margin-b-20 text-r">
                   年龄：<select id="ages">
                    <option value="0">请选择</option>
            </select>
        </div><div class="display-i-b pct-w20 margin-b-20 text-r">
                    配偶姓名：<input type="text">
        </div><div class="display-i-b pct-w20 margin-b-20 text-r">
                        继承人姓名：<input type="text">
        </div><div class="display-i-b pct-w20 margin-b-20 text-r">
            村组：<input type="text">
        </div>
        <div class="display-i-b pct-w50 margin-b-20">
            家庭年收入（元）<input type="text">
        </div><div class="display-i-b pct-w50 margin-b-20">
                借款用途（项目）：<input type="text">
              </div>
        <div class="display-i-b pct-w50 margin-b-20">
                    借款金额（元）<input type="text">
        </div><div class="display-i-b pct-w50 margin-b-20">
                        借款期限：<input type="date">至<input type="date">
              </div>


            <div class="shenqin clearfix margin-b-80 margin-t-40">
                <div class="display-i-b pct-w20  left height-auto">
                                会员借款申请
                </div>
                <div class="display-i-b pct-w80  left height-auto">
                    <p class="margin-b-10">村扶贫互助资金协会：</p>
                    <p class="margin-b-20">因我家要<input type="text" class="y-1">尚缺部分资金，将申请贷款<input type="text" class="y-2">元（大写：<input type="text" class="y-2">），并经第<input type="text" class="y-2">互助联保小组联保请村扶贫互助资金协会给予扶持。借款落实后，将按审定的资金用途使用，保证按期还借款本金及占用金，如到期不能及时偿还本金及占用费，我愿意承担法律责任并接受一切违约处罚。</p>
                    <p class="text-r padding-r-100 margin-b-20">申请人签字：</p>
                    <p class="text-r">时间：<input type="date"></p>
                </div>
            </div>
            <div class="shenqin clearfix margin-b-80">
                    <div class="display-i-b pct-w20  left height-auto">
                                    互助联保小组意见
                    </div>
                    <div class="display-i-b pct-w80  left height-auto">
                        <p class="margin-b-20">经本互助联保小组研究，同意借款，并由<input type="text" class="y-2">和<input type="text" class="y-2">担任第一，二位代偿人。</p>
                        <p class="text-r padding-r-100 margin-b-20">互助联保小组组长签字：</p>
                        <p class="text-r">时间：<input type="date"></p>
                    </div>
            </div>
            <div class="shenqin clearfix margin-b-80">
                    <div class="display-i-b pct-w20  left height-auto">
                                    协会理事会审批意见
                    </div>
                    <div class="display-i-b pct-w80  left height-auto">
                        <p class="text-r padding-r-100 margin-b-20">理事长签字（盖章）：</p>
                        <p class="text-r">时间：<input type="date"></p>
                    </div>
            </div>
            <div class="shenqin clearfix margin-b-20 margin-b-40">
                    <div class="display-i-b pct-w20  left height-auto">
                                    协会监视会审查意见
                    </div>
                    <div class="display-i-b pct-w80  left height-auto">
                        <p class="text-r padding-r-100 margin-b-20">监视会主任签字（盖章）：</p>
                        <p class="text-r">时间：<input type="date"></p>
                    </div>
            </div>
            <div class="color-red margin-b-40">
                注：此表由借款会员填写后交互助联保小组组长，互助联保小组签署意见后交村协会审批。
            </div>
                    <div class="center">
                        <input type="button" value="提交" class="submit">
                    </div>
        
    </div>
   <script>
   $(function(){
        var start = 1991; 
        var end = new Date().getFullYear(); 
        // console.log(new Date().getFullYear());
        for(i=start;i<=end;i++){
            $("#agesye").append("<option value="+i+">"+i+"</option>")
        };
        for(j=1;j<=150;j++){
            $("#ages").append("<option value="+j+">"+j+"</option>")
        }
   })
   </script>
</body>
</html>