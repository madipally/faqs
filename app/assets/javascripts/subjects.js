// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
    $(".question-type input:radio").click(function(){
        console.log($(this).attr('value'));
        if ($(this).attr('value') == "multiple")
        {
            console.log("in")
            $("#question_choices").show();
        }
        else
            $("#question_choices").hide()
    })
    var row=2;
    $(".add-choice").click(function(){
        console.log("in btn")
        
        var markup = "<div class='row'><input type='checkbox' class='remove-choice-row'/><span id='snum"+row+"'>"+row+".</span><label>Choice"+row+"</label><textarea id='question_options"+row+"'></textarea></div>";
        $("#choices").append(markup);
        row++;
    });
    
    $(".remove-choice").click(function(){
       $(".remove-choice-row:checkbox:checked").closest("div").remove(); 
    });
});
