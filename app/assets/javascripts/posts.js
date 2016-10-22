// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function() {
    // Prevent form submit on Enter pressed
    $("form.new_post .selectize-input").on("keypress", function (e) {
        if (e.keyCode == 13) {
            return false;
        }
    });
    $("form.edit_post .selectize-input").on("keypress", function (e) {
        if (e.keyCode == 13) {
            return false;
        }
    });

    // Activate Selectize.js
    $('select#post_tags').selectize({
        plugins: ['remove_button'],
        delimiter: ',',
        persist: false,
        create: function(input) {
            return {
                value: input,
                text: input
            }
        }
    });

    $(".archive-item h4").unbind("click").click(function() {
        $(this).next("div").slideToggle();
    });

    $(".archive-item h5").unbind("click").click(function() {
        $(this).next("div").slideToggle();
    })

};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);