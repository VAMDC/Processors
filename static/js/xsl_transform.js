"use strict";

/**
 * page elements ids and manipulation
 */
var page = {
    
    loading : 'loader',
    hide_result_button : 'result',
    export_button : 'export',        
    reset_button : 'reset',
    export_area : 'result_ascii',
    table : {
        name : 'table',
        line_selector : 'select_all_lines',
        line_checker_class : 'keep_line',
        table_line_class : 'table-line',
        hideable_column : 'hideable',
        
        /**
         * check/uncheck all checkboxes
         */
        selectAllLines : function(){
                var select = "Select all";
                var unselect = "Unselect all";
                var button = $("#"+this.line_selector);
                if (button.text() === unselect ){
                    button.text(select);
                    $("."+this.line_checker_class).prop('checked', false);       //prop instead of attr jquery >= 1.6                        
                } else {
                    if (button.text() === select ){
                        button.text(unselect);
                        $("."+this.line_checker_class).prop('checked' ,true);
                    }
                }
            }        
    },             
        
    /**
    * display or hide loader bar accordint to current state
    */
    switchLoaderBar : function() {
        var state = $('#'+this.loading).css('display');
        if ( state == 'none' ) {
            this.show_loader;
        } else {
            this.hide_loader();
        }
        this.forceRedraw(document.getElementById(this.loading));
    },
    
    hide_loader : function(){
        $('#'+this.loading).hide();
    },

    show_loader : function(){
        $('#'+this.loading).show();
    },

    forceRedraw : function(element) {
        if (!element) { return; }

        var n = document.createTextNode(' ');
        var disp = element.style.display;  // don't worry about previous display style

        element.appendChild(n);
        element.style.display = 'none';

        setTimeout(function(){
            element.style.display = disp;
            n.parentNode.removeChild(n);
        },20);
    },

    /**
     * reset page display
     */
    reset : function(){
        col_manager.showAll();
        $('#'+this.export_area).html('');
        $("."+this.table.line_checker_class).prop('checked' ,true);
    },

    /**
     * hide export area 
     */
    hide_export :  function(){
        if ($("#"+this.hide_result_button).text() === 'Hide result') {
            $("#"+this.hide_result_button).text('Show result');
            $('#'+page.export_area).hide();
        } else {
            $("#"+this.hide_result_button).text('Hide result');
            $('#'+page.export_area).show();
        }
    }     
};

//manages column display
var col_manager = {    
    /**
     * list of hidden columns
     */
    hidden : [],
    
    /**
     * field separator for column extraction
     */
    separator : ',',        
    
    /**
     * hide a column by id
     */
    hide : function (column) {
        var position = this.position(column);
        $('td:nth-child(' + position + '),th:nth-child( ' + position + ')').hide();
        this.hidden[position] = true;        
    },
    
    /**
     * show a column by id
     */
    show : function (column) {
        var position = this.position(column);
        $('td:nth-child(' + position + '),th:nth-child( ' + position + ')').show();
        delete this.hidden[position];
    },
    
    /**
     * show all columns
     */
    showAll : function () {
        var key;
        for (key in this.hidden) {
            this.show(key);
        }
    },

    /**
     * export content of visible columns as ascii
     */
    extract : function () {
        var result = '#';
        var column = 1;
        var self = this;
        //get headers
        $('#'+page.table.name+' thead tr').children('th').each(function () {
            if (self.hidden[column] !== true) {
                result += $(this).children('.title').text() + self.separator;
            }
            column += 1;
        });

        result = result.substr(0, result.length - 1) + '\n';        
        column = 1;
                
        var t_lines = document.getElementById(page.table.name).getElementsByClassName(page.table.table_line_class);
        $(t_lines).each(function () {
            if (($(this).find('.'+page.table.line_checker_class).prop('checked')) === true){
                $(this).children('td').each(function (i) {
                    if (i > 0){ // first column is chkbx
                        if (self.hidden[column] !== true) {
                            result += $(this).text() + self.separator;
                        }                        
                    }
                    column += 1;
                });
                column = 1;
            }
            
            result = result.substr(0, result.length - 1) + "\n";
        });
        return result;
    },
    
    
    position : function (name) {
        return name.replace('c', '');
    }
};

$(document).ready(function () {
    
    page.hide_loader(); 
    
    $("#"+page.table.name).tablesorter( {
        headers: {0: {sorter: false}}
    });
       

    $('#'+page.export_button).click(function () {    //extract as text
        page.switchLoaderBar();
        setTimeout(function (){$('#'+page.export_area).html(col_manager.extract());page.switchLoaderBar();}, 500);        
    });  
    
    $('#'+page.reset_button).click(function () { //reset display, all columns made visible again
        page.reset();
    });

    $('#'+page.table.line_selector).click(function () { //reset display, all columns made visible again
        page.table.selectAllLines();
    });
    
    $('.'+page.table.hideable_column).click(function (event) {
        col_manager.hide($(this).parent().attr('id'));
        event.stopPropagation();
    });

    $('#'+page.hide_result_button).click(function () {
        page.hide_export();
    });
});
