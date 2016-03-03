var ready;


ready = function() {
    var loginFb = $("#login-fb")
    newCustomerUser = $(".customer-user-record"),
        uid= null,
        accessToken = null;
    var fetchUserInformation, fillResponse;
    fillResponse = function(response, customerUser, uid) {
        var hidden, toTrim;
        toTrim = customerUser.html(response);
        customerUser.html(toTrim.children("#form-container")[0].innerHTML);
        hidden = $(document.createElement('input')).attr({
            type: 'hidden',
            uid: 'customers_user_uid',
            name: "customers_user[uid]",
            value: uid
        });
        customerUser.children("form").append(hidden);
        return null;
    };
    fetchUserInformation = function(me, urlPath, uid) {
        var customerUser;
        customerUser = $("#customer-user");
        return $.ajax({
            url: urlPath,
            data: me,
            dataType: "html",
            method: "POST",
            statusCode: {
                202: function() {
                    return window.location.reload();
                },
                200: function(response) {
                    newCustomerUser.hide();
                    fillResponse(response, customerUser, uid);
                    return $('#customer-submit').submit(function() {
                        var valuesToSubmit;
                        valuesToSubmit = $(this).serialize();
                        console.log(valuesToSubmit);
                        $.ajax({
                            url: $(this).attr('action'),
                            data: valuesToSubmit,
                            dataType: "html",
                            type: this.method.toUpperCase()
                        }).success(function(response) {
                            return window.location.reload();
                        }).fail(function(err) {
                            if (err.status === 400) {
                                eval(err.responseText);
                            }
                            return console.log("error " + err);
                        });
                        return false;
                    });
                }
            }
        }).fail(function(err) {
            return console.log("error " + err);
        });
    };
    return $(document).ready(function() {
        var checkLoginStatus;
        $.ajaxSetup({
            cache: true
        });

        $.getScript("//connect.facebook.net/es_LA/all.js", function() {
            return FB.init({
                appId: "182897058733210",
                version: "v2.5"
            });
        });
        checkLoginStatus = function(response, urlPath) {
            var accessToken, uid;
            if (response && response.status === "connected") {
                console.log('Welcome!  Fetching your information.... ');
                uid = response.authResponse.userID;
                accessToken = response.authResponse.accessToken;
                return FB.api("/me", "GET", {
                    fields: "id,first_name,last_name,email"
                }, function(response) {
                    return fetchUserInformation(response, urlPath, uid);
                });
            } else {
                return console.log('User cancelled login or did not fully authorize.');
            }
        };
        return loginFb.click(function(e) {
            var urlPath;
            e.preventDefault();
            urlPath = $(this).attr("href");
            return FB.login((function(response) {
                return checkLoginStatus(response, urlPath);
            }), {
                scope: "email, user_likes"
            });
        });
    });
};


$(document).ready(ready);
$(document).on('page:load', ready);
