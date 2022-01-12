/* JavaScript for "Content Switching using JavaScript" */

jQuery().ready(function(){
    $(".content").hide();
    $(".ascenseur").find("ul").hide();
    $(".ascenseur").click(function(){
	if($(this).find("ul").is(":hidden")){
	    $(".ascenseur").find("div.content:visible").hide();
	    $(".ascenseur").find("ul:visible").slideUp(); 
	    $(this).find("ul").slideDown();
	    $(this).find("ul li.ascenseur2").click(function(){
		$(".ascenseur").find("div.content:visible").hide();
		$(this).find("div.content").show();
	    }); 
	}
    });
 
}); 