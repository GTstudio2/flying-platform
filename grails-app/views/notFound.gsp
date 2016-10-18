<!doctype html>
<html>
    <head>
        <title>Page Not Found</title>
        <meta name="layout" content="main">
        <asset:stylesheet src="main.css"/>
        %{--<g:if env="development"><asset:stylesheet src="errors.css"/></g:if>--}%
    </head>
    <body>
        <div class="container">
            <ul class="errors">
                <li>页面未找到 (404)</li>
                <li>地址: ${request.forwardURI}</li>
            </ul>
        </div>
    </body>
</html>
