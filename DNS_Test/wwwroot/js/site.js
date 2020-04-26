"use strict";
let selectedId = undefined;
function GetPages() {
    $.ajax({
        url: '/Home/GetPage',
        type: 'POST',
        data: { pages: $("#countSelected").val() },
        success: function (json) {
            $("#pageNumber").attr({ "max": json, "min": 1 , "value" : 1});
        }
    });
    $("#Show").submit();
}
function AddEmployee() {
    let output = $('#resultOf');
    $("#resultOf").empty();
    $.ajax({
        url: '/Home/AddEmployee',
        type: 'GET',
        success: function (json) {
            output.html(json);
            $("#modal").show();
            $("#closeButton").on('click', function () {
                $("#modal").hide();
            });
        }
    });
}
// крч метод создающий верстку форму для добавления отдела
function ShowSuggests(e) {
    $("#suggests").empty();
    $("#suggests").hide();
    if (e.value.length > 0) {
        $.ajax({
            url: '/Home/GetSuggests',
            type: 'POST',
            data: { name: e.value },
            success: function (json) {
                for (let i = 0; i < json.length; i++) {
                    let btnShow = document.createElement('a');
                    btnShow.innerText = json[i];
                    btnShow.addEventListener('click', function () {
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
$(document).on('click', ".table tbody tr", function () {
    if (selectedId != undefined) {
        selectedId.parent().find("tr").removeClass("selected_row");
        selectedId.parent().find("#buttonSection").remove();
    }
    selectedId = $(this);
    selectedId.toggleClass("selected_row");
    let btnSection = document.createElement('div');
    btnSection.id = "buttonSection";
    let btnShowChiefs = createButton('Руководители', '/Home/ShowChiefs', 'POST');
    let btnDel = createButton('Удалить сотрудника', '/Home/DeleteEmployee', 'GET');
    btnSection.append(btnShowChiefs, btnDel);
    $(this).children().last().append(btnSection);
});
function createButton(innerText, url, method) {
    let btn = document.createElement('button');
    btn.innerText = innerText;
    btn.className = 'btn btn-primary';
    btn.addEventListener('click', function () {
        let output = $('#resultOf');
    //    alert(`Проверяем ${typeof (selectedId)}`);
        $.ajax({
            url: url,
            type: method,
            data: { id: selectedId.find('#number').text() },
            success: function (json) {
                output.html(json);
                $("#modal").show();
                $("#closeButton").on('click', function () {
                    $("#modal").hide();
                });
            }
        });
    });
    return btn;
}
function ShowSuccess() {
    $("#modal").show();
    setTimeout(function () {
        $("#modal").hide();
    }, 2000);
}
$().ready(function () {
    GetPages();
    $('input[name="column"]').on('change', function () { $("#Show").submit(); });
    $('input[name="page"]').on('change', function () { $("#Show").submit(); });
    $('input[name="sort"]').on('change', function () { $("#Show").submit(); });
    $("#countSelected").on('input', function () { GetPages(); });
    $("#addButton").on('click', function () { AddEmployee(); });
});