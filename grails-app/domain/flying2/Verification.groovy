package flying2

class Verification {
    Date createDate = new Date()
    String code
    Integer type //1为忘记密码验证码|2为用户注册验证码
    String token
    static belongsTo = [user: User]
    static constraints = {
        code maxSize: 6
    }
}
