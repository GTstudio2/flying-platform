package flying2

class OAuthUser {
    String openID //对应第三方唯一ID
    Boolean isManualSetup //是否对第三方账户在本平台手动更改信息

    static belongsTo = [user: User]
    static constraints = {
    }
}
