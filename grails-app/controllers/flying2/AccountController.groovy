package flying2

import cookie.CookieTools
import main.MD5
import grails.converters.JSON
import org.springframework.web.servlet.support.RequestContextUtils

import java.text.SimpleDateFormat

class AccountController {
    def accountService

    def login() {
//        println params
        def m = [:]
        if (params.username != null && params.pwd != null) {
            params.pwd = MD5.encode(params.pwd)
            def u = User.find{username==params.username&&pwd==params.pwd}
            if (u) {
                session.setAttribute("user", u)
                CookieTools.addCookie(response, "userId", u.id.toString(), Integer.MAX_VALUE)
                CookieTools.addCookie(response, "pwd", params.pwd.toString(), Integer.MAX_VALUE)
                if (params.isAutoLogin=="on"){
                    CookieTools.addCookie(response, "autoLogin", "true", Integer.MAX_VALUE)
                }
                if (params.isAjax) {
                    m.status = "success"
                }else{
                    redirect(controller: 'show', action:'index')
                }
            }else{
                m.status = "failed"
                m.tip = "用户名或密码错误"
                if (!params.isAjax) {
                    return m
                }
            }
        }else{
            def isAutoLogin = CookieTools.getCookieByName(request, "autoLogin")?.value
            if (isAutoLogin) {
                def userId = CookieTools.getCookieByName(request, "userId")?.value
                def pwd = CookieTools.getCookieByName(request, "pwd")?.value
                def u = User.find{id==userId&&pwd==pwd}
                if (u) {
                    session.setAttribute("user", u)
                    CookieTools.addCookie(response, "userId", userId, Integer.MAX_VALUE)
                    CookieTools.addCookie(response, "pwd", pwd, Integer.MAX_VALUE)
                    CookieTools.addCookie(response, "autoLogin", "true", Integer.MAX_VALUE)
                    if (params.isAjax) {
                        m.status = "success"
                    }else{
                        redirect(controller: 'show', action:'index')
                    }
                }else{
                    m.status = "failed"
                    m.tip = "用户名或密码错误"
                    if (!params.isAjax) {
                        return m
                    }
                }
            }
        }
        if (params.isAjax) {
            render m as JSON
        }
    }

    def loginNow() {

    }

    /**
     * 忘记密码
     */
    def resetPwd() {

    }

    def isRepeat() {
        def isRepeat = accountService.isRepeat(params.str, params.type)
        def isSuccess = true
        isRepeat?isSuccess=false:""
        render isSuccess as String
    }

    def isNameEmailMatch() {
        def user = User.findByUsernameAndEmail(params.username, params.email)
        def m = [:]
        if (user) {
//            Math.random()
            def verifyCode = ""
            for (int i = 0; i < 6; i++ ){
                verifyCode += (int)(Math.random()*10)
            }
            accountService.sendVerifyCodeEmail(params.email, "你的邮箱验证码是" + verifyCode)
            String timeMillis = System.currentTimeMillis();
            String token = MD5.encode('this is'+timeMillis)
            new Verification(type: 1, code: verifyCode, user: user, token: token).save()
            m.token = token
            m.status = "success"
        }else{
            m.staus = "failed"
        }
        render m as JSON
    }

    def checkCodeOk() {
        def user = User.findByUsernameAndEmail(params.username, params.email)
        def verifications = Verification.findAllByUserAndCode(user, params.verificationCode, [sort: "createDate", order: "desc"])
        def verify
        if(verifications.size()>0){
            verify = verifications[0]
        }
        def m = [:]
        if(verify){
            def diff = new Date().getTime()-verify.createDate.getTime()
            def minutes = diff / (1000 * 60);
            if(minutes<=10){
                m.status = 'success'
            }else{
                m.status = 'failed'
                m.tips = '验证码过期'
            }
        }else{
            m.status = 'failed'
            m.tips = '验证码不正确'
        }
        render m as JSON
    }

    def resetPwdNow() {
        def user = User.findByUsernameAndEmail(params.username, params.email)
        def verifications = Verification.findAllByUserAndToken(user, params.token, [sort: "createDate", order: "desc"])
        def verify
        if(verifications.size()>0){
            verify = verifications[0]
        }
        def m = [:]
        if (verify) {
            params.pwd = MD5.encode(params.pwd)
            user.pwd = params.pwd
            user.save()
            m.status = "success"
        }else{
            m.staus = "failed"
            m.tips = "验证失败"
        }
        render m as JSON
    }

//    def is

    def backLogin() {
        if (params.username != null && params.pwd != null) {
            def md5Pwd = MD5.encode(params.pwd)
            def u = BackUser.find{username==params.username&&pwd==md5Pwd}
            if (u) {
                session.setAttribute("backUser", u)
                redirect(controller: 'backend', action:'allProductions')
            }else{
                [status: 'failed']
            }
        }
    }

    def register() {
        def locale = RequestContextUtils.getLocale(request) as String
        if(locale!="en"&&locale!="zh_CN") locale = "en"
        [locale: locale]
    }

    def registerNow() {
//        println "params is : ${params}"
        def witchUser = "yizhi"
        def isNameRepeat = accountService.isRepeat(params.username, 'username')
        if(isNameRepeat){
            def tip = '姓名重复！'
            redirect(action: 'register', params: [status: 'failed', tip: tip])
            return
        }
        def isEmailRepeat = accountService.isRepeat(params.email, 'email')
        if(isEmailRepeat){
            def tip = '邮箱已被使用！'
            redirect(action: 'register', params: [status: 'failed', tip: tip])
            return
        }
//        println "yeah register................"
        def m = [:]
        params.pwd = MD5.encode(params.pwd)
        def user = new User(username: params.username, email: params.email, pwd: params.pwd, sex: Integer.parseInt(params.sex), witchUser: witchUser)
        if (user.save()) {
            m.status = "success"
            m.tip = "registration success"
        }else{
            user.errors.allErrors.each {
                println it
            }
            m.status = "failed"
            m.tip = "registration failed"
        }
        if (m.status == "success") {
            m.tip = "注册成功"
        }else if (m.status == "failed") {
            m.tip = "注册失败"
        }
        m.username = params.username
        m
    }

    def logOut() {
        //session失效并且cookie也要失效
        session.removeAttribute("user")
        CookieTools.addCookie(response, "userId", null, 0)
        CookieTools.addCookie(response, "pwd", null, 0)
        CookieTools.addCookie(response, "autoLogin", null, 0)
        redirect(controller: 'show', action: 'index')
    }
    def backLogOut() {
        //session失效并且cookie也要失效
        session.removeAttribute("backUser")
        redirect(controller: 'account', action: 'backLogin')
    }
}
