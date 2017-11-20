<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    attribute name="id" required="false" %><%@
    attribute name="style" required="false" %><%@
    attribute name="className" required="false" %><%@
    attribute name="savingTitle" required="false"

%><forms:progressRing id="${empty id ? 'saving' : id}"
                      style="display: none; ${style}"
                      className="${className}"
                      progressTitle="${empty savingTitle ? 'Please wait...' : savingTitle}"/>