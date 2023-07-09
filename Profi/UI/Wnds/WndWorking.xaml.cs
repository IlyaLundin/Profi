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
using System.Windows.Shapes;
using Profi.UI.Pgs;



namespace Profi.UI.Wnds
{
    /// <summary>
    /// Логика взаимодействия для WndWorking.xaml
    /// </summary>
    public partial class WndWorking : Window
    {
        public WndWorking()
        {
            InitializeComponent();
            UserName.Text = WndAuthorisation.roleName + " " + WndAuthorisation.fio;
            
            if (WndAuthorisation.roleName == "Admin")
            {
                MainFrame.Navigate(new PgSAEsList());
                PgsManager.MainFrame = MainFrame;
                BtnJournal.Visibility = Visibility.Visible;
            }
            if (WndAuthorisation.roleName == "Contragent") 
            {
                BtnCabinet.Visibility = Visibility.Visible;
                var currentContragent = ProfiDBEntities2.GetContext().All_Contragents_User.Where(x => x.Login == WndAuthorisation.login).FirstOrDefault();
                PgsManager.MainFrame = MainFrame;
                MainFrame.Navigate(new PgContragentCabinet(currentContragent));
            }
        }

            private void BtnExit_Click(object sender, RoutedEventArgs e)
            {
               
                WndAuthorisation wA = new WndAuthorisation();
                wA.Show();
                this.Close();
            }
            private void MainFrame_ContentRendered(object sender, EventArgs e)
            {
                if (MainFrame.CanGoBack)
                {
                    BtnBack.Visibility = Visibility.Visible;
                }
                else
                {
                    BtnBack.Visibility = Visibility.Hidden;
                }
            }

            private void BtnBack_Click(object sender, RoutedEventArgs e)
            {
                MainFrame.GoBack();
            }

            private void BtnJournal_Click(object sender, RoutedEventArgs e)
            {
                MainFrame.Navigate(new PgLogInJournal());
            }

        private void BtnCabinet_Click(object sender, RoutedEventArgs e)
        {
            var currentContragent = ProfiDBEntities2.GetContext().All_Contragents_User.Where(x => x.Login == WndAuthorisation.login).FirstOrDefault();
            PgsManager.MainFrame = MainFrame;
            MainFrame.Navigate(new PgContragentCabinet(currentContragent));
        }
    }
    }

