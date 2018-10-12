<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>退会申请表</title>
    <link rel="stylesheet" href="css/global.css">
    <link rel="stylesheet" href="css/application.css">
    <script src="js/jquery-1.11.1.min.js"></script>
</head>
<body>
    <div id="bodyer">
        <h1 class="center margin-b-20">陕西省汉阴县
            <select name="town" class="town">
                <option>请选择</option>
            </select>镇
            <select name="village" class="village">
                <option>请选择</option>
            </select>村扶贫互助资金协会退会申请表
        </h1>
        <div class="display-i-b pct-w50 margin-b-20">
                申请人家庭地址：<select>
                    <option>请选择</option>
                </select> 镇
                <select>
                    <option>请选择</option>
                </select>村
                <select>
                    <option>请选择</option>
                </select>组 
        </div><div class="display-i-b pct-w50 margin-b-20">
                会员证编号：<input type="text"> 
        </div>
        <div class="display-i-b pct-w20 margin-b-20">
            姓名：<input type="text">
        </div><div class="display-i-b pct-w20 margin-b-20">
                性别：<input type="text">
        </div><div class="display-i-b pct-w20 margin-b-20">
                    出生年月：<input type="date">
        </div><div class="display-i-b pct-w20 margin-b-20">
                        文化程度：<input type="text">
        </div><div class="display-i-b pct-w20 margin-b-20">
            身份证编号：<input type="text">
        </div>
        <div class="margin-b-20">
            退会金额（元）：<input type="text">
        </div>
        <div class="center margin-b-20">
            <h2>家庭主要成员</h2>
        </div>
        <div class="margin-b-20">
                对所选信息操作
                <input type="button" value="新建" class="xinjian">
                <input type="button" value="删除" class="shanchu">
        </div>
        <div class="member margin-b-20">
        <div class="margin-b-20">
            <div class="display-i-b pct-w5">
                <input type="checkbox" name="member">
            </div><div class="display-i-b pct-w19">
                    姓名：<input type="text">
                </div><div class="display-i-b pct-w19">
                        性别：<input type="text">
                </div><div class="display-i-b pct-w19">
                        与申请人关系：<input type="text">
                </div><div class="display-i-b pct-w19">
                        出生年月：<input type="date">
                </div><div class="display-i-b pct-w19">
                        文化程度：<input type="text">
                </div>
        </div>
        <div class="margin-b-20">
                <div class="display-i-b pct-w5">
                    <input type="checkbox" name="member">
                </div><div class="display-i-b pct-w19">
                        姓名：<input type="text">
                    </div><div class="display-i-b pct-w19">
                            性别：<input type="text">
                    </div><div class="display-i-b pct-w19">
                            与申请人关系：<input type="text">
                    </div><div class="display-i-b pct-w19">
                            出生年月：<input type="date">
                    </div><div class="display-i-b pct-w19">
                            文化程度：<input type="text">
                    </div>
            </div>
        </div>
            <div class="shenqin clearfix margin-b-20">
                    <div class="display-i-b pct-w20 s1 left">
                                    申请人申明
                    </div>
                    <div class="display-i-b pct-w80 s2 left">
                        <p>经过慎重考虑，本人自愿退出<select name="" id=""><option value="">请选择</option></select> 村互助资金协会，不再享受协会会员的一切权利，前期的贷款全部还清，现申请退费。
                        </p>
                        <div class="clearfix">
                                <p class="right margin-b-20">申请人：<input type="text"></p>
                        </div>
                        <p class="right">申请时间：<input type="date"></p>
                    </div>
                </div>
                <div class="shenqin clearfix margin-b-40">
                        <div class="display-i-b pct-w20 s1 left">
                                        协会意见
                        </div>
                        <div class="display-i-b pct-w40 s2 left">
                            <p class="center margin-b-40">会计签章：</p>
                            <p class="center"> 批准时间：<input type="date"></p>
                        </div>
                        <div class="display-i-b pct-w40 s2 left">
                            <p class="center margin-b-10">协会公章：</p>
                            <p class="center margin-b-10">会计签章：</p>
                            <p class="center"> 批准时间：<input type="date"></p>
                        </div>
                    </div>
                    <div class="center">
                        <input type="button" value="提交" class="submit">
                    </div>
        
    </div>
    <script>
        $(function(){
            var html='<div class="margin-b-20"><div class="display-i-b pct-w5"><input type="checkbox" name="member"></div><div class="display-i-b pct-w19">姓名：<input type="text"></div><div class="display-i-b pct-w19">性别：<input type="text"></div><div class="display-i-b pct-w19">与申请人关系：<input type="text"></div><div class="display-i-b pct-w19">出生年月：<input type="date"></div><div class="display-i-b pct-w19">文化程度：<input type="text"></div></div>';
            $(".xinjian").on("click",function(){
                $(".member").append(html);
            })
            $(".shanchu").click(function(){
                $("input[name='member']:checked").each(function(){
                    $(this).parent().parent().remove();
                })
            })
        })
    </script>
</body>
</html>