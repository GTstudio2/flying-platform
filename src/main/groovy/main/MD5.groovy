package main
import sun.misc.BASE64Encoder

import java.security.MessageDigest
class MD5 {
    def static encode(str) {
        str += "youAllIt'sMine"
        MessageDigest md5 = MessageDigest.getInstance("MD5")
        BASE64Encoder base64en = new BASE64Encoder()
        str = base64en.encode(md5.digest(str.getBytes("utf-8")))
        str
    }
}
