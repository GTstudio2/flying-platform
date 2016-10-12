package flying2

class User {
    Date createDate = new Date()
    String username
    String pwd
    Integer sex
    String email
    String intro
    String headImg
    Date birthday
    String witchUser
    static hasMany = [productions: Product, audits: Audit]
    static constraints = {
        username unique: true
        sex nullable:true
        email nullable:true
        intro nullable: true
        headImg nullable: true
        birthday nullable: true
//        createDate nullable: true
    }
}
