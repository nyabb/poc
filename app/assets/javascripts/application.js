// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require_tree .
//= require jquery_ujs
//= require jquery.ui.slider
//= require turbolinks
//= require bootstrap
//= require jquery-fileupload
//= require bootstrap-datepicker
//= require gritter



function validateForm(e){
    var cont = true;
    $(e).find(".form-group").removeClass("has-error");
    for(var i = 0; i < e.length; i++){
        if($(e[i]).hasClass("required")){
            if($(e[i]).val().length < 1){
                $(e[i]).closest(".form-group").addClass("has-error");
                cont = false;
                if($("#form-error-handler").html().length < 1){
                    $("#form-error-handler").html("<p>Voer alstublieft een "+$(e[i]).attr("data_nicename")+ " in</p>");
                }else{
                    $("#form-error-handler").html("<p>Voer alstublieft de verplichte velden in</p>");
                }
            }
        }
    }
    return cont;
}
$(document).ready(function(){
    $(".datepicker").datepicker();
});

