   M S B A M L   `   `   `  ����@  <Profi, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:Profi.UI.WndsProfi.UI.Wnds  5   	       Profi.UI.Wnds.WndWorking   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:Profi.UI.Wnds     5   	     � Title$*  $Профи - Главное окно��5      $	��900��6   $
��1500��6+   $	��890��68   $
��1400��6H    � WindowStartupLocation$ CenterScreen=�6Y   .��6�   �  � RowDefinitions 5
   
   �� 5      $	��100 �6   6+   �� 5      $��* �6   6)   �� 5      $��60 �6   6*    � ColumnDefinitions 5   
   �� 5      6!   .+�5   
   � $��0��6      GridMain#��[  6   ���#ffa07a$��2��6S   .+�5      �� $
��Left=�6   $��10q�6/   $%��/Resources/Images/SuperStar.png��6;   �� 5      $��
Профи��6   $��35(�6%     TextBlockMain#��[ 63   5      �� 5   
   $��Comic Sans MS)�6   $��15(�6/   $��3��6=   $��2��6J    �� TextAlignment$
 Left=�6^    �� Padding$ 10q�6s     
BorderMain#��[ 6�   �� 5   
   -   5        $��BtnExit��5      $��3��6    $��
Выйти��6-     
ButtonMain#��[ 6=   $
��Left=�6w   �� 5   
   -   5        $��UserName��5      $	��450��6$   $��40��60   
�������$��0��6O   $��2��6_   $��Right=�6s   $��10q�6�   $��Comic Sans MS)�6�   $��20(�6�   $ Center=�6�    � 5   
   -   5        $��	MainFrame��5      $��1��6     � NavigationUIVisibility$ Hidden=�6Z   $��0,10,0,0q�6z   6�   �� 5    
   $��1��6   $��2��6!   ���#ffe4b5 K� ZIndex$ -1��6K   6_   �� 5!   
   $��2��6   $��2��6!   ���#ffe4b5$ -1��6J   6^   �� 5"   
   -   5        $��BtnBack��5"   b   $��
Назад��6   #��[ 6!   $��Center=�6E   $��3��6�   $��1��6�   �� 5#   
   -   5        $��
BtnJournal��5#   b   $��Журнал��6   #��[ 6"   $��Right=�6F   $y�Hidden=�6�   $��3��6�   $��1��6�   �� 5$   
   -   5        $��
BtnCabinet��5$   c   $��Кабинет��6   #��[ 6#   $��Right=�6G   $y�Hidden=�6�   $��3��6�   $��1��6�   6�   5'      5(      