$(function () {
    var token
    $('#form1').validate({
        rules: {
            username: {
                required: true,
                minlength: 4,
                maxlength: 10
            },
            email: {
                required: true,
                email: true
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
                email: "请输入有效的电子邮件地址"
            }
        },
        submitHandler: function () {
            $('#form1 .nextStep').text('处理中……').prop('disabled', true)
            var email = $('#email').val()
            $.post(
                '/account/isNameEmailMatch',
                {
                    username: $('#username').val(),
                    email: email
                },
                function (d) {
                    if(d.status=="success"){
                        token = d.token
                        $('#form1').hide()
                        $('#form2').show()
                        $('#emailText').text(email)
                    }else{
                        $('#usernameAndEmailError').show()
                        $('#form1 .nextStep').text('下一步').prop('disabled', false)
                    }
                }
            )
        }
    })

    $('#form2').validate({
        rules: {
            verificationCode: {
                required: true,
                minlength: 6,
                maxlength: 6
            }
        },
        messages: {
            verificationCode: {
                required: "请输入邮箱验证码",
                minlength: "请输入至少6个字符",
                maxlength: "请输入最多6个字符"
            }
        },
        submitHandler: function () {
            //$('#form2 .nextStep').text('处理中……').prop('disabled', true)
            var verificationCode = $('#verificationCode').val()
            var email = $('#email').val()
            $.post(
                '/account/checkCodeOk',
                {
                    username: $('#username').val(),
                    email: email,
                    verificationCode: verificationCode
                },
                function (d) {
                    if(d.status=='success'){
                        $('#form2').hide()
                        $('#form3').show()
                    }else{
                        alert(d.tips)
                        $('#usernameAndEmailError').show()
                        $('#form1 .nextStep').text('下一步').prop('disabled', false)
                    }
                }
            )
        }
    })
    $('#form3').validate({
        rules: {
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
        submitHandler: function () {
            //$('#form2 .nextStep').text('处理中……').prop('disabled', true)
            var email = $('#email').val()
            var username = $('#username').val()
            $.post(
                '/account/resetPwdNow',
                {
                    username: username,
                    email: email,
                    token: token,
                    pwd: $('#pwd').val()
                },
                function (d) {
                    if(d.status=='success'){
                        $('#form3').hide()
                        $('#resetSuccess').show()
                        var link = $('.loginLink').eq(0).attr('href')
                        link+= '&username='+username
                        $('.loginLink').attr('href', link)
                    }else{
                        $('#resetFailed').show()
                    }
                }
            )
        }
    })
})