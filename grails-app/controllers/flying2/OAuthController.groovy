package flying2

import com.qq.connect.QQConnectException
import com.qq.connect.oauth.Oauth

class OAuthController {

    def index() {
        response.setContentType("text/html;charset=utf-8");
        try {
            response.sendRedirect(new Oauth().getAuthorizeURL(request));
        } catch (QQConnectException e) {
            e.printStackTrace();
        }
    }

    def afterLogin() {
        println 'afterLogin..'

    }

}
