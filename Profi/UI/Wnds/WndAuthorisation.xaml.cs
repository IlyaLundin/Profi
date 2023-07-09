using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Threading;
using Profi.Data;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Data.Entity.Infrastructure;

namespace Profi.UI.Wnds
{
    /// <summary>
    /// Логика взаимодействия для WndAuthorisation.xaml
    /// </summary>
    public partial class WndAuthorisation : Window
    {
        public WndAuthorisation()
        {
            InitializeComponent();
        }
        private void OpenPassword_Checked(object sender, RoutedEventArgs e)
        {
            TbxPassword.Visibility = Visibility.Visible;
            PasswordBox.Visibility = Visibility.Hidden;
        }
        private void OpenPassword_Unchecked(object sender, RoutedEventArgs e)
        {
            TbxPassword.Visibility = Visibility.Hidden;
            PasswordBox.Visibility = Visibility.Visible;
        }
        public static string login;
        public static string password;
        public static string fio;
        public static string roleName;     
        private void BtnLogIn_Click(object sender, RoutedEventArgs e)
        {
            var userObj = ProfiDBEntities2.GetContext().Users.FirstOrDefault(x => x.Login == TbxLogin.Text);
            if (userObj == null)
            {
                MessageBox.Show("Такого пользователя нет в системе!", "Ошибка входа в систему", MessageBoxButton.OK, MessageBoxImage.Error);
                TbxLogin.Text = "";
                TbxPassword.Text = "";
            }
            else
            {
                password = userObj.Password;
                login = userObj.Login;
                fio = userObj.FIO;
                if (password == TbxPassword.Text)
                {
                    MessageBox.Show($"Успешный вход в систему! {fio}", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
                    var role = ProfiDBEntities2.GetContext().UserRoles.Where(x => x.Login == TbxLogin.Text).FirstOrDefault();
                    roleName = role.Name_Role;
                    WndWorking mW = new WndWorking();
                    mW.Show();
                    //Блок записи в журнал входа
                    LogInJournal _currentLogIn = new LogInJournal();
                    _currentLogIn.Id_User = userObj.Id_User;
                    _currentLogIn.LogInDateTime = DateTime.Now;
                    ProfiDBEntities2.GetContext().ChangeTracker.Entries().ToList().Clear();
                    ProfiDBEntities2.GetContext().LogInJournals.Add(_currentLogIn);
                    ProfiDBEntities2.GetContext().SaveChanges();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Неверный пароль!", "Ошибка входа в систему", MessageBoxButton.OK, MessageBoxImage.Error);
                    TbxPassword.Text = "";
                }
            }         
        }
        private void TbxLogin_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (TbxLogin.Text != "")
            {
                TblPassword.Visibility = Visibility.Visible;
                PasswordBox.Visibility = Visibility.Visible;
            }
            else
            {
                TblPassword.Visibility = Visibility.Hidden;
                PasswordBox.Visibility = Visibility.Hidden;
                PasswordBox.Password = "";
                TbxPassword.Text = "";
            }
        }
        private void TbxPassword_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (PasswordBox.Password != "")
            {
                OpenPassword.Visibility = Visibility.Visible;
                BtnLogIn.Visibility = Visibility.Visible;
                PasswordBox.Password = TbxPassword.Text;
            }
            else
            {
                OpenPassword.Visibility = Visibility.Hidden;
                BtnLogIn.Visibility = Visibility.Hidden;
                PasswordBox.Password = TbxPassword.Text;
            }
        }
        private void SetSelection(PasswordBox passwordBox, int start, int length)
        {
            passwordBox.GetType().GetMethod("Select", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic).Invoke(passwordBox, new object[] { start, length });
        }
        private void PasswordBox_PasswordChanged(object sender, RoutedEventArgs e)
        {
            TbxPassword.Text = PasswordBox.Password;
            SetSelection(PasswordBox, PasswordBox.Password.Length, 0);
            PasswordBox.Focus();
        }


    }
}
