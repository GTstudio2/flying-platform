package flying2

class User {
    String createDate = new Date()
    String username
    String pwd
    String sex
    String email
    String intro
    String headImg
    String witchUser
    static hasMany = [productions: Product]
    static constraints = {
        username unique: true
        sex nullable:true
        email nullable:true
        intro nullable: true
        headImg nullable: true
//        createDate nullable: true
    }
}
