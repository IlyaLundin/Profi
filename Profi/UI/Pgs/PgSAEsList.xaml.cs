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
using Profi.UI.Wnds;
using static Profi.BL.PgsManager;
using Profi.BL;


namespace Profi.UI.Pgs
{
    /// <summary>
    /// Логика взаимодействия для PgSAEsList.xaml
    /// </summary>
    public partial class PgSAEsList : Page
    {
        public PgSAEsList()
        {
            InitializeComponent();
            SAEList.ItemsSource = ProfiDBEntities2.GetContext().SAEs.ToList();

            //Блок значений выпадающих списков для фильтрации
            CbxPrice.Items.Add("По умолчанию");
            CbxPrice.SelectedItem = "По умолчанию";
            CbxPrice.Items.Add("По возрастанию");
            CbxPrice.Items.Add("По убыванию");

            CbxProfi.Items.Add("По умолчанию");
            CbxProfi.SelectedItem = "По умолчанию";
            CbxProfi.Items.Add("По возрастанию");
            CbxProfi.Items.Add("По убыванию");
            if (WndAuthorisation.roleName == "Contragent")
            {
                BtnAddSAE.Visibility = Visibility.Visible;
                BtnDeleteSAE.Visibility = Visibility.Visible;
            }
                var currentContragent = ProfiDBEntities2.GetContext().All_Contragents_User.Where(x => x.Login == WndAuthorisation.login).FirstOrDefault();

        }
        private void Search_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateSearch();
        }

       
        private void ChbAll_Checked(object sender, RoutedEventArgs e)
        {         
            UpdateSearch();
        }

        private void ChbAll_Unchecked(object sender, RoutedEventArgs e)
        {
            UpdateSearch();
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
            if (WndAuthorisation.roleName == "Contragent")
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
                MessageBox.Show("Изменять СДО могут только контрагенты", "Ошибка");
            }

        }

        private void BtnContragent_Click(object sender, RoutedEventArgs e)
        {
            PgsManager.MainFrame.Navigate(new PgContragentsList());
        }


        /// <summary>
        /// Метод для обновления списка данных при поиске
        /// </summary>
        public void UpdateSearch()
        {
            var listSAE = ProfiDBEntities2.GetContext().SAEs.Where(x => x.Name_SAE.ToLower()
                                                                               .Contains(Search.Text.ToLower())
                                                                               ).ToList();

            if (Search.Text == "" || Search.Text == " ")
            {
                listSAE = ProfiDBEntities2.GetContext().SAEs.ToList();
            }

            if (CbxProfi.SelectedItem == "По умолчанию")
            {
                listSAE = ProfiDBEntities2.GetContext().SAEs.ToList();
                if (CbxPrice.SelectedItem == "По возрастанию")
                {
                    listSAE = listSAE.OrderBy(x => x.Price).ToList();
                }
                if (CbxPrice.SelectedItem == "По убыванию")
                {
                    listSAE = listSAE.OrderByDescending(x => x.Price).ToList();
                }
            }
            if (CbxProfi.SelectedItem == "По возрастанию")
            {
                listSAE = listSAE.OrderBy(x => x.Profi_Point).ToList();
            }
            if (CbxProfi.SelectedItem == "По убыванию")
            {
                listSAE = listSAE.OrderByDescending(x => x.Profi_Point).ToList();
            }

            if (CbxPrice.SelectedItem == "По умолчанию")
            {
                listSAE = ProfiDBEntities2.GetContext().SAEs.ToList();
                if (CbxProfi.SelectedItem == "По возрастанию")
                {
                    listSAE = listSAE.OrderBy(x => x.Profi_Point).ToList();
                }
                if (CbxProfi.SelectedItem == "По убыванию")
                {
                    listSAE = listSAE.OrderByDescending(x => x.Profi_Point).ToList();
                }
            }
            if (CbxPrice.SelectedItem == "По возрастанию")
            {
                listSAE = listSAE.OrderBy(x => x.Price).ToList();
            }
            if (CbxPrice.SelectedItem == "По убыванию")
            {
                listSAE = listSAE.OrderByDescending(x => x.Price).ToList();
            }

            

            SAEList.ItemsSource = listSAE;
            if (listSAE.Count() == 0)
            {
                SAEList.Visibility = Visibility.Hidden;
            }
            if (listSAE.Count() != 0)
            {
                SAEList.Visibility = Visibility.Visible;
            }
        }

        private void CbxPrice_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateSearch();
        }

        private void CbxProfi_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateSearch();
        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            SAEList.ItemsSource = ProfiDBEntities2.GetContext().SAEs.ToList();
        }

        private void BtnEditSAE_Click(object sender, RoutedEventArgs e)
        {
            if (WndAuthorisation.roleName == "Contragent")
            {
                PgsManager.MainFrame.Navigate(new PgAddEditSAE((sender as Button).DataContext as SAE));
            }
            else
            {
                MessageBox.Show("Изменять СДО могут только контрагенты", "Ошибка");
            }
        }


    }

}

