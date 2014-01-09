var getTime = 5000,
    lastId = 0;

$(document).ready(function() {
    if($('#received-messages').is('*')) {
        setTimeout(function(){getMessages()}, getTime);
    }

    $(document).on('click', ".answer_message", function(){
        var receiver_id = $(this).data("receiver-id"),
         message = $(this).parent().prev().prev().val();
        $.ajax(
        {
            type: 'GET',
            url: "/messages/send/" + receiver_id + "/" + message,
            async: true,
            success: function(data)
            {
                $(this).prev().val('');
                alert("bericht verzonden aan " + data.firstname);
            }
        });

        parent = $(this).parent();
        parent.prev().prev().remove();
        parent.prev().remove();
        parent.prev().parent().append('<div class="btn-group btn-group-ms"><button class="btn btn-primary disabled" type="button" role="button">Verstuurd <i class="fa fa-check"></i></button></div>');
        parent.remove();

    });

    $(document).on('click', ".answer_message_web", function(){
        var receiver_id = $(this).data("receiver-id-web"),
            message_id = $(this).parent().prev().prev().attr('id'),
            body = $(this).parent().prev().prev().val();
        $.ajax(
            {
                type: 'GET',
                url: "/messages/react_web/" + receiver_id + "/" + body + "/" + message_id,
                async: true,
                success: function(data)
                {
                    $(this).prev().val('');
                    alert (message_id);
                    alert("bericht verzonden aan ");
                }
            });

        parent = $(this).parent();
        parent.prev().prev().remove();
        parent.prev().remove();
        parent.prev().parent().append('<div class="btn-group btn-group-ms"><button class="btn btn-primary disabled" type="button" role="button">Geholpen <i class="fa fa-check"></i></button></div>');
        parent.remove();

    });
});

function getMessages() {
    call(buildTable);
    setTimeout(function(){getMessages()}, getTime);
}

function call(func){
    $.ajax(
    {
        type: 'GET',
        url: "/messages/reload/" + getId(),
        url: "/messages/reload/" + getId(),
        async: true,
        success: function(data)
        {
            func(data);
        }
    });
}

function buildTable(data) {
    for (var item in data) {
        buildTr(data[item]);
    }
}

function buildTr(item) {
    var tr = '' +
        '<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">' +
        '<div class="panel panel-danger panel_va ">' +
        '<div class="panel-heading">' +
        '<h5>' + item.userName +' stuurde op ' + item.message.created_at + '</h5>' +
        '</div>' +
        '<div class="panel-body">' +
        '<p>' + item.message.body + '</p>' +
        '<textarea class="form-control" id="' + item.message.id + ' name="' + item.message.id + '" placeholder="Stuur wat terug!"></textarea>' +
        '<br />' +
        '<div class="btn-group btn-group-ms">' +
        '<button data-receiver-id="' + item.message.id + '" type="button" role="button" class="answer_message btn btn-success">Reageren <i class="fa fa-envelope"></i></button>' +
    '</div></div>' +
        '</div>';

    $('#received-messages').prepend(tr);
    setId(item.message.id);
}

function setId(id) {
    lastId = id;
}

function getId() {
    return lastId;
}

