   M S B A M L   `   `   `  ����@  <Profi, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null-clr-namespace:Profi.UI.WndsProfi.UI.Wnds  5   	   $    Profi.UI.Wnds.WndAuthorisation   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35^ ZWindowsFormsIntegration, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   -localclr-namespace:Profi.UI.Wnds     5   	     � Title$&   Профи - Окно входа��5   	   $	��550��6$   $	��310��61    � 
ResizeMode$ NoResize=�6=    � Topmost .  � WindowStartupLocation$ CenterScreen=�6b   .��5	      �    GridMain#��[  6    � RowDefinitions 5
   
   �� 5      $	��100 �6   6+   �� 5      $	��150 �6   6+   �� 5      $	��150 �6   6+   �� 5      6   �� 5      $��50 �6   6*   .+�5   
   �� $	��100��6     
BorderMain#��[ 6!    �� TextAlignment$ Center=�6E    �� Padding$ 25q�5      $�� ��6!   �� 5   
     TextBlockAutho#��[ 6   $	��Top=�6<   $ ��Вход в систему��5      $��25(�6*   $��	95,21,0,0q�68   �� 5   
   $��70��6   $
��Left=�6   $	��Top=�67   $��10q�6O   $%��/Resources/Images/SuperStar.png��6[   �� 5   
   #��[ 6   $	��Top=�6<   $��
Логин��6T   $��1��6a   $��	35,21,0,0q�6n   �� 5   
   -   5        $��TbxLogin��5   Q   $��3q�6     TextBoxAutho#��[ 6   $��1��6D   $��	20,0,0,34q�5      �� 5   
   -   5        $��TblPassword��5   �   #��[ 6   $y�Hidden=�6<   $	��Top=�6P   $��Пароль��6h   $��2��6v    J� RenderTransformOrigin$ 0.828,0.468&�5      $��	35,27,0,0q�68   �� 5   
   -   5        $��TbxPassword��5   Q   $��3q�6   #��[ 6   $��2��6D   $y�Hidden=�5      $��	20,0,0,35q�6&   G� 5   
   -   5        $��PasswordBox��5   L     PasswordBoxMain#��[ 6   $��2��6?   $y�Hidden=�5      $��	20,0,0,35q�6*   �� 5   
   -   5        $��OpenPassword��5       $��5q�5      $��2��6   $��Bottom=�6,   $��Right=�6G   $��20q�6c   $��25��6o   $��25��5       $y�Hidden=�6u    � ToolTip$# Показать пароль��5!      	 d� 	IsChecked$	 FalseY�6-   �� 5"   
   -   5        $��BtnLogIn��5"   B     
ButtonMain#��[ 6   $��3��65   $��
Войти��6R   $y�Hidden=�5#      $��Center=�6%   �� 5$   
   $��4��6   #��[ 6!   5&      5'      