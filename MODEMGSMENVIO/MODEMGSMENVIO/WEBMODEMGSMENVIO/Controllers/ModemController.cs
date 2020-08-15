using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WEBMODEMGSMENVIO.Controllers
{
    public class ModemController : ApiController
    {
        // GET: api/Modem

        [HttpGet]
        [Route("Enviar")]
        public string Enviar(string Numero, string Mensagem)
        {
            using (var port = new System.IO.Ports.SerialPort())
            {
                port.PortName = "COM7";
                port.Open();
                port.DtrEnable = true;
                port.RtsEnable = true;
                port.Write("AT\r");
                port.Write("AT+CMGF=1\r");
                port.Write(string.Format("AT+CMGS=\"{0}\"\r", Numero));
                port.Write(Mensagem + char.ConvertFromUtf32(26));
            }
            return "Enviando com Sucesso!";
        }

    }
}
