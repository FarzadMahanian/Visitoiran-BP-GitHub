
function initHotelFilter(wrapper) {

    wrapper.find( '.checkin>input, .checkout>input').vestadp({
        dateFormat: "yy/mm/dd",
        direction: "ltr",
        showFooter: false,
        persianNumbers: false,
        language: 'en',
        calendar: "gregorian"
    });

    $.fn.search.settings.templates.customType = function (response, fields) {
        var html = '';
        if (response[fields.results] !== undefined) {

            // each result
            $.each(response[fields.results], function (index, result) {
                var icon;
                switch (result.SearchType) {
                    case 6:
                        icon = 'hotel';
                        break;
                    case 2:
                    case 3:
                    default:
                        icon = 'marker';
                        break;
                }
                html += '<a class="result">';
                html += ' <i class="icon ' + icon + '"></i>';
                html += '<span class="title">' + result.Destination + '</span>';
                html += '</a>';
            });
            return html;
        }
        return false;
    };

    wrapper.find('.ui.search')
        .search({
            type: 'customType',
            minCharacters: 4,
            apiSettings: {
                // this url parses query server side and returns filtered results
                url: 'hotel/autocomplete/{query}',
                onResponse: function(response) {
                    var newResponse = {
                        results: response
                    };
                    return newResponse;
                }
            },
            onSelect: function(result, response) {
                $(this).data('selected-item', result);
            },
            saveRemoteData: false
        });

    setTimeout(function(){
        wrapper.find("#roomInfo").roomDetail();
    });

    wrapper.find('.btn-search').click(function(){

        var item = wrapper.find('.ui.search').data('selected-item'),
            hasError = false;
        if (!wrapper.find('.ui.search').search('get value') || !item || !item.Destination) {
            wrapper.find('.ui.search>input').addClass('has-error');
            hasError = true;
        }

        var checkinDate = wrapper.find('.checkin>input').vestadp('getDate', true, 'yy-mm-dd');
        if (!checkinDate) {
            wrapper.find('.checkin>input').addClass('has-error');
            hasError = true;
        }


        var checkoutDate = wrapper.find('.checkout>input').vestadp('getDate', true, 'yy-mm-dd');
        if (!checkoutDate) {
            wrapper.find('.checkout>input').addClass('has-error');
            hasError = true;
        }

        var roomDetails = wrapper.find("#roomInfo").roomDetail('getRoomDetails');
        if (!roomDetails || !roomDetails.length) {
            wrapper.find("#roomInfo").addClass('has-error');
            hasError = true;
        }

        if (hasError) {
            return;
        }

        var adults = 0,
            children = 0;

        $.each(roomDetails, function(i, r){
            adults += r.adult;
            children += r.child;
        });

        if(item.SearchType == 6) {
            document.location.assign( document.location.origin + "/hotel/8503");
        }else {
            document.location.assign( document.location.origin + "/hotel/all?"+
                "destination=" + item.Destination+
                "&arrivalDate="+checkinDate+
                "&departureDate="+checkoutDate+
                "&numberOfAdults="+adults+
                "&numberOfChildren="+children+
                "&numberOfRoom="+roomDetails.length);
        }

    });

}
