"use strict";
// можно создать кэш записей здесь, и из него выводить данные
// но стоит вопрос как отличить то что есть от того чего нет и нужно взять из бд?
// это можно исправить, если на бэке будет проверка по записям, а не по пакетам 
// как мне понять что при смене порядка нужно отсылать часть нужных записей, которые есть уже на странице?(в случае пересылки от клиента выборочно)
// в случае пересылки от клиента всех, то вычислить какие нужно(страница) и выбрать все кроме пришедших
// но здесь стоит проблема как формировать страницу
let selectedId = undefined;
function GetCountOfPages() {
    $.ajax({
        url: '/Home/GetCountOfPages',
        type: 'POST',
        data: { selected: $("#countSelected").val() },
        success: function (json) {
            $("#pageNumber").attr({ "max": json, "min": 1});
            if ($("#pageNumber").val() <= json) $("#Show").submit(); // клиентскую валидацию можно обмануть, поэтому нужна еще валидация на стороне сервера
        }
    });
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
    $(this).children().last().append(btnSection); // можно убрать children.last, но тогда секция где будут кнопки будет без выделения(тоесть нужен стиль tdшки в div)
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
    GetCountOfPages();
    $('input[name="column"]').on('change', function () { $("#Show").submit(); });
    $('input[name="page"]').on('change', function () { $("#Show").submit(); });
    $('input[name="sort"]').on('change', function () { $("#Show").submit(); });
    $("#countSelected").on('input', function () { GetCountOfPages(); });
    $("#addButton").on('click', function () { AddEmployee(); });
});