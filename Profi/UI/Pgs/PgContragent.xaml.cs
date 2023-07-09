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
    /// Логика взаимодействия для PgContragent.xaml
    /// </summary>
    public partial class PgContragent : Page
    {
        internal Data.Contragent _currentContragent = new Data.Contragent();

        public PgContragent(Data.Contragent selectedContragent)
        {
            InitializeComponent();
            if (selectedContragent != null)
                _currentContragent = selectedContragent;
            DataContext = _currentContragent;
        }

    }
}
