package flying2

class Audit {
    Date createDate = new Date()
    String reason

    static belongsTo = [auditUser: BackUser, product: Product]
    static constraints = {
    }
}
