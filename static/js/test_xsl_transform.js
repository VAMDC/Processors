"use strict";

function Source(id, title, category, name, authors, uri){
  this.id = id;
  this.title = title;
  this.category= category;
  this.name = name;
  this.authors = authors;
  this.uri = uri;
}

function isIE() { 
  return ((navigator.appName == 'Microsoft Internet Explorer') || 
            ((navigator.appName == 'Netscape') && (new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})").exec(navigator.userAgent) != null))); 
}


var sourceExtractor = {
  separator :  '::',   
  
  getSources : function(source){
    var results = [];
    var sources = source.split('#');
    for(var i = 0; i< sources.length; i++){
      var parts = sources[i].split(this.separator);
      results[i]= new Source(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
    }
    return results;
  }
}


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
    this.hide = function (column) {
      var position = this.getPosition(column);
      $('#'+page.table.name+' td:nth-child(' + position + '),'+'#'+page.table.name+' th:nth-child( ' + position + ')').hide();
      this.hidden[column] = true;
    }
    
    /**
     * show a column by id
     */
    this.show = function (column) {        
      var position = this.getPosition(column);        
      $('#'+page.table.name+' td:nth-child(' + position + '),'+'#'+page.table.name+' th:nth-child( ' + position + ')').show();
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
       
    
    this.showResult = function( content ){
      $("#result_export").text(content);
    }
    
    
    /**
     * export content of visible columns as json
     */    
    this.extractAsJson = function () {
        var result = '{ "node" : "' + $('#queried_node').text()+'", \n';
        var self = this;
        //var t_lines = document.getElementById(page.table.name).getElementsByClassName(page.table.tableLineClass);
        var t_lines = $("."+page.table.tableLineClass);
        var col_id;
        
        var sources = sourceExtractor.getSources($.trim($('#sources_text').text()));
        result += ' "sources" :  [ ';
        for(var i = 0;i<sources.length;i++){
          if(sources[i] != undefined) {
            result += '{ "id": "' + ((sources[i].id === undefined) ? '' : $.trim(sources[i].id) ) + '",\n' ;           
            result += '"title": "' + ((sources[i].title === undefined) ? '' : $.trim(sources[i].title)) + '",\n' ;
            result += '"category": "' + ((sources[i].category === undefined ) ? '' : $.trim(sources[i].category)) +'",\n' ;
            result += '"name": "' + ((sources[i].name === undefined ) ? '' : $.trim(sources[i].name)) +'",\n' ;
            result += '"authors": "' + ((sources[i].authors === undefined ) ? '' : $.trim(sources[i].authors)) +'",\n' ;
            result += '"uri": "' + ((sources[i].uri === undefined ) ? '' : $.trim(sources[i].uri)) +'"}\n' ;     
          }
          if(i < sources.length-1)
            result += ", ";
        }
        result += '], ';
        result += ' "data" : [';
        //get headers
        var headers = {};
        $('#' + page.table.name + ' thead tr').children('th').each(function () {
            col_id = $(this).attr('id');
            if (self.hidden[col_id] !== true && col_id !== 'c1') {     
              var header = $.trim($(this).children('.title').text()).split("(");
              headers[col_id] =  header[0].replace(" " , "_").toLowerCase();
            }
        });
        
         
        $(t_lines).each(function () {
            if (($(this).find('.'+page.table.lineCheckerClass).prop('checked')) === true){ 
                result += "{ ";
                $(this).children('td').each(function (i) {
                    col_id = $(this).attr('data-columnid');
                    if (i > 0){ // first column is chkbx
                        if (self.hidden[col_id] !== true) {
                          //console.log('#'+headers[col_id].replace(' ', '_').toLowerCase()+"#");
                          result += '"' + headers[col_id] + '"' + ': "'+ $(this).text() + '", \n';
                        }
                    }
                });
                result = result.substring(0, result.length-3) + "\n";
                result += "},";                
            }            
        });        
        
        result = result.substring(0, result.length-1)+" ]\n}";
        this.showResult(JSON.stringify(JSON.parse(result),null,4));
    }

    /**
     * export content of visible columns as ascii
     */
    this.extractAsCsv = function () {
        var result = '#Queried node : ' + $('#queried_node').text()+"\n";
        var self = this;
        //var t_lines = document.getElementById(page.table.name).querySelectorAll("."+page.table.tableLineClass);
        var t_lines = $("."+page.table.tableLineClass);
        var col_id;
        
        result += $.trim($('#sources_text').text());//.trim();
        result += "\n#";
        //get headers
        $('#' + page.table.name + ' thead tr').children('th').each(function () {
            col_id = $(this).attr('id');
            if (self.hidden[col_id] !== true && col_id !== 'c1') {
                result += $(this).children('.title').text() + self.separator;
            }
        });

        result = result.substr(0, result.length - 1) + '\n';
        
        $(t_lines).each(function () {
            if (($(this).find('.'+page.table.lineCheckerClass).prop('checked')) === true){ 
                $(this).children('td').each(function (i) {
                    col_id = $(this).attr('data-columnid');
                    if (i > 0){ // first column is chkbx
                        if (self.hidden[col_id] !== true) {
                            result += $(this).text() + self.separator;
                        }
                    }
                });
            }
            result = result.substr(0, result.length - 1) + "\n";
        });
        this.showResult(result);
    }
    
    /**
     * export content of visible columns as ascii
     */
    this.extractAsVoTable = function () {
        var result = '<VOTABLE version="1.2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '+
                        'xmlns="http://www.ivoa.net/xml/VOTable/v1.2">\n'+
                        '<RESOURCE>\n'+
                        '<TABLE name="results">\n'+
                        '<DESCRIPTION>votable export</DESCRIPTION>\n';

        var col_id;
        var i = 1;
        var self = this;
        //get headers
        $('#' + page.table.name + ' thead tr').children('th').each(function () {
        col_id = $(this).attr('id');
            if (self.hidden[col_id] !== true  && col_id !== 'c1' ) {
                var obj = eval('columns_fields.' + $(this).attr('id'));
                result += '<FIELD ID="col'+i+'" name="'+$(this).children('.title').text() + '" datatype="' + obj.datatype + '" arraysize="' + obj.arraysize + '" unit="' + obj.unit + '"/>\n';
                i += 1;
            }
        });
        
        result += '<DATA><TABLEDATA>\n';
    
        //var t_lines = document.getElementById(page.table.name).getElementsByClassName(page.table.tableLineClass);
        var t_lines = $("."+page.table.tableLineClass);
        $(t_lines).each(function () {
            if (($(this).find('.' + page.table.lineCheckerClass).prop('checked')) === true){
                result += "<TR>\n";
                $(this).children('td').each(function (i) {
                    col_id = $(this).attr('data-columnid');
                    if (i > 0){ // first column is chkbx
                        if (self.hidden[col_id] !== true) {
                            result += '<TD>' + $(this).text().replace(/\u00a0/g, " ") + '</TD>\n';
                        }
                    }
                });
                result += "</TR>\n";
            }
        });
        
        result += '</TABLEDATA>\n</DATA>\n</TABLE>\n</RESOURCE>\n</VOTABLE>\n';
        this.openFile(result);
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
    csvExportButton : 'csv_export',
    jsonExportButton : 'json_export',
    votableExportButton : 'votable_export',
    sampSendButton : 'votable_samp',
    resetButton : 'reset',
    sampConnectionButton : 'samp_connection',
    exportArea : 'result_export',
    isSampConnected : false,
    connector : null,
    table : {
        name : 'transitions',
        lineSelector : 'select_all_lines',
        lineCheckerClass : 'keep_line',
        tableLineClass : 'table-line',
        hideableColumn : 'hideable',
        
        /**
         * check/uncheck all checkboxes
         */
        selectAllLines : function() {
            var select = "Select all";
            var unselect = "Unselect all";
            var button = $("#" + this.lineSelector);
            if (button.text() === unselect) {
                button.text(select);
                $("." + this.lineCheckerClass).prop('checked', false); //prop instead of attr jquery >= 1.6
            } else {
                if (button.text() === select) {
                    button.text(unselect);
                    $("." + this.lineCheckerClass).prop('checked', true);
                }
            }
        }
    },    
       
    /**
    * display or hide loader bar accordint to current state
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
    
    hideExportArea : function() {
        $('#' + this.exportArea).hide();
    },

    showExportArea : function() {
        $('#' + this.exportArea).show();
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
    reset : function() {
        this.colManager.showAll();
        $('#' + this.exportArea).html('');
        $("." + this.table.lineCheckerClass).prop('checked', true);
        page.hideExportArea();
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
    broadcastTable : function(){
    var urlSubmit = 'http://xsams-processors.obspm.fr/webtools/recordtable';
    var path = window.location.pathname.split('/');
    var req = {'table': page.colManager.extractAsVoTable(), 'table_id' : path[path.length-1]};   
		$.ajax({
			type: "POST",
			url: urlSubmit,
			data : req,
			success: function(data) {
               page.sampSend(data);
            },
            error : function(xhr, status, error){
                alert(xhr.error);                
            }
	});
		return false;
    }
}


//close samp connection before leaving page
$(window).on('beforeunload ', function() {
    page.sampUnregister();
});

$(document).ready(function () {
  
    page.hideExportArea();
    page.hideLoader();
    page.initSamp();

    $("#" + page.table.name).tablesorter( {
        headers: {0: {sorter: false}}
    });

    $('#' + page.csvExportButton).click(function () {    //extract as text
        //page.switchLoaderBar();
        setTimeout(function (){ page.showExportArea();$('#'+page.exportArea).html(page.colManager.extractAsCsv());/*page.switchLoaderBar();*/}, 500);
    });

    $('#' + page.jsonExportButton).click(function () {    //extract as text
        //page.switchLoaderBar();
        setTimeout(function (){ page.showExportArea();$('#'+page.exportArea).html(page.colManager.extractAsJson());/*page.switchLoaderBar();*/}, 500);
    });
    
    $('#' + page.votableExportButton).click(function () {    //extract as text
        //page.switchLoaderBar();
        setTimeout(function (){ page.showExportArea();$('#'+page.exportArea).html(page.colManager.extractAsVoTable());/*page.switchLoaderBar();*/}, 500);
    });

    $('#' + page.resetButton).click(function () { //reset display, all columns made visible again
        page.reset();
    });

    $('#' + page.table.lineSelector).click(function () { //reset display, all columns made visible again
        page.table.selectAllLines();
    });
    
    $('.' + page.table.hideableColumn).click(function (event) {
        page.colManager.hide($(this).parent().attr('id'));
        event.stopPropagation();
    });
    
	// Formulaire POST AJAX
	$("#" + page.sampSendButton).click( function() {
        ajax_request.broadcastTable();
	});
});
