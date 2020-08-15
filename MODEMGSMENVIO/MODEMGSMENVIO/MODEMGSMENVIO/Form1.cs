using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WEBMODEMGSMENVIO;

namespace MODEMGSMENVIO
{
    public partial class MODEMGSMENVIA : Form
    {
        public MODEMGSMENVIA()
        {
            InitializeComponent();
        }

        private string RetornaIpLocal()
        {
            var ip = "localhost";
            var porta = "44359";

            if (string.IsNullOrEmpty(ip) || string.IsNullOrEmpty(porta))
            {
                MessageBox.Show("Arquivo de configuração não encontrado!");
                return null;
            }
            return string.Format("http://{0}:{1}", ip, porta);
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            var ipLocal = RetornaIpLocal();
            if (!string.IsNullOrEmpty(ipLocal))
            {
               Microsoft.Owin.Hosting.WebApp.Start<Startup>(ipLocal);
               this.WindowState = FormWindowState.Minimized;
            }
        }

        private void Form1_Resize(object sender, EventArgs e)
        {
            if (WindowState == FormWindowState.Minimized)
            {
                this.Hide();
                this.ShowInTaskbar = false;
            }
        }


        private void notifyIcon1_DoubleClick(object sender, EventArgs e)
        {
            this.Show();
            this.WindowState = FormWindowState.Normal;
            this.ShowInTaskbar = true;
        }
    }
}
