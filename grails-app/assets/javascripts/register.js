/**
 * Created by nick on 2016/6/9.
 */
$(function () {
    $("#registerForm").validate({
        rules: {
            username: {
                required: true,
                minlength: 4,
                maxlength: 10,
                remote: {
                    url: "/account/isRepeat",
                    type: "post",
                    data: {
                        type: "username",
                        str: function() {
                            return $( "#username" ).val();
                        }
                    }
                }
            },
            email: {
                required: true,
                email: true,
                remote: {
                    url: "/account/isRepeat",
                    type: "post",
                    data: {
                        type: "email",
                        str: function() {
                            return $( "#email" ).val();
                        }
                    }
                }
            },
            pwd: {
                required: true,
                minlength: 6,
                maxlength: 20
            },
            confirm_password: {
                required: true,
                minlength: 6,
                equalTo: "#password"
            }
        },
        messages: {
            username: {
                required: "请输入用户名",
                minlength: "请输入至少4个字符",
                maxlength: "请输入最多10个字符",
                remote: "姓名重复，请重新命名"
            },
            email: {
                required: "请输入邮箱",
                email: "请输入有效的电子邮件地址",
                remote: "邮箱已被使用"
            },
            pwd: {
                required: "请输入密码",
                minlength: "请输入至少6个字符",
                maxlength: "请输入最多20个字符"
            },
            confirm_password: {
                required: "请输入确认密码",
                minlength: "请输入至少6个字符",
                equalTo: "密码不一致"
            }
        },
        submitHandler:function(form) {
            form.submit();
        }
    });
})