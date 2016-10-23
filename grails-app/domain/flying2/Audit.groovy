package flying2

class Audit {
    Date createDate = new Date()
    String reason
    Integer status //1为已发布|2为提交审核|3为发布失败|4为稍后审核

    static belongsTo = [auditUser: BackUser, product: Product]
    static constraints = {
        reason nullable: true
        auditUser nullable: true
    }
}
