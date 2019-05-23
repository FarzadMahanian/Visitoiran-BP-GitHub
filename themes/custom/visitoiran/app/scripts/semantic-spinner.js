(function ($) {
    $.fn.semanticSpinner = function (method) {

        var methods = {
            init: function (options) {
                var opts = $.extend({}, $.fn.semanticSpinner.defaults , options);
                return this.each(function (index, element) {
                    methods._renderSpinner($(element), opts);
                });
            },
            _renderSpinner: function(element, options){
                var plusButton = $('<button class="ui button"><i class="icon plus"></i></button>');
                var minusButton = $('<button class="ui button"><i class="icon minus"></i></button>');
                var mainWrapper = $('<div class="ui buttons spinner small">');
                element.addClass('between-btn');
                element.wrap(mainWrapper);
                element.before(minusButton);
                element.after(plusButton);
                plusButton.click(function() {
                    var oldVal = parseInt(element.text())
                    var val = oldVal+1;
                    if (options.maxValue>=val){
                        element.text(val);
                        options.onChange.call(element, val, oldVal);
                    }
                });
                minusButton.click(function() {
                    var oldVal = parseInt(element.text())
                    var val = oldVal-1;
                    if (options.minValue <= val) {
                        element.text(val);
                        options.onChange.call(element, val, oldVal);
                    }
                });
            }
        }

        // Method calling logic
        if (method!= 'init' && methods[method] && method.charAt(0) != '_') {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.semanticSpinner');
        }
    }

    $.fn.semanticSpinner.defaults = {
        minValue : 0,
        maxValue : 100,
        onChange: function(value, oldValue) {}
    }
})(jQuery);

(function ($) {
    $.fn.roomDetail = function (method) {
        var methods = {
            init: function (opts) {
                var options = $.extend({}, $.fn.roomDetail.defaultsOptions , opts);
                return this.each(function (index, element) {
                    methods._renderPlugin($(element), options);
                });
            },
            getRoomDetails: function() {
                return $(this).data('room-details');
            },
            addRoom: function(roomDetail, popupContent) {
                var element = $(this),
                    roomDetails = element.data('room-details'),
                    roomCount = element.data('room-count'),
                    roomRows = popupContent ? popupContent.find('.room-rows') : element.parent().find('.custom.popup .room-rows');
                roomDetails.push(roomDetail);
                var index = roomDetails.length;
                var rowContent = $('<tr><td>#'+index+'</td><td><div class="spinner adult" >'+roomDetail.adult+'</div></td><td><div class="spinner child">'+roomDetail.child+'</div></td><td><a class="'+(roomCount>1?'':'invisible')+'" ><i class="icon close"></i></a></td></tr>');
                rowContent.data('room-detail', roomDetail);
                roomRows.append(rowContent);
                rowContent.find('.spinner').semanticSpinner({
                    onChange: function(val, oldVal) {
                        if ($(this).hasClass('adult')){
                            roomDetail.adult += val - oldVal;
                        }
                        if ($(this).hasClass('child')){
                            roomDetail.child += val - oldVal;
                        }
                        methods._renderText(element, roomDetails);
                    }
                });
                rowContent.find('i.close').click(function() {
                    var index = roomDetails.indexOf(roomDetail);
                    roomDetails.splice(index, 1);
                    methods._renderRoomDetails(element, roomDetails, popupContent);
                });
                methods._renderText(element, roomDetails);
            },
            _renderPlugin: function(element, options) {
                var popupContent = $('<div class="ui custom popup top left transition hidden"><table class="ui center aligned very basic  table rooms"><thead><tr><th>Room</th><th width="100">Adult</th><th width="100">Child</th><th class="actions"><button class="circular blue tiny ui icon button add-room"><i class="icon plus"></i></button></th></tr></thead><tbody class="room-rows"></tbody></table></div>');
                element.parent().append(popupContent);
                element.popup({
                    popup: $('.custom.popup'),
                    on: 'click',
                    position: 'bottom center',
                    delay: {
                        show: 300,
                        hide: 2000
                    }
                });
                element.data('options', options);
                methods._renderRoomDetails(element, options.roomDetails, popupContent);
                popupContent.find('button.add-room').click(function(){
                    var roomDetails = element.data('room-details');
                    roomDetails.push({adult:1, child:0});
                    methods._renderRoomDetails(element, roomDetails, popupContent);
                });
            },
            _renderRoomDetails : function(element, roomDetails, popupContent) {
                element.data({
                    'room-details': [],
                    'room-count': roomDetails.length
                });
                popupContent.find('.room-rows').empty();
                for (var i = 0; i < roomDetails.length; i++) {
                    methods.addRoom.call(element, roomDetails[i], popupContent);
                }
            },
            _renderText : function(element, roomDetails) {
                var options = element.data('options');
                var room = roomDetails.length,
                    child = 0,
                    adult = 0;
                $.each(roomDetails, function(i, item){
                    child += item.child;
                    adult += item.adult;
                });
                var text = options.textTemplate.replace('{{room}}', room).replace('{{adult}}', adult).replace('{{child}}', child);
                element.val(text);
            }
        }

        // Method calling logic
        if (method!= 'init' && methods[method] && method.charAt(0) != '_') {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + method + ' does not exist on jQuery.roomDetail');
        }
    }

    $.fn.roomDetail.defaultsOptions = {
        textTemplate: "Rooms: {{room}} - Adults: {{adult}} - Children: {{child}}",
        roomDetails: [{adult:1, child:0}]
    };
})(jQuery);
