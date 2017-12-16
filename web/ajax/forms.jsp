<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<iframe width="100%" height="100%" src="fdesigner/index.jsp" id="editor" style="border: none;"></iframe>
<script>
    $("#editor").height(window.innerHeight-150);
</script>
