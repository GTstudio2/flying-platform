package flying2

import grails.transaction.Transactional

import java.text.SimpleDateFormat

@Transactional
class AccountService {
    def mailService

    def isRepeat(str, type) {
        def u
        if(type=="username"){
            u = User.findByUsername(str)
        }else if(type=="email"){
            u = User.findByEmail(str)
        }
        if(u){
            return true
        }else{
            return false
        }
    }

    def sendVerifyCodeEmail(String toEmail,String  textString) {
        def date = new Date()
        def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def now = sdf.format(date)
        mailService.sendMail {
            from "tjtj54tj@163.com"
            to toEmail
            subject "你的修改密码验证码为"+now
            text textString
        }
    }
}
