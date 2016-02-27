var confirmtationReady;

confirmtationReady = function() {
    var $confirmationCustomer, $directionRadioGroup, customerUser,
    $confirmationCustomer = $("#confirmation-customer"),
    customerUser = document.getElementById("current-customer");
    if (customerUser != null) {
        customerUser = customerUser.value;
        return $confirmationCustomer.click(function() {
            var $directionRadioGroup = $("input[name='addresses']");
            var confirmation, direction, directionRadioButton, i, len;
            for (i = 0, len = $directionRadioGroup.length; i < len; i++) {
                directionRadioButton = $directionRadioGroup[i];
                if (directionRadioButton.checked) {
                    direction = directionRadioButton.value;
                }
            }
            confirmation = {
                "direction": direction,
                "customer": customerUser
            };
            return $.ajax({
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(
                        'X-CSRF-Token',
                        $('meta[name="csrf-token"]').attr('content')
                    )
                },
                statusCode: {
                    200: function(response) {
                        return eval(response.responseText);
                    },
                    500: function(err) {
                        return sweetAlert("Ohh No!", "Ha ocurrido un error", "error");

                    },
                    404: function(err) {
                        return sweetAlert("Dirección Faltante", "ingrese una dirección por favor", "warning");


                    }
                },
                url: '/checkout/confirm',
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify({
                    "confirmation": confirmation
                }),
                type: 'POST'
            }).done(function(data) {
                return console.log("ok: " + data);
            }).fail(function(err) {
                return console.log(err);
            });
        });
    }

};

$(document).ready(confirmtationReady);
$(document).on('page:load', confirmtationReady);
