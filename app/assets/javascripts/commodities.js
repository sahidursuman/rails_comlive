var ready, table;
var renderOptions = function(options, select){
    var opts = [];
    opts.push($('<option>').val("").text('Select Chapter'));
    options.forEach(function(option){
        var opt = $('<option>').val(option.id).text(option.description);
        opts.push(opt);
    });
    select.html(opts);
}

var select2For = function(select){
    url = select.data("url");

    select.select2({
        ajax: {
            url: url,
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term
                    page: params.page || 1
                };
            },
            processResults: function (data, params) {
                // parse the results into the format expected by Select2
                // since we are using custom formatting functions we do not need to
                // alter the remote JSON data, except to indicate that infinite
                // scrolling can be used
                params.page = params.page || 1;

                return {
                    results: $.map(data.items, function(item){
                        return {
                            text: item.short_description,
                            id: item.id
                        }
                    }),
                    pagination: {
                        more: !data.last_page
                    }
                };
            },
            cache: true
        },
        minimumInputLength: 1,
        width: '100%'
    });
}

ready = function(){
    // fix for selec2 inside bootstrap modal
    $.fn.modal.Constructor.prototype.enforceFocus = function() {};

    $("input#commodity_generic").change(function(){
        var checked = $(this).is(":checked");
        var select = $("select#commodity_brand_id");

        if(checked){
            select.prop("selectedIndex", 0);
            select.hide();
        } else {
            select.show();
        }
    });

    $("button#assign-hscode").click(function(e){
        e.preventDefault();

        var form = $(this).parents('.modal-content').find("form");
        form.submit();
    });

    $("select#commodity_hscode_section_id").change(function(){
        var selected = $(this).find(":selected");
        var value    = selected.val();
        var url      = $(this).data("href");

        var child_select = $("select#commodity_hscode_chapter_id");
        child_select.html('<option>Loading....</option>');
        $("select#commodity_hscode_heading_id").html('<option value="">Select Heading</option>');
        $("select#commodity_hscode_subheading_id").html('<option value="">Select Sub Heading</option>');

        $.ajax({
            type: "GET",
            url: url,
            data: { hscode_section_id: value },
            success: function(data){
                renderOptions(data, child_select);
            }
        });
    });

    $("select#commodity_hscode_chapter_id").change(function(){
        var selected = $(this).find(":selected");
        var value    = selected.val();
        var url      = $(this).data("href");

        var child_select = $("select#commodity_hscode_heading_id");
        child_select.html('<option>Loading....</option>');

        $.ajax({
            type: "GET",
            url: url,
            data: { hscode_chapter_id: value },
            success: function(data){
                renderOptions(data, child_select);
            }
        });
    });

    $("select#commodity_hscode_heading_id").change(function(){
        var selected = $(this).find(":selected");
        var value    = selected.val();
        var url      = $(this).data("href");

        var child_select = $("select#commodity_hscode_subheading_id");
        child_select.html('<option>Loading....</option>');

        $.ajax({
            type: "GET",
            url: url,
            data: { hscode_heading_id: value },
            success: function(data){
                renderOptions(data, child_select);
            }
        });
    });

    table = $('table#unspsc_segments').DataTable({
        pagingType: "full_numbers",
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $('table#unspsc_segments').data('source'),
        "order": []
    });

    $("a.load-in-modal").click(function(e){
        e.preventDefault();

        var url = $(this).attr("href");
        var title = $(this).text();

        $( "#sharedModal .modal-body" ).load(url, function(response,status,xhr) {
            var modalBody =  $( "#sharedModal .modal-body" );

            $("#sharedModal .modal-header h4.modal-title").text(title);

            // hide elements
            modalBody.find('h4.header-title').hide();
            modalBody.find("p.text-muted").hide();
            modalBody.find("form input[type='submit']").hide();

            $("#sharedModal").modal();

            // additional scripts
            var source_commodity = $("#reference_source_commodity_id");
            var target_commodity = $("#reference_target_commodity_id");
            if(source_commodity.length && target_commodity.length){
                select2For(source_commodity);
                select2For(target_commodity);
            }

            var measurementProperty =  $("select#measurement_property");
            if(measurementProperty.length){
                measurementPropertyCallbacks();
            }
        });
    });

    $("button#submit-modal-form").click(function(e){
        e.preventDefault();

        var form = $("#sharedModal").find("form");
        form.submit();
    });

    // additional scripts
    var source_commodity = $("#reference_source_commodity_id");
    var target_commodity = $("#reference_target_commodity_id");
    if(source_commodity.length && target_commodity.length){
        select2For(source_commodity);
        select2For(target_commodity);
    }
}

$(document).on("click", "a.unspsc-drilldown", function(e){
    e.preventDefault();

    var url = $(this).data("href");
    var type = $(this).data("type");
    table.ajax.url(url).load();

    $('#unspsc_segments caption').text("UNSPSC " + type);
});

$(document).on("click","a.assign-unspsc", function(e){
    e.preventDefault();

    var url = $("#unspsc_segments").data("submit-url");
    var unspsc_commodity_id = $(this).data("id");

    $.ajax({
        type: "PATCH",
        url: url,
        data: { commodity: { unspsc_commodity_id: unspsc_commodity_id } }
    });
})

$(document).ready(ready);