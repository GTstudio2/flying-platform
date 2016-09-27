package flying2
class Product {
    Date createDate = new Date()
    String folder
    String coverImg
    String name
    String intro
    String type
    Integer status = 0 //1为已发布|2为提交审核|3为发布失败
    Integer homeShow = 0 //1为我的空间首页展示|0为不展示

    static belongsTo = [user: User]
    static hasOne = [photo: Photo,video: Video]
    static hasMany = [audits: Audit]
    static constraints = {
        photo nullable: true
        video nullable: true
        intro nullable: true
        audits nullable: true
    }
}
