// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function(loading_div, check, error_div){
    this.submit(function(){
        for(var i = 0; i < check.length; i++)
        {
            if($('#' + check[i]).val() == '')
            {
               $('#' + error_div).html('Fields can not be blank.'); 
               return false;
            }
        }
        $('#' + error_div).html(''); 
		$(loading_div).show();
		$.post($(this).attr('action'), $(this).serialize(), null, "script");		
		return false;
	})
};