<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
        <script src="js/plugin/pace/pace.min.js"></script>
        <script src="js/libs/jquery-2.0.2.min.js"></script>
        <script src="js/libs/jquery-ui-1.10.3.min.js"></script>
        <script src="js/bootstrap/bootstrap.min.js"></script>
        <script src="js/plugin/jquery-validate/jquery.validate.min.js"></script>
        <script src="js/plugin/masked-input/jquery.maskedinput.min.js"></script>
        <!--[if IE 8]>
        <h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
        <![endif]-->
        <script src="js/app.min.js"></script>
        <script type="text/javascript">
            runAllForms();
            $(function() {
                $("#login-form").validate({
                    rules : {
                        loginid : {
                        required : true
                        },
                        password : {
                            required : true,
                            minlength : 3,
                            maxlength : 20
                        }
                    },

                    messages : {
                        loginid : {
                            required : 'შეიყვანეთ თქვენი სარეგისტრაციო სახელი'
                        },
                        password : {
                            required : 'შეიყვანეთ თქვენი პაროლი'
                        }
                    },

                    errorPlacement : function(error, element) {
                        error.insertAfter(element.parent());
                    }
                });
            });
            
        </script>
    </body>
</html>
