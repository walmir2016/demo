<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<br/>
<input type="hidden" id="id" name="id"/>
<div class="col-md-10">
    <div class="form-group">
        <div class="container">
            <div class="row">
                <div class="col-sm-5">
                    <b>Name</b>
                </div>
                <div class="col-sm-3">
                    <b>Phone</b>
                </div>
            </div>
            <c:set var="i" value="<%=0%>"/>
            <c:forEach var="item" items="${result}">
                <div class="row">
                    <div class="col-sm-5">
                        ${item.name}
                    </div>
                    <div class="col-sm-3">
                        ${item.phone}
                    </div>
                    <div class="col-sm-1">
                        <button onclick="document.getElementById('id').value = ${item.id}; document.forms[0].action='edit';" class="btn btn-primary btn-sm">Edit</button>
                    </div>
                    <div class="col-sm-1"></div>
                    <div class="col-sm-1">
                        <button onclick="if(confirm('Do you confirm the deletion of this item?')) { document.getElementById('id').value = ${item.id}; document.forms[0].action='delete'; }" class="btn btn-primary btn-sm">Delete</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>