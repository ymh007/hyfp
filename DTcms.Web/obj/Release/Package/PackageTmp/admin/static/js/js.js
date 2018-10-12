//公共对象
var WinW = $(window).width();
var WinH = $(window).height();

// 弹窗
function shade(Clickname, _width, _height, $h,starFun, _fun) {
	// 设置遮罩层高度
	$(".shade_zz").height(WinH);
	// 创建遮罩层
	var shadeZzLen = $(".shade_zz none").length;
	if (shadeZzLen == 0) {
		$("body").append("<div class='shade_zz'></div>");
	}
	// 创建弹窗
	var Len = $(".shade").length;
	if (Len == 0) {
		$("body")
				.append(
						"<div class='shade'><div class='shade_off'></div><div class='clear'></div><div class='shade_main'></div></div>");
	}
	// 点击事件
	Clickname.click(function() {
		$(".shade_main").html("");
		
		if(starFun()){
			// 弹窗设置
			$(".shade").css({
				width : _width,
				height : _height
			})
			var SLeft = (WinW - _width) / 2;
			var STop = (WinH - _height) / 2;
			$(".shade").css({
				left : SLeft,
				top : STop
			})
			// 初始化弹窗
			var $_html = $h;
			$h.remove();
			$(".shade_zz").show();
			$(".shade_main").append($_html.html());
			$(".shade").fadeIn(300);
			$_html.show();
			// 返回函数
			_fun();
			
		}
	})
	// 关闭按钮
	$(".shade_off").click(function() {
		$(".shade_zz").hide();
		$(".shade").fadeOut(300);
	})

}
// 图片上传预览 IE是用了滤镜。
function previewImage(file,IdName) {
	var MAXWIDTH = 260;
	var MAXHEIGHT = 180;
	var div = document.getElementById('preview');
	if (file.files && file.files[0]) {
		var img = document.getElementById(IdName);
		var reader = new FileReader();
		reader.onload = function(evt) {
			img.src = evt.target.result;
		}
		var of = $(file);
		var name = of[0].name;
		var action = $('#uploadForm')[0].action;
		var formData=new FormData();
		$.each($(file)[0].files, function(i, file) {
			formData.append('uploadFile', file);
		});
		$.ajax({
			url:action,
			type:'POST',
			data:formData,
			cache: false,
			async:false,
        	contentType: false,    //不可缺
        	processData: false,    //不可缺
        	dataType: "text",
         	success:function(data){
            	// 此处可对 data作相关处理
     			of.attr("name", name);
     			console.log(data);
     			$("#" + name).val(data);
         	},
         	error:function(data){
         		console.log(data);
         	}
		});
		reader.readAsDataURL(file.files[0]);
	} else // 兼容IE
	{
		var sFilter = 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
		file.select();
		var src = document.selection.createRange().text;
		div.innerHTML = '<img id=imghead>';
		var img = document.getElementById('imghead');
		img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
		var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth,
				img.offsetHeight);
		status = ('rect:' + rect.top + ',' + rect.left + ',' + rect.width + ',' + rect.height);
		div.innerHTML = "<div id=divhead style='width:" + rect.width
				+ "px;height:" + rect.height + "px;margin-top:" + rect.top
				+ "px;" + sFilter + src + "\"'></div>";
	}
}
//验证
var f = 0;
var VFfun = function ($this, VFtype, passwordId) {
	f = 0;
    $this = $($this);
    var VFValue = $this.val();
    var TypeVal = VFtype;

    //创建提示层
    var fatherDome = $this.parent("div");
    fatherDome.addClass("pos_rel");
    var VFLen = fatherDome.find(".VFDome").length;
    if (VFLen != 1) {
        fatherDome.append('<div class="VFDome"><img src="/r/cms/www/default/images/cw.png" /><span></span></div>')
    }
    //正则表达式
    var iphone = /^1\d{10}$/;
    var em = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;

    //邮箱或手机
    if (TypeVal == "iphoneAndEm") {

        fatherDome.find(".VFDome span").text("邮箱格式不正确");

        if (iphone.test(VFValue) || em.test(VFValue)) {
            fatherDome.find(".VFDome").hide();
        } else {
            fatherDome.find(".VFDome").show();
        }
    }
    //手机
    if (TypeVal == "Iphone") {

        fatherDome.find(".VFDome span").text("手机号格式不正确");

        if (iphone.test(VFValue)) {
            fatherDome.find(".VFDome").hide();
        } else {
            fatherDome.find(".VFDome").show();
        }
    }
    //邮箱
    if (TypeVal == "Em") {

        fatherDome.find(".VFDome span").text("邮箱格式不正确");

        if (em.test(VFValue)) {
            fatherDome.find(".VFDome").hide();
        } else {
            fatherDome.find(".VFDome").show();
        }
    }
    //非空
    if (TypeVal == "kong") {

        fatherDome.find(".VFDome span").text("不能为空");

        if (VFValue != "") {
            fatherDome.find(".VFDome").hide();
        } else {
            fatherDome.find(".VFDome").show();
        }
    }
    if (TypeVal == "password") {

        if (VFValue != "") {
            var czVal = $("#" + passwordId).val();
            if (VFValue != czVal) {
                fatherDome.find(".VFDome span").text("密码不一致");
                fatherDome.find(".VFDome").show();
            } else {
                fatherDome.find(".VFDome").hide();
            }
        } else {
            fatherDome.find(".VFDome span").text("不能为空");
            fatherDome.find(".VFDome").show();
        }
    }
    //位置设置
    var leftZ = $this.attr("left");
    var topZ = $this.attr("top");
    if (leftZ) {
        fatherDome.find(".VFDome").css("right", leftZ);
    }
    if (topZ) {
        fatherDome.find(".VFDome").css("top", topZ);
    }
    //自检
    var FatherDiv = $this.parents(".NewZC_main");
    if (!FatherDiv.html()) {
        FatherDiv = $this.parents(".shade_main");
    }
    var Len = FatherDiv.find("input").length;
    for (var on = 0; on <= Len; on++) {
        var Discss = FatherDiv.find(".VFDome:eq(" + on + ")").css("display");
        if (Discss == "block") {
            f++;
        }
    };
    if (f >= 1) {
        FatherDiv.find(".Llogo_submit").attr("disabled", true);
        FatherDiv.find(".Llogo_submit").addClass("VFDomeBck");
    } else {
    	FatherDiv.find(".Llogo_submit").attr("disabled", false);
        FatherDiv.find(".Llogo_submit").removeClass("VFDomeBck");
    }

}
var j = 0;
var Submit_update = function ($this) {
	j = 0;
    $this = $($this);
    var FatherDiv;
    var ThisVal = $this.val();
    if (ThisVal == "登录"||ThisVal == "确认") {
        FatherDiv = $this.parents(".shade_main");
    } else {
        FatherDiv = $this.parents(".Llogo_zc_main");
    }
    FatherDiv.find("input").trigger("blur");
    FatherDiv.find("textarea").trigger("blur");
    var Len = FatherDiv.find("input").length;
    for (var on = 0; on <= Len; on++) {
        var Discss = FatherDiv.find(".VFDome:eq(" + on + ")").css("display");
        if (Discss == "block") {
            j++;
        }
    };
    
    if (j > 0 ) {
        $this.attr("disabled", true);
        $this.addClass("VFDomeBck");
        return false
    } else {
        $this.removeClass("VFDomeBck");
        $this.attr("disabled",false);
        return true
    }
}
//监控是否触底
var scrollDown = function(_fun,_funTwo){
    $(document).scroll(function(){
        var OneH =  $("body").height()-$(window).height()-400;
        var SHeight = $(document).scrollTop()
        if(SHeight>=OneH){
            _fun();
        }else{
            _funTwo();
        }
    })
       
}
/*--切换--*/
var mouseChange = function (zhi,_divName) {
    $(".change_ju div").mouseenter(function(){
        var Index = $(this).index();
        var MoveTop = -zhi*Index;
        $(this).parents(".section").find("."+_divName).stop(false,true).animate({
            top:MoveTop
        },500);
        $(this).parent().find("div").removeClass("change_juHover");
        $(this).addClass("change_juHover");
    })
}
//自动缩小banner
var AutoBanner = function(){
	var ImgH = WinH - 126;
	var ImgHcenter = ImgH/2.85;
	var MoveT = -(ImgH-ImgHcenter)/2
	$(".lwh_banner_top").animate({
		height:ImgHcenter
	},500);
	$(".text_cen").animate({
		top:MoveT
	},500);
}
$(function(){
	$(function () {
	    /*---首页---*/
	    //banner
	    var On = 0;
	    $(".LindexBanner_right").click(function () {
	        var Len = $(".LindexBanner ul li").length;
	        if (On >= Len - 1) {
	            On = 0;
	        } else {
	            On++;
	        }
	        var MoveVal = -On * 600;
	        $(".LindexBanner ul").stop().animate({
	            left: MoveVal
	        }, 500);
	    });
	    $(".LindexBanner_left").click(function () {
	        var Len = $(".LindexBanner ul li").length;
	        if (On <= 0) {
	            On = Len - 1;
	        } else {
	            On--;
	        }
	        var MoveVal = -On * 600;
	        $(".LindexBanner ul").stop().animate({
	            left: MoveVal
	        }, 500);
	    });

	    var autoPalyOne = function () {
	        $(".LindexBanner_right").trigger("click");
	    }
	    setInterval(autoPalyOne, 4000);

	    //大勇动态切换
	    $(".DivTitleAll_change div").click(function () {
	        var Index = $(this).index();
	        $(this).parent("div").find("div").removeClass("DivTitleAll_hover");
	        $(this).addClass("DivTitleAll_hover");
	        $(this).parents(".w-1200").find(".LindexTop_center").hide();
	        $(this).parents(".w-1200").find(".LindexTop_center:eq(" + Index + ")").fadeIn(500);
	    })

	    //政策切换
	    $(".LIndexF1_rightDown_title div").click(function () {
	        var Index = $(this).index();
	        $(this).parents(".LIndexF1_rightDown").find(".LIndexF1_RDown_main").hide();
	        $(this).parents(".LIndexF1_rightDown").find(".LIndexF1_RDown_main:eq(" + Index + ")").fadeIn(500);
	        $(".LIndexF1_rightDown_title div").removeClass("LIndexF1_rightDown_titleHover");
	        $(this).addClass("LIndexF1_rightDown_titleHover");
	    })

	    //广告
	    var OnTow = 0;
	    var advertisAuto = function () {
	        var Len = $(".advertising").find("a").length;
	        if (OnTow >= Len - 1) {
	            OnTow = 0
	        } else {

	            OnTow++;
	        }
	        var MoveH = -OnTow * 100;
	        $(".advertising").animate({
	            top: MoveH
	        }, 500)
	    }
	    setInterval(advertisAuto, 4000);

	    //融资信息
	    $(".LindexF2_dome").mouseenter(function () {
	        $(this).find(".LindexF2_domeMore").stop().animate({
	            height: "175px"
	        }, 500);
	        $(this).find(".LindexF2_domeTitle").stop().animate({
	            marginTop: "55px"
	        }, 500);
	    });
	    $(".LindexF2_dome").mouseleave(function () {
	        $(this).find(".LindexF2_domeMore").stop().animate({
	            height: "45px"
	        }, 200);
	        $(this).find(".LindexF2_domeTitle").stop().animate({
	            marginTop: "10px"
	        }, 200);
	    });

	    //供应商
	    $(".LindexF3 ul li").mouseenter(function () {
	        $(this).addClass("LindexF3_show");
	        $(this).find(".LindexF3_showMainAll").stop().animate({
	            left: "0px"
	        }, 500);
	    })
	    $(".LindexF3 ul li").mouseleave(function () {
	        $(this).removeClass("LindexF3_show");
	        $(this).find(".LindexF3_showMainAll").stop().animate({
	            left: "230px"
	        }, 500);
	    })

	    $(".DivTitleAll4_change div").click(function () {
	        var Index = $(this).index();
	        var MoveTop = -Index * 230;
	        $(".LindexF3_all").animate({
	            top: MoveTop
	        }, 400);
	    })

	    //需求大厅
	    var OnThree = 0;
	    var LindexF4Auto = function () {
	        var Len = $(".LindexF4_all li").length;
	        if (OnThree >= Len - 3) {
	            OnThree = 0;
	        } else {
	            OnThree++;
	        }
	        var MoveLeft = -OnThree * 407;
	        $(".LindexF4_all").animate({
	            left: MoveLeft
	        }, 500)
	    }
	    setInterval(LindexF4Auto, 2000);

	    //展会动态
	    var OnFour = 0;
	    $(".LindexF6_change").click(function () {
	        var Len = $(".LindexF6 ul li").length;
	        if (OnFour >= Len - 1) {
	            OnFour = 0;
	        } else {
	            OnFour++;
	        }
	        var MoveLeft = -OnFour * 900;
	        $(".LindexF6 ul").animate({
	            left: MoveLeft
	        }, 500)
	    })

	    var LindexF6Auto = function () {
	        $(".LindexF6_change").trigger("click");
	    }
	    setInterval(LindexF6Auto, 4000);

	    //服务案例
	    $(".LindexF7_DomeSamll").mouseenter(function () {
	        $(this).find(".LindexF7_small").stop().animate({
	            height: "175px"
	        }, 400);
	        $(this).find(".LindexF7_small_main").stop().animate({
	            marginTop: "45px"
	        }, 400);
	    })
	    $(".LindexF7_DomeSamll").mouseleave(function () {
	        $(this).find(".LindexF7_small").stop().animate({
	            height: "40px"
	        }, 400);
	        $(this).find(".LindexF7_small_main").stop().animate({
	            marginTop: "10px"
	        }, 400);
	    })
	    $(".LindexF7_DomeBig").mouseenter(function () {
	        $(this).find(".LindexF7_small").stop().animate({
	            height: "365px"
	        }, 400);
	        $(this).find(".LindexF7_small_main").stop().animate({
	            marginTop: "100px"
	        }, 400);
	    })
	    $(".LindexF7_DomeBig").mouseleave(function () {
	        $(this).find(".LindexF7_small").stop().animate({
	            height: "50px"
	        }, 400);
	        $(this).find(".LindexF7_small_main").stop().animate({
	            marginTop: "15px"
	        }, 400);
	    })

	    //供应商banner
	    var OnFive = 0;
	    var headerPlay = function () {
	        var $On = arguments[0];
	        var MoveLeft = -$On * 800;
	        $(".headerBan").stop().animate({
	            left: MoveLeft
	        }, 500)

	        $(".headerBan_change div").removeClass("headerBan_hover");
	        $(".headerBan_change div:eq(" + $On + ")").addClass("headerBan_hover");

	    }
	    $(".headerBan_change div").mouseenter(function () {
	        var Index = $(this).index();
	        headerPlay(Index)
	    })
	    var headerAuto = function () {
	        var Len = $(".headerBan a").length;
	        if (OnFive >= Len - 1) {
	            OnFive = 0;
	        } else {
	            OnFive++;
	        }
	        headerPlay(OnFive);
	    }
	    setInterval(headerAuto, 4000);

	    //供应商 二级导航
	    $(".secondNav_Alink").click(function () {
	        $(".secondNav_Alink").removeClass("secondNav_AHover").find(".secondNav_a").animate({
	            width: "0px"
	        }, 300);
	        $(this).addClass("secondNav_AHover").find(".secondNav_a").animate({
	            width: "375px"
	        }, 300);
	    });

	    var OnSix = 0;
	    var secondAuto = function () {
	        var Len = $(".secondDown").length;
	        if (OnSix >= Len - 5) {
	            OnSix = 0;
	        } else {
	            OnSix++;
	        }
	        var MoveLeft = -OnSix * 201;
	        $(".secondDown_all").animate({
	            left: MoveLeft
	        }, 300);
	    }

	    setInterval(secondAuto, 3000);

	    //供应商 需求大厅
	    var OnSeven = 0;
	    var thirdlyAuto = function () {
	        var Len = $(".thirdly_main li").length;
	        if (OnSeven >= Len - 7) {
	            OnSeven = 0;
	        } else {
	            OnSeven++;
	        }
	        var MoveLeft = -OnSeven * 41;
	        $(".thirdly_main").animate({
	            top: MoveLeft
	        }, 300);
	    }
	    setInterval(thirdlyAuto, 3000);

	    //注册
	    $(".shade_title span").click(function () {
	    	$(".shade_title span").removeClass("shade_title_hover");
	    	$(this).addClass("shade_title_hover");
	        var Index = $(this).index();
	        $(".NewZC_main").hide();
	        $(".NewZC_main:eq("+Index+")").show();
	    })
	    
	    //分类二级菜单 
	    $(".thirdlyNav_a a").click(function(){
	    	$(".thirdlyNav_a a").removeClass("thirdlyNav_Hover");
	    	$(this).addClass("thirdlyNav_Hover");
	    	var Index = $(this).index();
	    	if(Index == 0){
	    		$(".thirdlyNav_more").slideUp(300);
	    	}else{
	    		$(".thirdlyNav_more").slideDown(300);
	    	}
	    	$("#moreBtn").attr("pageNo",1);
	    	pageLoad(true);
	    })
	    $(".listSort a").click(function(){
	    	$(".listSort a").removeClass("listSort_hover");
	    	$(this).addClass("listSort_hover");
	    	var TypeFx = $(this).find(".icon").attr("fx");
	    	var num = $(this).attr("num");
	    	$(".listSort a").find(".icon").removeClass("listSort_iconUp").attr("fx","up");
	    	if(TypeFx =="up"){
	    		$("#moreBtn").attr("num",num);
	    		$(this).find(".icon").removeClass("listSort_iconUp").attr("fx","down");
	    	}else{
	    		$("#moreBtn").attr("num",parseInt(num)+1);
	    		$(this).find(".icon").addClass("listSort_iconUp").attr("fx","up");
	    	}
    		$("#moreBtn").attr("pageNo",1);
    		pageLoad(true);
	    })
	    
	    //市场供需
	    $(".banner_left_main").mouseenter(function(){
	    	$(this).find(".banner_leftMore").stop().fadeIn(500);
	    })
	    $(".banner_left_main").mouseleave(function(){
	    	$(this).find(".banner_leftMore").stop().fadeOut(500);
	    })
	})
})