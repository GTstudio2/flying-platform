package flying2

class User {
    Date createDate = new Date()
    String username
    String pwd
    Integer sex
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
    static constraints = {
        username unique: true
        sex nullable:true
        email nullable:true
        intro nullable: true
        folder nullable: true
        headImg nullable: true
        birthday nullable: true
//        createDate nullable: true
    }
}
