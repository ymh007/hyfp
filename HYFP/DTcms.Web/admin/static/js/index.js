/**
 * Created by Administrator on 2016/8/19 0019.
 */
//菜单下拉
$(function() {
    //列表下拉出现的方式
    var lis = $(".list_one");
    var items=$(".li-xia");
    a={
        b0:1,b1:1,b2:1
    }
    lis.click(function () {
    	
        var n=($(this).index(".list_one"));
        if (a["b"+n]) {
            $(this).find(".ul_two").slideUp(500);
            $(this).find(items).css({transform:"rotate(90deg)"});
            a["b"+n]= 0;
        } else {
            $(this).find(".ul_two").slideDown(500);
            $(this).find(items).css({transform:"rotate(0deg)"});
            a["b"+n] = 1;
        }
    })
})

//hover属性
$(function(){
    var box=$(".box li");
    box.hover(
        function () {
            $(this).addClass("open");
        },function () {
            $(this).removeClass("open");
        }
    );
})
 


// 侧边栏 导航内容缩进效果 仅剩下图标
$(function(){
    var menu=$("#menu");
    var nav=$(".big");
    var name=$(".name_li");
    var flag=true;
    menu.click(function(){

        //图标旋转
        if(flag){
            $("#menu").css({transform:"rotate(90deg)",width: "35px",height:"35px"});
            flag=false;
        }else{
            $(this).css({transform:"rotate(0deg)",width: "100%"});
            flag=true;
        }

        var width=nav.css("width")=="180px"?true:false;
        if(width){
        	$(".slimScrollDiv").css({"width":"50px"});
            nav.css({"width":"50px"});
            $("#title").css({"display":"none"});
            $(".menu1 i").removeClass("left");
            $(".nav-right").css({"paddingLeft":"50px"});
            $(".ul_two li p").css({"display":"none"});
            $(".ul_two li").css({"paddingLeft":"0px"});
            $("#iframe_box").css({left:"40px"});
            $(".list_one").find(".li-xia").css({display:"none"});
            $(".list_one").find(".list_span").css({"display":"none"});
            $(".list_one").hover(function(){
                $(this).append(name);
                var height2=$(this).offset().top;
                var htmls=$(this).find(".list_span").html();
                name.css({display:"block",top:height2+"px"}).html(htmls);
            },function(){
                name.css({display:"none"})
            })
            $(".ul_two li").hover(function(){
                $(this).append(name);
                var htmls=$(this).find("a").html();
                var height2=$(this).offset().top;
                name.css({display:"block",top:height2+"px"}).html(htmls);
            },function(){name.css({display:"none"})})
        }else{
        	$(".slimScrollDiv").css({"width":"180px"});
            nav.css({"width":"180px"});
            $("#title").css({"display":"block"});
            $(".menu1 i").addClass("left");
            $(".nav-right").css({"paddingLeft":"180px"});
            $(".ul_two li").css({"paddingLeft":"15px"});
            $(".ul_two li p").css({"display":"block"});
            $(".list_one").find(".li-xia").css({display:"block"});
            $(".list_one").find(".list_span").css({"display":"block"});
            $("#iframe_box").css({left:"180px"});
            $(".list_one").hover(function(){$(".name_li").css({display:"none"})})
            $(".ul_two li").hover(function(){$(".name_li").css({display:"none"})})
        }
    })
})

//阻止浏览器的默认行为
$(function(){
    var lis=$(".ul_two li");
    lis.click(function(e){
        //阻止事件流
        e.stopPropagation();

        lis.removeClass("hovers");
        $(this).addClass("hovers");
    })
    lis.hover(function(e){
        //阻止事件流
        if(e.preventDefault){
            e.preventDefault();
        }else{
            e.returnValue=false;
        }
        e.stopPropagation();
    },function (e) {
        if(e.preventDefault){
            e.preventDefault();
        }else{
            e.returnValue=false;
        }
        e.stopPropagation();
    })
})


 $(function(){
    var num=0,oUl=$("#min_title_list"),hide_nav=$("#Hui-tabNav");

    /*获取顶部选项卡总长度*/
    function tabNavallwidth(){
        var taballwidth=0,
            $tabNav = hide_nav.find(".acrossTab"),

            $tabNavWp = hide_nav.find(".Hui-tabNav-wp"),
            $tabNavitem = hide_nav.find(".acrossTab li"),
            $tabNavmore =hide_nav.find(".Hui-tabNav-more");

        if (!$tabNav[0]){return}
        $tabNavitem.each(function() {
            taballwidth+=Number(parseFloat($(this).width()+60))
        });
        $tabNav.width(taballwidth+25);
        var w = $tabNavWp.width();
        if(taballwidth+25>w){
            $tabNavmore.show()}
        else{
            $tabNavmore.hide();
            $tabNav.css({left:0})
        }
    }

    function Hui_admin_tab(obj){
        if($(obj).attr('_href')){
            var bStop=false;
            var bStopIndex=0;
            var _href=$(obj).attr('_href');
            //获取左侧菜单栏里的 地址连接
            var _titleName=$(obj).attr("data-title");
            //获取左侧菜单栏里的 name
            var topWindow=$(window.parent.document);
            var show_navLi=topWindow.find("#min_title_list li");
            //顶部选项卡 li
            show_navLi.each(function() {
                //循环获取顶部选项卡  判断选项卡里的 data-href 与左侧菜单栏里的地址是否一致，
                if($(this).find('span').attr("data-href")==_href){
                    bStop=true;
                    bStopIndex=show_navLi.index($(this));
                    return false;
                }
            });
            //如果为true, 执行creatIframe
            if(!bStop){
                //添加一个新的选项卡目录
                creatIframe(_href,_titleName);

            }
            else{
                //有没有, 让当前点击的页面展示出来
                //如果不一致，给对应的 选项卡添加类名“.active”
                show_navLi.removeClass("active").eq(bStopIndex).addClass("active");
                var iframe_box=topWindow.find("#iframe_box");
                iframe_box.find(".show_iframe").hide().eq(bStopIndex).show().find("iframe").attr("src",_href);
            }
        }
    }
    //梯形切换方式  <iframe>标签
    function creatIframe(href,titcvleName){
        var topWindow=$(window.parent.document);
        var show_nav=topWindow.find('#min_title_list');
        show_nav.find('li').removeClass("active");
        var iframe_box=topWindow.find('#iframe_box');
        show_nav.append('<li class="active"><span data-href="'+href+'">'+titcvleName+'</span><i></i><em></em></li>');
        var taballwidth=0,
            $tabNav = topWindow.find(".acrossTab"),
            $tabNavWp = topWindow.find(".Hui-tabNav-wp"),
            $tabNavitem = topWindow.find(".acrossTab li"),
            $tabNavmore =topWindow.find(".Hui-tabNav-more");
        if (!$tabNav[0]){return}
        $tabNavitem.each(function() {
            taballwidth+=Number(parseFloat($(this).width()+60))
        });
        $tabNav.width(taballwidth+25);
        var w = $tabNavWp.width();
        if(taballwidth+25>w){
            $tabNavmore.show()}
        else{
            $tabNavmore.hide();
            $tabNav.css({left:0})
        }
        var iframeBox=iframe_box.find('.show_iframe');
        iframeBox.hide();
        iframe_box.append('<div class="show_iframe"><div class="loading"></div><iframe frameborder="0" src='+href+'></iframe></div>');
        var showBox=iframe_box.find('.show_iframe:visible');
        showBox.find('iframe').load(function(){
            showBox.find('.loading').hide();
        });
    }

    /*选项卡导航*/
    var two_lis=$(".ul_two li");
    two_lis.on("click",function(){
        var as=$(this).find("a");
        Hui_admin_tab(as);
    });
    //选择当前页面显示
    $(document).on("click","#min_title_list li",function(){
        var bStopIndex=$(this).index();
        var iframe_box=$("#iframe_box");
        $("#min_title_list li").removeClass("active").eq(bStopIndex).addClass("active");
        iframe_box.find(".show_iframe").hide().eq(bStopIndex).show();
        //左侧的侧边栏
        // var lis=$(".ul_two li");
        if($("#min_title_list li").hasClass("active")){
            var htmls=$(this).find("span").html();
            var lis=$(".ul_two li");
            var li_as=$(".ul_two li p a");
            for(var i=0;i<li_as.length;i++){
                if(li_as[i].innerHTML==htmls){
                    $(".ul_two li").removeClass("hovers");
                    $(".ul_two li").eq(i).addClass("hovers");
                }
            }
        }
        
        if(bStopIndex=="0"){
            $(".ul_two li").removeClass("hovers");
        }
    });
    $(document).on("click","#min_title_list li i",function(e){
        e.stopPropagation()
        var aCloseIndex=$(this).parents("li").index();
        $(this).parent().parent().find("li").removeClass("active");
        $(this).parent().parent().find("li").eq(aCloseIndex-1).addClass("active");
        $(this).parent().remove();
        $('#iframe_box').find('.show_iframe').css({display:"none"});
        $('#iframe_box').find('.show_iframe').eq(aCloseIndex-1).css({display:"block"});
        $('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();
        num==0?num=0:num--;
        tabNavallwidth();
        var lis_html=$("#min_title_list li").eq(aCloseIndex-1).find("span").html();
         
        var one_html=$("#min_title_list li").eq(0).find("span").html();
        if(lis_html==one_html){
            $(".ul_two li").removeClass("hovers");
        }

        var li_as=$(".ul_two li p a");
        for(var i=0;i<li_as.length;i++){
            if(li_as[i].innerHTML==lis_html){
                $(".ul_two li").removeClass("hovers");
                $(".ul_two li").eq(i).addClass("hovers");
            }
        }
    });
    $(document).on("dblclick","#min_title_list li",function(){
        var aCloseIndex=$(this).index();
        var iframe_box=$("#iframe_box");
        if(aCloseIndex>0){
            $(this).remove();
            $('#iframe_box').find('.show_iframe').eq(aCloseIndex).remove();
            num==0?num=0:num--;
            $("#min_title_list li").removeClass("active").eq(aCloseIndex-1).addClass("active");
            iframe_box.find(".show_iframe").hide().eq(aCloseIndex-1).show();
            tabNavallwidth();
            //左边侧边栏
            var lis_html=$("#min_title_list li").eq(aCloseIndex-1).find("span").html();
            console.log(lis_html);
            var li_as=$(".ul_two li p a");
            for(var i=0;i<li_as.length;i++){
                if(li_as[i].innerHTML==lis_html){
                    $(".ul_two li").removeClass("hovers");
                    $(".ul_two li").eq(i).addClass("hovers");
                }
            }
            if(aCloseIndex==1){
                $(".ul_two li").removeClass("hovers");
            }
        }else{
            return false;
        }
    });
    tabNavallwidth();
    $('#js-tabNav-next').click(function(){
        num==oUl.find('li').length-1?num=oUl.find('li').length-1:num++;
        toNavPos();
    });
    $("#js-tabNav-prev").click(function(){
        num==0?num=0:num--;
        toNavPos();
    });

    function toNavPos(){
        oUl.stop().animate({'left':-num*100},100);
    }

})