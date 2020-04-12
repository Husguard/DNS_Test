var selectedId;
var page = 0;
var todelete;
function GetPages() {
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
    var output = $('#mainEmployees');
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
function ShowSuggests(e) {
    $("#suggests").empty();
    if (e.value.length > 0) {
        $.ajax({
            url: '/Home/GetSuggests',
            type: 'POST',
            data: { name: e.value },
            success: function (json) {
                for (var i = 0; i < json.length; i++) {
                    var btnShow = document.createElement('a');
                    btnShow.innerText = json[i];
                    btnShow.addEventListener('click', function () {
                        $("#Chief_Name").val(btnShow.innerText); // учитывается последний элемент
                        $("#suggests").empty();
                    });
                    $("#suggests").append(btnShow);
                }
            }
        });
    }
}
$(document).on('click', ".rows", function () {
    $(this).parent().find(".rows").removeClass("selected_row");
    $(this).parent().find("#buttonSection").remove();
    $(this).toggleClass("selected_row");

    selectedId = $(this);

    var btnSection = document.createElement('div');
    btnSection.id = "buttonSection";
    var btnShow = document.createElement('button');
    btnShow.innerText = "Подчиненные";
    btnShow.className = 'btn btn-primary';
    btnShow.addEventListener('click', buttonAction.bind(null, '/Home/ShowChiefs', 'POST'));
    var btnDel = document.createElement('button');
    btnDel.innerText = "Удалить сотрудника";
    btnDel.className = 'btn btn-primary';
    btnDel.addEventListener('click', buttonAction.bind(null, '/Home/DeleteEmployee', 'GET')); // либо убрать подтверждение и сразу вызывать ajax метод удаления
    btnSection.append(btnShow, btnDel);
    $(this).children().last().append(btnSection);
});


function buttonAction(link, method) {
    var output = $('#resultOf');
    $.ajax({
        url: link,
        type: method, 
        data: { id: window.selectedId.find('#number').text() },
        success: function (json) {
            output.html(json);
            selectedId.remove();
        }
    });
};
$().ready(function () {
    GetPages();
    $('input[name="column"]').on('change', function () { ShowEmployees(); });
    $('input[name="page"]').on('change', function () { ShowEmployees(); });
    $('input[name="sort"]').on('change', function () { ShowEmployees(); });
});