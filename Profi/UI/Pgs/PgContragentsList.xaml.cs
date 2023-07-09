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

namespace Profi.UI.Pgs
{
    /// <summary>
    /// Логика взаимодействия для PgContragentsList.xaml
    /// </summary>
    public partial class PgContragentsList : Page
    {
        public PgContragentsList()
        {
            InitializeComponent();
            ContragentsList.ItemsSource = ProfiDBEntities2.GetContext().Contragents.ToList();
            if (WndAuthorisation.roleName == "Admin")
            {
                BtnAddContragent.Visibility = Visibility.Visible;
                BtnDeleteContragent.Visibility = Visibility.Visible;
            }

        }

        private void BtnAddContragent_Click(object sender, RoutedEventArgs e)
        {
            if (WndAuthorisation.roleName == "Admin")
            {
                PgsManager.MainFrame.Navigate(new PgAddEditContragent(null));
            }
            else
            {
                MessageBox.Show("Недостаточно прав для выполнения действия!", "Ошибка");
            }
        }

        private void BtnDeleteContragent_Click(object sender, RoutedEventArgs e)
        {
            if (WndAuthorisation.roleName == "Admin")
            {
                var contragentsForRemoving = ContragentsList.SelectedItems.Cast<Contragent>().ToList();


                if (contragentsForRemoving.Count() == 0)
                {
                    MessageBox.Show("Данные для удаления не выбраны!");
                }
                else
                {


                    if (MessageBox.Show($"Вы уверены, что хотите удалить следующие {contragentsForRemoving.Count()} элементов?", "Внимание",
                        MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                    {
                        try
                        {
                            ProfiDBEntities2.GetContext().Contragents.RemoveRange(contragentsForRemoving);
                            ProfiDBEntities2.GetContext().SaveChanges();
                            MessageBox.Show("Данные удалены!");
                            ContragentsList.ItemsSource = ProfiDBEntities2.GetContext().Contragents.ToList();
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

        private void BtnContragent_Click(object sender, RoutedEventArgs e)
        {
            PgsManager.MainFrame.Navigate(new PgSAEsList());
        }

        private void BtnEditContragent_Click(object sender, RoutedEventArgs e)
        {
            if (WndAuthorisation.roleName == "Admin")
            { 
                PgsManager.MainFrame.Navigate(new PgAddEditContragent((sender as Button).DataContext as Contragent));
            }
            else
            {
                MessageBox.Show("Недостаточно прав!", "Ошибка");
            }
        }

        private void Search_TextChanged(object sender, TextChangedEventArgs e)
        {
            var ContragentList = ProfiDBEntities2.GetContext().Contragents.Where(x => x.Name_Contragent.ToLower()
                                                                               .Contains(Search.Text.ToLower())
                                                                               ).ToList();

            if (Search.Text == "" || Search.Text == " ")
            {
                ContragentList = ProfiDBEntities2.GetContext().Contragents.ToList();
            }
            ContragentsList.ItemsSource = ContragentList;
            if (ContragentList.Count() == 0)
            {
                ContragentsList.Visibility = Visibility.Hidden;
            }
            if (ContragentList.Count() != 0)
            {
                ContragentsList.Visibility = Visibility.Visible;
            }



        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            ContragentsList.ItemsSource = ProfiDBEntities2.GetContext().Contragents.ToList();
        }

        private void BtnOpenContragent_Click(object sender, RoutedEventArgs e)
        {
            PgsManager.MainFrame.Navigate(new PgContragent((sender as Button).DataContext as Contragent));
        }
    }
}
