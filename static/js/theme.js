$(function() {
    var url = window.location.href;
    var type;
    if (url.indexOf('/index.php/Home/Solution/status') !== -1)
        type = 'status';
    else if (url.indexOf('/index.php/Home/User/standings') !== -1)
        type = 'standings';
    else if (url.indexOf('/index.php/Home/User/info/uid') !== -1)
        type = 'info';
    else if (url.indexOf('/index.php/Home/Contest/conteststatus') !== -1)
        type = 'conteststatus';
    else if (url.indexOf('/index.php/Home/Contest/contestranklist') !== -1)
        type = 'ranklist';
    else
        type = 'status';
    if(hasPerm || sessionUid === 0) return;
    $("input[name='hid_uid'").each(function() {
        var uid = $(this)[0].value;
        var cls = uid2style[String(uid)];
        if (cls) {
            var cls_name = 'theme_' + cls + '_' + type;
            if (type != 'info')
                $(this).parent("tr").addClass(cls_name);
            else
                $(this).parent("div").parent("div").addClass(cls_name);
            console.log('add class: ' + cls_name)
        }
    })
});

