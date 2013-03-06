"use strict";

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
        $('#myTable thead tr').children('th').each(function () {
            if (self.hidden[column] !== true) {
                result += $(this).children('.title').text() + self.separator;
            }
            column += 1;
        });

        result = result.substr(0, result.length - 1) + '\n';
        
        column = 1;
        //get data
        $('#myTable tbody').children('tr').each(function () {
            $(this).children('td').each(function () {
                if (self.hidden[column] !== true) {
                    result += $(this).text() + self.separator;
                }
                column += 1;
            });
            column = 1;
            result = result.substr(0, result.length - 1) + "\n";
        });
        return result;
    },
    
    
    position : function (name) {
        return name.replace('c', '');
    }
};

/**
 * display or hide loader bar accordint to current state
 */
var switchLoaderBar = function() {
    var state = $('#loader').css('display');
    if ( state == 'none' ) {
        $('#loader').show();      
    } else {
        $('#loader').hide();
    }
    forceRedraw(document.getElementById('loader'));
};

/**
 * force page redraw to display loader bar
 */
var forceRedraw = function(element) {
    if (!element) { return; }

    var n = document.createTextNode(' ');
    var disp = element.style.display;  // don't worry about previous display style

    element.appendChild(n);
    element.style.display = 'none';

    setTimeout(function(){
        element.style.display = disp;
        n.parentNode.removeChild(n);
    },20);
}

$(document).ready(function () {
    $("#myTable").tablesorter();
    
    $('#loader').hide(); //loader bar is hidden

    $('#export').click(function () {    //extract as text
        switchLoaderBar();  
        setTimeout(function (){$('#result_ascii').html(col_manager.extract());switchLoaderBar();}, 500);        
    });  
    
    $('#reset').click(function () { //reset display, all columns made visible again
        col_manager.showAll();
        $('#result_ascii').html('');
    });
    
    $('.hideable').click(function (event) {
        col_manager.hide($(this).parent().attr('id'));
        event.stopPropagation();
    });

    $('#result').click(function () {
        if ($(this).text() === 'Hide result') {
            $(this).text('Show result');
            $('#result_ascii').hide();
        } else {
            $(this).text('Hide result');
            $('#result_ascii').show();
        }
    });
});
