$(function () {
    $('#form1').validate({
        rules: {
            oldPwd: {
                required: true,
                minlength: 6,
                maxlength: 20
            },
            pwd: {
                required: true,
                minlength: 6,
                maxlength: 20
            },
            confirm_password: {
                required: true,
                minlength: 6,
                equalTo: "#pwd"
            }
        },
        messages: {
            oldPwd: {
                required: "请输入密码",
                minlength: "请输入至少6个字符",
                maxlength: "请输入最多20个字符"
            },
            pwd: {
                required: "请输入密码",
                minlength: "请输入至少6个字符",
                maxlength: "请输入最多20个字符"
            },
            confirm_password: {
                required: "请输入确认密码",
                minlength: "请输入至少6个字符",
                maxlength: "请输入最多20个字符",
                equalTo: "密码不一致"
            }
        },
        submitHandler: function (form) {
            //$('#form2 .nextStep').text('处理中……').prop('disabled', true)
            form.submit()
        }
    })
})