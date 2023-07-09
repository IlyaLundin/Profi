using Microsoft.Win32;
using Profi.BL;
using Profi.Data;
using Profi.UI.Wnds;
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
using static Profi.BL.PgsManager;

namespace Profi.UI.Pgs
{
    /// <summary>
    /// Логика взаимодействия для PgAddEditSAE.xaml
    /// </summary>
    public partial class PgAddEditSAE : Page
    {
        internal Data.SAE _currentSAE = new Data.SAE();
        public PgAddEditSAE(Data.SAE selectedSAE)
        {
            InitializeComponent();
            if (selectedSAE != null)
                _currentSAE = selectedSAE;
            DataContext = _currentSAE;
        }

        private void BtnSaveSAE_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentSAE.Name_SAE))
            {
                errors.AppendLine("Введите название СДО");
            }
            if (_currentSAE.Price < 1)
            {
                errors.AppendLine("Введите цену");
            }
            if (_currentSAE.Age < 1)
            {
                errors.AppendLine("Введите возраст учащихся");
            }
            if (string.IsNullOrWhiteSpace(_currentSAE.Result))
            {
                errors.AppendLine("Введите цели программы");
            }
            if (string.IsNullOrWhiteSpace(_currentSAE.Content))
            {
                errors.AppendLine("Введите описание программы");
            }            
            if (string.IsNullOrWhiteSpace(_currentSAE.Material_Base))
            {
                errors.AppendLine("Введите материально-техническую базу");
            }
            if (_currentSAE.Count < 1)
            {
                errors.AppendLine("Введите количество обучающихся в группе");
            }
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }                   
            _currentSAE.Profi_Point = 0;
            if (_currentSAE.Id_SAE == 0)
                ProfiDBEntities2.GetContext().SAEs.Add(_currentSAE);

            try
            {
                ProfiDBEntities2.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена!");
                MainFrame.Navigate(new PgSAEsList());
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
            
        }

        private void BtnCancelSAE_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new PgSAEsList());
        }

    }
}
