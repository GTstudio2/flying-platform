package flying2

import cookie.CookieTools
import grails.converters.JSON


class AccountInterceptor {
    AccountInterceptor() {
        match(controller: "show", action: /(index|productList|photoDetail|videoDetail)/)
        match(controller: "creation")
//        match(controller: "manageProducts", action: /(index|latest|detail|post|postNow)/)
        match(controller: "manageProducts")
        match(controller: "accountSettings")
        match(controller: "comment", action: /(addComment)/)
    }

    boolean before() {
        def isAutoLogin = CookieTools.getCookieByName(request, "autoLogin")?.value
        if (!session.user&&isAutoLogin) {
            def userId = CookieTools.getCookieByName(request, "userId")?.value
            def pwd = CookieTools.getCookieByName(request, "pwd")?.value
            def u = User.find{id==userId&&pwd==pwd}
            if (u) {
                session.setAttribute("user", u)
                CookieTools.addCookie(response, "userId", userId, Integer.MAX_VALUE)
                CookieTools.addCookie(response, "pwd", pwd, Integer.MAX_VALUE)
                CookieTools.addCookie(response, "autoLogin", "true", Integer.MAX_VALUE)
            }
        }else if (!session.user) {
            if(
                params.controller=="creation"||
                params.controller=="manageProducts"
            ){
                redirect(controller: 'account', action: 'login')
                return false
            }else if(params.controller=="comment"&&params.action=="addComment"){
                def m = [:]
                m.status = 'failed'
                m.tips = 'no user'
                render m as JSON
                return false
            }
        }
        true
    }

    boolean after() {
        String languageLink
        if (params.action=="register") {
            languageLink = "/register"
            model.languageLink = languageLink
        }
        true
    }

    void afterView() {
        // no-op
    }

}
