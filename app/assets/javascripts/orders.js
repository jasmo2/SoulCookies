$(function() {
    var ajaxLink, updateOrderItemsFromRemote;
    updateOrderItemsFromRemote = function(data) {
        if (data.status === 'complete') {
            if (data.redirect != null) {
                return window.location.replace(data.redirect);
            } else if (data.items != null) {
                return $('table.orderItems').replaceWith(data.items);
            }
        } else if (data.status === 'error') {
            return alert(data.message);
        }
    };
    ajaxLink = function(successMethod) {
        $.ajax({
            url: $(this).attr('href'),
            type: $(this).data('method'),
            dataType: 'json',
            success: successMethod
        });
        return false;
    };
    $('body').on('click', 'a.ajax', function() {
        return ajaxLink.call(this, updateOrderItemsFromRemote);
    });
    return null;
});
