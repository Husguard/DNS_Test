using System;

namespace DNS_Test.Models
{
    public class ErrorViewModel
    {
        public string RequestId { get; set; }
        public string ExceptionDescription { get; set; }
        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}
