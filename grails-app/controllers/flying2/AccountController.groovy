package flying2

import cookie.CookieTools
import main.MD5
import grails.converters.JSON
import org.springframework.web.servlet.support.RequestContextUtils

class AccountController {
    def accountService

    def login() {
        println params
//-----------
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
        render isSuccess
    }

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
        def locale = RequestContextUtils.getLocale(request) as String
        if(locale!="en"&&locale!="zh_CN") locale = "en"
//        println "params is : ${params}"
        params.witchUser = "yizhi"
        def isNameRepeat = accountService.isRepeat(params.username, 'username')
        if(isNameRepeat){
            def tip = 'Name repetition!'
            if (locale == "zh_CN") {
                tip = '姓名重复！'
            }
            redirect(action: 'register', params: [status: 'failed', tip: tip])
            return
        }
        def isEmailRepeat = accountService.isRepeat(params.email, 'email')
        if(isEmailRepeat){
            def tip = 'Email is already used!'
            if (locale == "zh_CN") {
                tip = '邮箱已被使用！'
            }
            redirect(action: 'register', params: [status: 'failed', tip: tip])
            return
        }
//        println "yeah register................"
        def m = [:]
        params.pwd = MD5.encode(params.pwd)
        if (new User(username: params.username, email: params.email, pwd: params.pwd, sex: Integer.parseInt(params.sex)).save()) {
            m.status = "success"
            m.tip = "registration success"
        }else{
            m.status = "failed"
            m.tip = "registration failed"
        }
        if (locale == "zh_CN") {
            if (m.status == "success") {
                m.tip = "注册成功"
            }else if (m.status == "failed") {
                m.tip = "注册失败"
            }
        }
        m.locale = locale
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
