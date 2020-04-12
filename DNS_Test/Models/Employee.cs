using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DNS_Test.Models
{
    public class Employee
    { //  [HiddenInput(DisplayValue = false)]
        [Display(Name = "Номер")] public int Id { get; set; }
        [RegularExpression("[а-яА-ЯёЁa-zA-Z\\s]+$", ErrorMessage = "Имя не может иметь цифр или символов")] [Required(ErrorMessage = "Поле должно быть установлено")] [StringLength(80, ErrorMessage = "Длина строки должна быть до 80 символов")] [Display(Name = "Ф.И.О.")] public string Name { get; set; }
        [Required] [Display(Name = "Отдел")] public Department Department { get; set; } 
        [Required(ErrorMessage = "Поле должно быть установлено")] [StringLength(80, ErrorMessage = "Длина строки должна быть до 80 символов")] [Display(Name = "Должность")] public string Post { get; set; }
        [Required(ErrorMessage = "Поле должно быть установлено")] [Display(Name = "Дата устройства")] [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")] public DateTime Date { get; set; }
        [Display(Name = "Руководитель")] public Employee Chief { get; set; }
    }
}
