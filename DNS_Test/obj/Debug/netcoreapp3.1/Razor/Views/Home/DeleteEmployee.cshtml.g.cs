#pragma checksum "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "5129f17efe2faab7447a6e706a789de5923066b4"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home_DeleteEmployee), @"mvc.1.0.view", @"/Views/Home/DeleteEmployee.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\_ViewImports.cshtml"
using DNS_Test;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\_ViewImports.cshtml"
using DNS_Test.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"5129f17efe2faab7447a6e706a789de5923066b4", @"/Views/Home/DeleteEmployee.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"e07a81b35812c7fd958d33d39ca61fff45086ab8", @"/Views/_ViewImports.cshtml")]
    public class Views_Home_DeleteEmployee : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<DNS_Test.Models.Employee>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-action", "DeleteEmployee", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("asp-controller", "Home", global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("data-ajax-method", new global::Microsoft.AspNetCore.Html.HtmlString("POST"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_3 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("data-ajax", new global::Microsoft.AspNetCore.Html.HtmlString("true"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_4 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("data-ajax-update", new global::Microsoft.AspNetCore.Html.HtmlString("#resultOf"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper;
        private global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral("    <div class=\"head\">\r\n        <h4>Точно хотите удалить сотрудника?</h4>\r\n        <button id=\"closeButton\" class=\"btn btn-primary\">Закрыть</button>\r\n    </div>\r\n            <dl>\r\n                <dt>\r\n                    ");
#nullable restore
#line 8 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayNameFor(model => model.Id));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dt>\r\n                <dd>\r\n                    ");
#nullable restore
#line 11 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayFor(model => model.Id));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dd>\r\n                <dt>\r\n                    ");
#nullable restore
#line 14 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayNameFor(model => model.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dt>\r\n                <dd>\r\n                    ");
#nullable restore
#line 17 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayFor(model => model.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dd>\r\n                <dt>\r\n                    ");
#nullable restore
#line 20 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayNameFor(model => model.Department));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dt>\r\n                <dd>\r\n                    ");
#nullable restore
#line 23 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayFor(model => model.Department.Name));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dd>\r\n                <dt>\r\n                    ");
#nullable restore
#line 26 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayNameFor(model => model.Post));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dt>\r\n                <dd>\r\n                    ");
#nullable restore
#line 29 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayFor(model => model.Post));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dd>\r\n                <dt>\r\n                    ");
#nullable restore
#line 32 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayNameFor(model => model.Date));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dt>\r\n                <dd>\r\n                    ");
#nullable restore
#line 35 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayFor(model => model.Date));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dd>\r\n                <dt>\r\n                    ");
#nullable restore
#line 38 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
               Write(Html.DisplayNameFor(model => model.Chief));

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                </dt>\r\n                <dd>\r\n");
#nullable restore
#line 41 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
                     if (Model.Chief == null)
                    {
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 43 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
                   Write(Html.DisplayName("Отсутствует"));

#line default
#line hidden
#nullable disable
#nullable restore
#line 43 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
                                                        ;
                    }
                    else
                    {
                        

#line default
#line hidden
#nullable disable
#nullable restore
#line 47 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
                   Write(Html.DisplayFor(model => model.Chief.Name));

#line default
#line hidden
#nullable disable
#nullable restore
#line 47 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
                                                                   ;
                    }

#line default
#line hidden
#nullable disable
            WriteLiteral("                </dd>\r\n                <dd>\r\n                    ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("form", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagAndEndTag, "5129f17efe2faab7447a6e706a789de5923066b410125", async() => {
                WriteLiteral("\r\n                        <input type=\"number\"");
                BeginWriteAttribute("value", " value=\"", 1948, "\"", 1965, 1);
#nullable restore
#line 52 "C:\Users\Админ\source\repos\DNS_Test\DNS_Test\Views\Home\DeleteEmployee.cshtml"
WriteAttributeValue("", 1956, Model.Id, 1956, 9, false);

#line default
#line hidden
#nullable disable
                EndWriteAttribute();
                WriteLiteral(" name=\"Id\" hidden />\r\n                        <button type=\"submit\" class=\"btn btn-danger\" onclick=\"ShowSuccess()\">Удалить</button>\r\n                    ");
            }
            );
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.FormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.TagHelpers.RenderAtEndOfFormTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_TagHelpers_RenderAtEndOfFormTagHelper);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Action = (string)__tagHelperAttribute_0.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_0);
            __Microsoft_AspNetCore_Mvc_TagHelpers_FormTagHelper.Controller = (string)__tagHelperAttribute_1.Value;
            __tagHelperExecutionContext.AddTagHelperAttribute(__tagHelperAttribute_1);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_2);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_3);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_4);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral("\r\n                </dd>\r\n            </dl>");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<DNS_Test.Models.Employee> Html { get; private set; }
    }
}
#pragma warning restore 1591
