package flying2

import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.PageFans;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.PageFansBean;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.javabeans.weibo.Company;
import com.qq.connect.oauth.Oauth
import fetch.Fetch
import grails.transaction.Transactional
import org.springframework.beans.factory.annotation.Value

class OAuthController {
    @Value('${filePath.headImgPath}')
    String headImgPath

    def accountService
    def index() {
        response.setContentType("text/html;charset=utf-8");
        try {
            session.afterLoginUrl = params.afterLoginUrl
            response.sendRedirect(new Oauth().getAuthorizeURL(request));
        } catch (QQConnectException e) {
            e.printStackTrace();
        }
    }

    @Transactional
    def afterLogin() {
        response.setContentType("text/html; charset=utf-8");
//        PrintWriter out = response.getWriter();
        session.qq_connect_state = params.state
        def m = [status:1, msg: '']
        try {
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);

            String accessToken   = null,
                   openID        = null;
            long tokenExpireIn = 0L;

            if (accessTokenObj.getAccessToken().equals("")) {
//                我们的网站被CSRF攻击了或者用户取消了授权
//                做一些数据统计工作
                System.out.print("没有获取到响应参数");
                m.msg = '对不起，服务器发生了内部错误'
            } else {
                accessToken = accessTokenObj.getAccessToken();
                tokenExpireIn = accessTokenObj.getExpireIn();
                request.getSession().setAttribute("demo_access_token", accessToken);
                request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

                // 利用获取到的accessToken 去获取当前用的openid -------- start
                OpenID openIDObj =  new OpenID(accessToken);
                openID = openIDObj.getUserOpenID();

//                out.println("欢迎你，代号为 " + openID + " 的用户!");
//                request.getSession().setAttribute("demo_openid", openID);
//                out.println("<a href=" + "/shuoshuoDemo.html" +  " target=\"_blank\">去看看发表说说的demo吧</a>");
//                // 利用获取到的accessToken 去获取当前用户的openid --------- end
//                out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- start </p>");
                UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
//                out.println("<br/>");
                if (userInfoBean.getRet() == 0) {
                    String username = userInfoBean.getNickname()
                    int sex = 1
                    userInfoBean.getGender() == "女"?sex = 2:""
                    OAuthUser oAuthUser = OAuthUser.findByOpenID(openID)

                    if (oAuthUser) { //已在本站注册
                        if (!oAuthUser.isManualSetup) {
                            oAuthUser.user.username = username
                            if (sex == 2) {
                                oAuthUser.user.sex = 2
                            }else{
                                oAuthUser.user.sex = 1
                            }
                            oAuthUser.save()
                        }
                        session.user = oAuthUser.user
                    }else{ //注册关联本站
                        def isRepeat = accountService.isRepeat(username, 'username')
                        def finalName = username
                        for (int i = 0; i < 10; i++) {
                            if (isRepeat) {
                                def likedUsers = User.findAllByUsernameLike(username)
                                String random = (int)(Math.random()*10000)
                                finalName = username+random
                                def isNewNameRepeat = likedUsers.find{
                                    it.username = finalName
                                }
                                if (!isNewNameRepeat) {
                                    break
                                }
                            }
                        }

                        def user = new User(username: finalName, sex: sex, witchUser: 'qq')
                        user.oauthUser = new OAuthUser(openID: openID, isManualSetup: false)
                        if (user.save()) {
                            def avatarUrl100 = userInfoBean.getAvatar().getAvatarURL100()
                            println headImgPath
                            String tempFolderName = System.currentTimeMillis()
                            String folder = user.username+"_"+tempFolderName
                            String newTempFolder = headImgPath+File.separator+folder
                            new File(newTempFolder).mkdir()
                            def headImg = Fetch.fetchImg(avatarUrl100, newTempFolder)
                            user.folder = folder
                            user.headImg = headImg
                            session.user = user
                        }else{
                            m.status = 0
                            m.msg = '登录失败'
                            user.errors.allErrors.each {
                                println it
                            }
//                            println '注册关联本站失败'
                        }
                    }
//                    out.println(userInfoBean.getNickname() + "<br/>");
//                    out.println(userInfoBean.getGender() + "<br/>");
//                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
//                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
//                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                } else {
//                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + userInfoBean.getMsg());
                }
                String afterLoginUrl = session.afterLoginUrl
//                if (afterLoginUrl) {
//                    println 'good'
//                }else{
//                    println 'no'
//                }
                if (afterLoginUrl&&m.status) {
                    session.removeAttribute("afterLoginUrl") //跳转后清空临时跳转地址
                    redirect(url: afterLoginUrl)
                    return
                }else if(!afterLoginUrl&&m.status){
                    redirect(controller: 'show', action: 'index')
                    return
                }
//                out.println("<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- end </p>");
            }
        } catch (QQConnectException e) {
            m.status = 0
            m.msg = '对不起，服务器发生了内部错误'
        }
        m
    }

//    public AccessToken getAccessTokenByRequest(ServletRequest request) throws QQConnectException {
//        String queryString = ((HttpServletRequest)request).getQueryString();
//        if(queryString == null) {
//            return new AccessToken();
//        } else {
//            String state = (String)((HttpServletRequest)request).getSession().getAttribute("qq_connect_state");
//            if(state != null && !state.equals("")) {
//                String[] authCodeAndState = this.extractionAuthCodeFromUrl(queryString);
//                String returnState = authCodeAndState[1];
//                String returnAuthCode = authCodeAndState[0];
//                AccessToken accessTokenObj = null;
//                if(!returnState.equals("") && !returnAuthCode.equals("")) {
//                    if(!state.equals(returnState)) {
//                        accessTokenObj = new AccessToken();
//                    } else {
//                        accessTokenObj = new AccessToken(this.client.post(QQConnectConfig.getValue("accessTokenURL"), new PostParameter[]{new PostParameter("client_id", QQConnectConfig.getValue("app_ID")), new PostParameter("client_secret", QQConnectConfig.getValue("app_KEY")), new PostParameter("grant_type", "authorization_code"), new PostParameter("code", returnAuthCode), new PostParameter("redirect_uri", QQConnectConfig.getValue("redirect_URI"))}, Boolean.valueOf(false)));
//                    }
//                } else {
//                    accessTokenObj = new AccessToken();
//                }
//
//                return accessTokenObj;
//            } else {
//                return new AccessToken();
//            }
//        }
//    }

}
