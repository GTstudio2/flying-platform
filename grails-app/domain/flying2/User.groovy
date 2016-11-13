package flying2

class User {
    Date createDate = new Date()
    String username
    String pwd
    Integer sex //男1，女2
    String email
    String intro
    String folder
    String headImg
    Date birthday
    String witchUser
    Integer productCount = 0
    Integer fansCount = 0
    Integer attentionsCount = 0
    static hasMany = [productions: Product, audits: Audit, fans: User, attentions: User]
    static hasOne = [oauthUser: OAuthUser]
    static constraints = {
        username unique: true
        pwd nullable: true
        sex nullable:true
        email nullable:true
        intro nullable: true
        folder nullable: true
        headImg nullable: true
        birthday nullable: true
        oauthUser nullable: true
//        createDate nullable: true
    }
}
