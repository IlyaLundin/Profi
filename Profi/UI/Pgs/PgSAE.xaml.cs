using Profi.BL;
using Profi.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using static System.Net.Mime.MediaTypeNames;

namespace Profi.UI.Pgs
{
    /// <summary>
    /// Логика взаимодействия для PgSAE.xaml
    /// </summary>
    public partial class PgSAE : Page
    {
        
        internal Data.SAE _currentSAE = new Data.SAE();
        public PgSAE(Data.SAE selectedSAE)
        {
            InitializeComponent();
            if (selectedSAE != null)
                _currentSAE = selectedSAE;

            DataContext = _currentSAE;
            var name = ProfiDBEntities2.GetContext().ContragentSAEs.Where(x => x.Name_SAE == _currentSAE.Name_SAE).FirstOrDefault();
            TblNameContragent.Text = name.Name_Contragent;

        }
        private void BtnEditSAE_Click(object sender, RoutedEventArgs e)
        {
            PgsManager.MainFrame.Navigate(new PgAddEditSAE((sender as Button).DataContext as SAE));
        }

        private void BtnPdf_Click(object sender, RoutedEventArgs e)
        {        
            //Открытие диалога для сохранения файла в pdf и для печати
                PrintDialog pD = new PrintDialog();
                if (pD.ShowDialog() == true)
                {
                    pD.PrintVisual(PdfCanvas, "Вывод");
                }
         
        }
    }
}
