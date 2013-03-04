"use strict";

//manages column display
var col_manager = {
    /**
     * list of hidden columns
     */
    hidden : [],
    
    /**
     * hide a column by id
     */
    hide : function (column) {
        var position = this.position(column);
        $('td:nth-child(' + position + '),th:nth-child( ' + position + ')').hide();
        this.hidden[column] = true;        
    },
    
    /**
     * show a column by id
     */
    showColumn : function (column) {
        var position = this.position(column);
        $('td:nth-child(' + position + '),th:nth-child( ' + position + ')').show();
        delete this.hidden[column];
    },
    
    /**
     * show all columns
     */
    showAll : function () {
        var key;
        for (key in this.hidden) {
            this.showColumn(key);
        }
    },

    /**
     * export content of visible columns as ascii
     */
    extract : function () {
        var result = '#';
        var separator = ',';
        var column = 1;
        $('#myTable thead tr').children('th').each(function () {
            if (this.hidden[column] !== true) {
                result += $(this).text().replace('X', '') + separator;
            }
            column = column + 1;
        });

        result = result.substr(0, result.length - 1) + '\n';

        column = 1;
        $('#myTable tbody').children('tr').each(function () {
            $(this).children('td').each(function () {
                if (this.hidden[column] !== true) {
                    result += $(this).text() + separator;
                }
                column = column + 1;
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

$(document).ready(function () {
    $("#myTable").tablesorter();

    $('#export').click(function () {
        $('#result_ascii').text(col_manager.extract());
    });
    
    $('#reset').click(function () {
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
