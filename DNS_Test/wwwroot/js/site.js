var selectedId;
var page = 0;
$(document).on('click', ".coloring", function (e) {
    $(this).parent().find(".coloring").removeClass("colored_row");
    $(this).parent().find("#buttonSection").remove();
    $(this).toggleClass("colored_row");

    selectedId = $(this).find('#number').text();

    var btnSection = document.createElement('div');
    btnSection.id = "buttonSection";
    var btnShow = document.createElement('button');
    btnShow.innerText = "Подчиненные";
    btnShow.className = 'btn btn-primary';
    btnShow.addEventListener('click', showChiefs.bind());
    var btnDel = document.createElement('button');
    btnDel.innerText = "Удалить сотрудника";
    btnDel.className = 'btn btn-primary';
    btnDel.addEventListener('click', delEmployee.bind());
    btnSection.append(btnShow, btnDel);
    $(this).children().last().append(btnSection);
});


function showChiefs(e) {
    var table = document.createElement('div');
    var output = $('#resultOf'); // блок вывода информации
    $.ajax({
        url: '/Home/ShowEmployees',
        type: 'POST', // метод передачи данных
        data: { id: window.selectedId }, // данные, которые передаем на сервер
        beforeSend: function () { // Функция вызывается перед отправкой запроса
            output.text('Запрос отправлен. Ждите ответа.');
        },
        error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
            output.text('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
        },
        success: function (json) { // функция, которая будет вызвана в случае удачного завершения запроса к серверу
            // json - переменная, содержащая данные ответа от сервера. Обзывайте её как угодно ;)
            output.html(json); // выводим на страницу данные, полученные с сервера
        }
    });
};
function delEmployee() {
    var output = $('#resultOf');
    $.ajax({
        url: '/Home/DeleteEmployee',
        type: 'GET', // метод передачи данных
        data: { id: window.selectedId }, 
        beforeSend: function () {
            output.text('Запрос отправлен. Ждите ответа.');
        },
        error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
            output.text('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
        },
        success: function (json) {
            output.html(json);
        }
    });
};
// ВЫПАДАЮЩИЙ СПИСОК ДОЛЖЕН СОЗДАТЬ ТАБЛИЦУ ПОД ВЫБРАННОЙ СТРОКОЙ