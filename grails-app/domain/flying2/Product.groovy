package flying2
class Product {
    Date createDate = new Date()
    Date removeDate = new Date() //用户操作删除日期
    String folder
    String coverImg
    String name
    String intro
    String type
    Integer viewer = 0
    Integer status = 0 //1为已发布|2为提交审核|3为发布失败|4为稍后审核|5申述|6禁止发布|用户删除
    Integer homeShow = 0 //1为我的空间首页展示|0为不展示

    static belongsTo = [user: User]
    static hasOne = [photo: Photo,video: Video]
    static hasMany = [audits: Audit]
    static constraints = {
        removeDate nullable: true
        photo nullable: true
        video nullable: true
        intro nullable: true
        audits nullable: true
    }
}
