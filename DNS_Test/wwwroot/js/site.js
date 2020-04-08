var selectedId;
var page = 0;
function getPages() {
    $.ajax({
        url: '/Home/GetPage',
        type: 'POST',
        data: { pages: $("#countSelected").val() },
        success: function (json) {
            $("#pageNumber").attr({ "max": json, "min": 1 , "value" : 1});
        }
    });
    ShowEmployees();
}
function ShowEmployees() {
    var data = $('#Show').serializeArray();
    var output = $('#result');
    $("#resultOf").empty();
    $.ajax({
        url: '/Home/ShowEmployees',
        type: 'GET',
        data: data,
        success: function (json) {
            output.html(json);
        }
    });
}
$(document).on('click', ".rows", function () {
    $(this).parent().find(".rows").removeClass("selected_row");
    $(this).parent().find("#buttonSection").remove();
    $(this).toggleClass("selected_row");

    selectedId = $(this).find('#number').text();

    var btnSection = document.createElement('div');
    btnSection.id = "buttonSection";
    var btnShow = document.createElement('button');
    btnShow.innerText = "Подчиненные";
    btnShow.className = 'btn btn-primary';
    btnShow.addEventListener('click', buttonAction.bind(null, '/Home/ShowChiefs', 'POST'));
    var btnDel = document.createElement('button');
    btnDel.innerText = "Удалить сотрудника";
    btnDel.className = 'btn btn-primary';
    btnDel.addEventListener('click', buttonAction.bind(null, '/Home/DeleteEmployee', 'GET'));
    btnSection.append(btnShow, btnDel);
    $(this).children().last().append(btnSection);
});


function buttonAction(link, method) {
    var output = $('#resultOf');
    $.ajax({
        url: link,
        type: method, 
        data: { id: window.selectedId },
        success: function (json) {
            output.html(json); 
        }
    });
};
$().ready(function () {
    getPages();
    ShowEmployees();
})