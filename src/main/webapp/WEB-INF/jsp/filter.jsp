<div class="col-md-10">
    <div class="form-group">
        <label for="q">Name</label>
        <table>
            <tr>
                <td valign="TOP">
                    <input type="text" id="q" name="q" class="form-control" value="${q}"/>
                    <small id="qHelp" class="form-text text-muted">Type the name you want to find.</small>
                </td>
                <td>
                    &nbsp;
                </td>
                <td valign="TOP">
                    <button type="submit" class="btn btn-primary">Filter</button>
                </td>
                <td>
                    &nbsp;
                </td>
                <td valign="TOP">
                    <button onclick="document.forms[0].action = 'add';" class="btn btn-primary">Add</button>
                </td>
            </tr>
        </table>
    </div>
</div>