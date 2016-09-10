package flying2


class MySpaceInterceptor {

    boolean before() {
        if (!session.user) {
            redirect(controller: 'account', action: 'login')
            return false
        }
        true
    }

    boolean after() {
        true
    }

    void afterView() {
        // no-op
    }
}
