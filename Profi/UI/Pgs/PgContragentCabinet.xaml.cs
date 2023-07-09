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
using System.Windows.Forms.DataVisualization;
using Profi.BL;
using Profi.Data;
using Profi.UI.Wnds;
using static Profi.BL.PgsManager;
using System.Windows.Forms.DataVisualization.Charting;

namespace Profi.UI.Pgs
{
    /// <summary>
    /// Логика взаимодействия для PgContragentCabinet.xaml
    /// </summary>
    public partial class PgContragentCabinet : Page
    {
        internal Data.All_Contragents_User _currentUser = new Data.All_Contragents_User();
        
        public PgContragentCabinet(Data.All_Contragents_User selectedUser)
        {
            InitializeComponent();
            if (selectedUser != null)
                _currentUser = selectedUser;

            DataContext = _currentUser;
            SAEList.ItemsSource = ProfiDBEntities2.GetContext().ContragentSAEs.Where(x => x.Name_Contragent == _currentUser.Name_Contragent).ToList();
        }

       
            private void BtnOpenSAE_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new PgSAE((sender as Button).DataContext as SAE));
        }

        private void BtnAddSAE_Click(object sender, RoutedEventArgs e)
        {
            PgsManager.MainFrame.Navigate(new PgAddEditSAE(null));
        }

        private void BtnDeleteSAE_Click(object sender, RoutedEventArgs e)
        {
            if (WndAuthorisation.roleName == "Admin")
            {
                var saeForRemoving = SAEList.SelectedItems.Cast<SAE>().ToList();


                if (saeForRemoving.Count() == 0)
                {
                    MessageBox.Show("Данные для удаления не выбраны!");
                }
                else
                {


                    if (MessageBox.Show($"Вы уверены, что хотите удалить следующие {saeForRemoving.Count()} элементов?", "Внимание",
                        MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                    {
                        try
                        {
                            ProfiDBEntities2.GetContext().SAEs.RemoveRange(saeForRemoving);
                            ProfiDBEntities2.GetContext().SaveChanges();
                            MessageBox.Show("Данные удалены!");
                            SAEList.ItemsSource = ProfiDBEntities2.GetContext().SAEs.ToList();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show(ex.Message.ToString());
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("Недостаточно прав для выполнения действия!", "Ошибка");
            }

        }

        private void BtnShowSAEs_Click(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new PgSAEsList());
        }
    }
}
