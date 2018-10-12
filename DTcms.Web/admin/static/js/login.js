/**
 * Created by Administrator on 2016/7/22 0022.
 */
$(function() {
	var login = $("#login-sub");
	var account = $("#user");
	var password = $("#pass");
	var code = $("#yanzhengma");
	// alert(document.cookie);
	// 获取cookie值
	function getCookie(cookie_name) {
		var allcookies = document.cookie;
		var cookie_pos = allcookies.indexOf(cookie_name);
		// 如果找到了索引，就代表cookie存在，
		// 反之，就说明不存在。
		if (cookie_pos != -1) {
			// 把cookie_pos放在值的开始，只要给值加1即可。
			cookie_pos += cookie_name.length + 1;
			var cookie_end = allcookies.indexOf(";", cookie_pos);
			if (cookie_end == -1) {
				cookie_end = allcookies.length;
			}
			var value = unescape(allcookies.substring(cookie_pos, cookie_end));
		}
		return value;
	}

	// 调用函数
	$("#user").blur(function() {
		var use = account.val();
		// var p = password.val();
		var cookie_val = getCookie(use);

		if(document.login!=undefined){
			if (cookie_val != undefined) {
				document.login.pass.value = cookie_val;
			} else {
				document.login.pass.value = "";
			}
		}
	})

	// 创建一个cookie
	function setCookie(attr, val, time) {
		if (time) {
			var now = new Date();
			now.setDate(now.getDate() + time);
			document.cookie = attr + "=" + val + ";expires="
					+ now.toGMTString();
		} else {
			document.cookie = attr + "=" + val;
		}
	}

	login.on("click", function(e) {
		// 存入到cookie中
		var nameval = account.val();
		var passval = password.val();
		var cod = code.val();
		// 用户名不能为空
		if (nameval.length == 0) {
			$(".login-error").html("用户名不能为空!");
			$(".login-none").css({
				display : "block"
			});
			// input 获取焦点时，提示信息消失
			account.focus(function() {
				$(".login-none").css({
					display : "none"
				});
			})
		}
		// 密码不能为空
		if (passval.length == 0) {
			$(".pass-error").html("密码不能为空!");
			$(".pass-none").css({
				display : "block"
			});
			// input 获取焦点时，提示信息消失
			password.focus(function() {
				$(".pass-none").css({
					display : "none"
				});
			})
		}
		// 判断验证码的
		if (nameval != "" && passval != "") {
			if (cod == "") {
				$(".pass-error").html("验证码不能为空!");
				$(".pass-none").css({
					display : "block"
				});
				// input 获取焦点时，提示信息消失
				code.focus(function() {
					$(".pass-none").css({
						display : "none"
					});
				})
			}
		}
		// 记住密码,往cookie中添加用户名，密码
		var input = $("#xuan");
		if (input[0].checked == true) {
			setCookie(escape(nameval), passval, "365");
		}
		// 都有值了就登录
		if (nameval != "" && passval != "" && cod != "") {
			$.ajax({
				type : 'POST',
				url : "/login/login",
				data : {
					"userName" : nameval,
					"userPwd" : passval,
					"code" : cod
				},
				async : false,
				success : function(data) {
					console.log(data);
					data = eval("(" + data + ")");
					if (data.status == 2) {
						location.href = "/index/toIndex";
					} else if (data.status == 1) {
						$(".login-error").html(data.message);
						$(".login-none").css({
							display : "block"
						});
						$(".pass-none").css({
							display : "none"
						});
					} else {
						$(".pass-error").html(data.message);
						$(".pass-none").css({
							display : "block"
						});
						$(".login-none").css({
							display : "none"
						});
						updateVercode();
					}
				}
			});
		}
	});

	// 获取name
	function readCookie(name) {
		var cookieValue = "";
		var search = name + "=";
		if (document.cookie.length > 0) {
			offset = document.cookie.indexOf(search);
			if (offset != -1) {
				offset += search.length;
				end = document.cookie.indexOf(";", offset);
				if (end == -1) {
					end = document.cookie.length;
					cookieValue = unescape(document.cookie.substring(offset,
							end))
				}
			}
		}

		return cookieValue;

	}
})