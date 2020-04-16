var selectedId = undefined;
var page = 0;
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
    $("#suggests").hide();
    if (e.value.length > 0) {
        $.ajax({
            url: '/Home/GetSuggests',
            type: 'POST',
            data: { name: e.value },
            success: function (json) {
                for (var i = 0; i < json.length; i++) {
                    var btnShow = document.createElement('a');
                    btnShow.innerText = json[i];
                    btnShow.addEventListener('click', function () { // здесь нужен стиль для выпадающего списка
                        $("#Chief_Name").val(this.innerText);
                        $("#suggests").hide();
                    });
                    $("#suggests").append(btnShow);
                    $("#suggests").show();
                }
            }
        });
    }
}
$(document).on('click', "tr", function () {
    if (selectedId != undefined) {
        selectedId.parent().find("tr").removeClass("selected_row");
        selectedId.parent().find("#buttonSection").remove();
    }
    selectedId = $(this);
    selectedId.toggleClass("selected_row");
    var btnSection = document.createElement('div');
    btnSection.id = "buttonSection";
    var btnShow = createButton('Подчиненные', '/Home/ShowChiefs', 'POST');
    var btnDel = createButton('Удалить сотрудника', '/Home/DeleteEmployee', 'GET');
    btnSection.append(btnShow, btnDel);
    $(this).children().last().append(btnSection);
});
function createButton(innerText, url, method) {
    var btn = document.createElement('button');
    btn.innerText = innerText;
    btn.className = 'btn btn-primary';
    btn.addEventListener('click', function () {
        var output = $('#resultOf');
        $.ajax({
            url: url,
            type: method,
            data: { id: window.selectedId.find('#number').text() },
            success: function (json) {
                output.html(json);
                // можно попробовать здесь находить кнопку выхода и давать ей функцию
            }
        });
    });
    return btn;
}
$().ready(function () {
    GetPages();
    $('input[name="column"]').on('change', function () { ShowEmployees(); });
    $('input[name="page"]').on('change', function () { ShowEmployees(); });
    $('input[name="sort"]').on('change', function () { ShowEmployees(); });
    $("#countSelected").on('input', function () { GetPages(); });
});