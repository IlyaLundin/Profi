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
using static Profi.BL.PgsManager;


namespace Profi.UI.Pgs
{
    /// <summary>
    /// Логика взаимодействия для PgAddEditContragent.xaml
    /// </summary>
    public partial class PgAddEditContragent : Page
    {
        internal Data.Contragent _currentContragent = new Data.Contragent();
        public PgAddEditContragent(Data.Contragent selectedContragent)
        {
            InitializeComponent();
            if (selectedContragent != null)
                _currentContragent = selectedContragent;
            DataContext = _currentContragent;
        }

        private void BtnSaveContragent_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (string.IsNullOrWhiteSpace(_currentContragent.Name_Contragent))
            {
                errors.AppendLine("Введите название контрагента");
            }
            if (string.IsNullOrWhiteSpace(_currentContragent.Description))
            {
                errors.AppendLine("Введите описание");
            }
            if (string.IsNullOrWhiteSpace(_currentContragent.Phone))
            {
                errors.AppendLine("Введите телефон");
            }
            if (string.IsNullOrWhiteSpace(_currentContragent.Address))
            {
                errors.AppendLine("Введите адрес");
            }
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }           
            if (_currentContragent.Id_Contragent == 0)
            {
                _currentContragent.Logo = "/Resources/Images/nophoto.png";
                ProfiDBEntities2.GetContext().Contragents.Add(_currentContragent);
            }
            try
            {
                ProfiDBEntities2.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена!");
                MainFrame.Navigate(new PgContragentsList());
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

                    
    }
}
