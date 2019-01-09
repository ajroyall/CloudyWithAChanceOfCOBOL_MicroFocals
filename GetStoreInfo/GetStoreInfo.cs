using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Threading.Tasks;
using MicroFocus.COBOL.RuntimeServices.Generic;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Host;

namespace GetStoreInfo
{
    public static class GetStoreInfo
    {
        [FunctionName("GetStoreInfo")]
        public static async Task<HttpResponseMessage> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)]HttpRequestMessage req, TraceWriter log, ExecutionContext c)
        {
            log.Info("C# HTTP trigger function processed a request.");
            log.Info("Current dir: " + Directory.GetCurrentDirectory());
            Directory.SetCurrentDirectory(c.FunctionDirectory);
            log.Info("Changing current directory...");
            log.Info("Current dir: " + Directory.GetCurrentDirectory());

            // parse query parameter
            string name = req.GetQueryNameValuePairs()
                .FirstOrDefault(q => string.Compare(q.Key, "name", true) == 0)
                .Value;

            if (name == null)
            {
                // Get request body
                dynamic data = await req.Content.ReadAsAsync<object>();
                name = data?.name;
            }
            
            WsStoreInformation storeinfo = new WsStoreInformation();
            storeinfo.WsNameOfStore = name;

            try
            {
                log.Info("Creating run unit");
                using (var runUnit = new RunUnit<getonestore_test>())
                {
                    log.Info("Running COBOL");
                    runUnit.Call(nameof(getonestore_test), storeinfo.Reference);
                    log.Info("Finished Running COBOL");
                }
            }
            catch (Exception ex)
            {
                log.Error("GETONESTORE run unit call failed", ex);
                return null;
            }
            
            log.Info("Returning result: " + (storeinfo ?? new WsStoreInformation()).WsNameOfStore);
            return storeinfo.WsNameOfStore == null
                ? req.CreateResponse(HttpStatusCode.BadRequest, "Please pass a name on the query string or in the request body")
                : req.CreateResponse(HttpStatusCode.OK, storeinfo, JsonMediaTypeFormatter.DefaultMediaType);
            
        }
    }
}
