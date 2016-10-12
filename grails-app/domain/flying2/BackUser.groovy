package flying2
class BackUser {
    Date createDate = new Date()
    String username
    String pwd
    String sex
    String email
    String intro
    String headImg
    static constraints = {
        username nullable:false
        pwd nullable:false
        sex nullable:true
        email nullable:true
        intro nullable: true
        headImg nullable: true
    }
}
