"use strict";

//manages column display
function columnManager() {
    /**
     * list of hidden columns
     */
    this.hidden = [];
    
    /**
     * field separator for column extraction
     */
    this.separator = ',';
    
    /**
     * hide a column by id
     */
    this.hide = function (column,idTable) {
        var position = this.getPosition(column);
        $('#'+idTable+' td:nth-child(' + position + '),'+'#'+idTable+' th:nth-child( ' + position + ')').hide();
        this.hidden[column] = true;
    }
    
    /**
     * show a column by id
     */
    this.show = function (column,idTable) {        
        var position = this.getPosition(column);        
        $('#'+idTable+' td:nth-child(' + position + '),'+'#'+idTable+' th:nth-child( ' + position + ')').show();
        delete this.hidden[column];
    }
    
    /**
     * show all columns
     */
    this.showAll = function () {
        var key;
        for (key in this.hidden) {
            this.show(key);
        }
    }

    /**
     * export content of visible columns as ascii
     */
    this.extractAsCsv = function (idTable) {
        var result = '#Queried node : ' + $('#queried_node').text()+"\n";
        var self = this;
      
        var colId;
        
        result += "\n#";
        
        result += '#Sources' + "\n";
        //get headers for sources
        $('#sources_'+ idTable + ' thead tr').children('th').each(function () {
            result += $(this).text() + self.separator;
        });
        result = result.substr(0, result.length - 1) + '\n';
        var s_lines = $("#sources_"+idTable).find('.table-line'); 
        $(s_lines).each(function () {
               $(this).children('td').each(function () {
                    result += $(this).text() + self.separator;
                   
                });
            result = result.substr(0, result.length - 1) + "\n";
        });

        result += "\n#";
	
	    //get headers
        $('#' + idTable + ' thead tr').children('th').each(function () {
            colId = $(this).attr('id');
            if (self.hidden[colId] !== true && colId !== 'c1'+idTable) {
                result += $(this).children('.title').text() + self.separator;
            }
        });

        result = result.substr(0, result.length - 1) + '\n';
        var t_lines =$("#"+idTable).find('.table-line');
	
        $(t_lines).each(function () {
            if (($(this).find('.keep_line').prop('checked')) === true){ 
                $(this).children('td').each(function (i) {
                    colId = $(this).attr('data-columnid');
                    if (i > 0){ // first column is chkbx
                        if (self.hidden[colId] !== true) {
                            result += $(this).text() + self.separator;
                        }
                    }
                });
            }
            result = result.substr(0, result.length - 1) + "\n";
        });
        return result;
    }
    
    this.getPosition = function (name) {
        return $("#"+name).index()+1;
    }
    
    this.getColumn= function(position){
        return 'c'+(position+1);
    }
};

/**
 * page elements ids and manipulation
 */
var page = {
    colManager : new columnManager(), 
    sampSentCounter : 0,
    loading : 'loader',
    hideResultButton : 'result',
    exportButton : 'csv_export',
    sampSendButton : 'votable_samp',
    resetButton : 'reset',
    sampConnectionButton : 'samp_connection',
    exportArea : 'result_ascii',
    isSampConnected : false,
    connector : null,
       
    /**
    * display or hide loader bar according to current state
    */
    switchLoaderBar : function() {
        var state = $('#' + this.loading).css('display');
        if (state === 'none') {
            this.showLoader();
        } else {
            this.hideLoader();
        }
        this.forceRedraw(document.getElementById(this.loading));
    },
    
    hideLoader : function() {
        $('#' + this.loading).hide();
    },

    showLoader : function() {
        $('#' + this.loading).show();
    },

    forceRedraw : function(element) {
        if (!element) { return; }

        var n = document.createTextNode(' ');
        var disp = element.style.display;  // don't worry about previous display style

        element.appendChild(n);
        element.style.display = 'none';

        setTimeout(function() {
            element.style.display = disp;
            n.parentNode.removeChild(n);
        }, 20);
    },

    /**
     * reset page display
     */
    reset : function(idTable) {
        this.colManager.showAll();
        $('#' + this.exportArea).html('');
        $("#" + idTable).find(".keep_line").prop('checked', true);
	$("#" + idTable).find('button').text('Unselect all');
    },

    /**
     * hide export area 
     */
    hideExport :  function() {
        if ($("#" + this.hideResultButton).text() === 'Hide result') {
            $("#" + this.hideResultButton).text('Show result');
            $('#' + this.exportArea).hide();
        } else {
            $("#" + this.hideResultButton).text('Hide result');
            $('#' + this.exportArea).show();
        }
    },

    /**
     * init samp connection object
     */
    initSamp : function() {
        var metadata = {
            "samp.name": "Xsams processor",
            "samp.description": "Extracting data from Xsams documents",
            "samp.icon.url": "http://www.vamdc.eu/templates/redevo_aphelion/images/logo-cons.png"
        };
        this.connector = new samp.Connector("Sender", metadata);
    },
        
    /**
     * send a votable via samp
     */
    sampSend : function(path) {
        var self = this;
        // Broadcasts a table given a hub connection.
        var send = function(connection) {
          var msg = new samp.Message("table.load.votable", {"url": path, "name":"table_"+self.sampSentCounter});
          connection.notifyAll([msg]);
        };
        this.sampSentCounter +=1;
        this.connector.runWithConnection(send, function() {alert('no hub'), self.sampSentCounter -= 1;});
    },
    
    /**
     * end connection with samp hub
     */
    sampUnregister : function() {
        this.connector.unregister();
    }
};

//execute ajax request
var ajax_request = {
    /**
     * create a votable on the server, get its url and broadcast via samp
     */  
    broadcastTable : function(idTable){
	//var urlSubmit = '/webtools/recordtable';
	var urlSubmit = 'http://xsams-processors.obspm.fr/webtools/recordtable';
        var path = window.location.pathname.split('/');
        var req = {'table': page.colManager.extractAsVoTable(idTable), 'table_id' : path[path.length-1]};
		$.ajax({
			type: "POST",
			url: urlSubmit,
			data : req,
			success: function(data) {
               page.sampSend(data);
            },
            error : function(xhr, status, error){
                alert(status);
            }
	});
		return false;
    }
}

var select_all = {
    sel_all : function(idTable,n){	
	var sel = "select_all_lines_"+idTable;
	$("#"+ sel).unbind('click');// remove the clicks created by the first call of the function
	$("#"+ sel).click(function () { //reset display, all columns made visible again
	    var select = "Select all";
	    var unselect = "Unselect all";
	    var button = $(this).text();
	    if (button == unselect) {
		$(this).text(select);
		$("#" + idTable).find('.keep_line').prop('checked',false);//prop instead of attr jquery >= 1.6 
	    } else {
		if (button == select) {
		    $(this).text(unselect);
		    $("#" + idTable).find('.keep_line').prop('checked',true);
		}
	    }
	});
    }
}

//close samp connection before leaving page
$(window).on('beforeunload ', function() {
    page.sampUnregister();
});

$(document).ready(function () {
    page.hideLoader();
    page.initSamp();
    var clicked =false;
	
    $(".content").hide();
    $(".ascenseur").find("ul").hide();
    $(".content:first").show();
    $(".ascenseur:first").find("ul").show();
    $(".ascenseur:first").find("ul li.ascenseur2:first a").css("background-color","#8dbdd8");

    $('#' + page.exportButton).click(function (){//extract as text
	page.switchLoaderBar();
	setTimeout(function (){$('#'+page.exportArea).html(page.colManager.extractAsCsv(id));page.switchLoaderBar();}, 500);
    });
		
    $('#' + page.resetButton).click(function () {//reset display, all columns made visible again
	page.reset(id);
    });
    
    /*without any click on the parent li*/
    $(".ascenseur").find("ul li.ascenseur2 a").click(function(){
	$(".ascenseur").find("ul li.ascenseur2 a").css("background-color", '');
	$(".ascenseur").find("div.content:visible").hide();
	$(this).css({'background-color':'#8dbdd8'});
	$(this).parent().find("div.content").show();
    });
    
    var id = $("div.content:visible").attr('id');
    select_all.sel_all(id,1);
     
    $(".ascenseur a").click(function(){	
	page.reset(id);
	if($(this).parent().find("ul").is(":hidden")){
	    $(".ascenseur").find("div.content:visible").hide();
	    $(".ascenseur").find("ul:visible").slideUp();
	    $(this).parent().find("ul").slideDown();
	    $(this).parent().find("ul li.ascenseur2 a").css("background-color", '');//put the color origin
	    $(this).parent().find("ul li.ascenseur2 div.content:first").show();	
	    $(this).parent().find("ul li.ascenseur2:first a").css("background-color","#8dbdd8");
	    
	    $(this).parent().find("ul li.ascenseur2 a").click(function(){
		$(".ascenseur").find("ul li.ascenseur2 a").css("background-color", '');
		$(".ascenseur").find("div.content:visible").hide();
		$(this).css("background-color","#8dbdd8");
		$(this).parent().find("div.content").show();
	    }); 
	}else{
	    $(".ascenseur").find("ul li.ascenseur2 a").click(function(){
		$(".ascenseur").find("ul li.ascenseur2 a").css("background-color", '');
		$(".ascenseur").find("div.content:visible").hide();
		$(this).css("background-color","#8dbdd8");
		$(this).parent().find("div.content").show();
	    }); 
	}
	id = $(this).parent().find("div.content:visible").attr('id');
	select_all.sel_all(id,2);
    });

});
