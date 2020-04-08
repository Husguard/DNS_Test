using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Microsoft.Extensions.Logging;
using DNS_Test.Models;
using System.Text;

namespace DNS_Test.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }
        public JsonResult GetPage(int pages)
        {
            ConnectionContext connection = new ConnectionContext();
            int value = connection.GetPage(pages);
            return Json(value);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        [HttpGet]
        public IActionResult ShowEmployees(int page, int selected, bool sort, bool column)
        {
            ConnectionContext connection = new ConnectionContext();
            return PartialView(connection.GetEmployees(page - 1, selected, sort, column));
        }
        [HttpPost]
        public IActionResult ShowChiefs(int Id)
        {
            ConnectionContext connection = new ConnectionContext();
            return PartialView(connection.ShowChiefs(Id));
        }
        [HttpGet]
        public IActionResult AddEmployee()
        {
            return PartialView();
        }
        [HttpPost]
        public IActionResult AddEmployee(Employee adding) 
        {
            ConnectionContext connection = new ConnectionContext();
            connection.AddEmployee(adding);
            return RedirectToAction("Index");
        }
        [HttpGet]
        public IActionResult DeleteEmployee(int Id)
        {
            ConnectionContext connection = new ConnectionContext();
            return PartialView(connection.FindEmployee(Id));
        }
        [HttpPost]
        public IActionResult DeleteEmployee(Employee model)
        {
            ConnectionContext connection = new ConnectionContext();
            connection.DeleteEmployee(model.Id); // ID не принимается от модели
            return RedirectToAction("Index");
        }
    }
}
