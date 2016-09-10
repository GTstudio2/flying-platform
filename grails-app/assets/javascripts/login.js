/**
 * Created by tarek on 2015/6/29.
 */
$(function () {

    $("#loginForm").validate({
        rules: {
            username: {
                required: true,
                minlength: 4
            },
            pwd: {
                required: true,
                minlength: 6
            },
            agree: "required"
        },
        messages: {
            username: {
                required: "请输入用户名",
                minlength: "至少输入4个字符"
            },
            pwd: {
                required: "请输入密码",
                minlength: "至少输入6个字符"
            }
        },
        submitHandler:function() {
            var params = $("#loginForm").serialize()
            params+="&isAjax=1"
            $.post(
                "/account/login",
                params,
                function(d) {
                    if(d.status=="success") {
                        window.location.reload()
                    }else{
                        $("#errorBox").text(d.tip)
                    }
                }
            )

        }
    });
})