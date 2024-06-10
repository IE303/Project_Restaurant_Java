/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JPanel.java to edit this template
 */
package RTDRestaurant.View.Form.Customer_Form;

import RTDRestaurant.Controller.Service.ServiceCustomer;
import RTDRestaurant.Model.ModelMonAn;
import RTDRestaurant.Model.ModelKhachHang;
import RTDRestaurant.Model.ModelHoaDon;
import RTDRestaurant.Model.ModelNguoiDung;
import RTDRestaurant.View.Component.Customer_Component.CardMonAn;
import RTDRestaurant.View.Dialog.MS_PayBill;
import RTDRestaurant.View.Dialog.MS_Warning;
import RTDRestaurant.View.Main_Frame.Main_Customer_Frame;
import RTDRestaurant.View.Swing.CustomScrollBar.ScrollBarCustom;
import RTDRestaurant.View.Swing.WrapLayout;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.SwingUtilities;

public class Suggested_dishes extends javax.swing.JPanel {
    private final ServiceCustomer service;
    private List<ModelMonAn> recommendedDishes;
    private final String type;
    private ArrayList<ModelMonAn> list;
    private final ModelNguoiDung user;
    private ModelKhachHang customer;
    private ModelHoaDon hoaDon;
    private final MS_Warning warning;
    private final MS_PayBill obj;

    public Suggested_dishes(String type, ModelNguoiDung user) {
        this.type = type;
        this.user = user;
        this.service = new ServiceCustomer();
        this.warning = new MS_Warning(Main_Customer_Frame.getFrames()[0], true);
        this.obj = new MS_PayBill(Main_Customer_Frame.getFrames()[0], true);
        this.list = new ArrayList<>();  // Khởi tạo list
        initComponents();
        init();
        loadDataAsync();
    }

    private void init() {
        try {
            panel.setLayout(new WrapLayout(WrapLayout.LEADING, 20, 20));
            txtSearch.setHint("Tìm kiếm món ăn . . .");
            jScrollPane1.setVerticalScrollBar(new ScrollBarCustom());

            // Lấy thông tin khách hàng từ user
            customer = service.getCustomer(user.getUserID());
            if (customer == null) {
                System.out.println("Customer not found for user ID: " + user.getUserID());
                warning.WarningCustomerNotFound();
                return;
            }

            // Tìm thông tin Hóa Đơn mà Khách Hàng vừa tạo
            hoaDon = service.FindHoaDon(customer);

            // Thêm data cho Menu
            initMenu();

        } catch (SQLException ex) {
            Logger.getLogger(Suggested_dishes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    private void loadDataAsync() {
        SwingUtilities.invokeLater(() -> {
            try {
                customer = service.getCustomer(user.getUserID());
                if (customer == null) {
                    warning.WarningCustomerNotFound();
                    return;
                }
                hoaDon = service.FindHoaDon(customer);
                loadRecommendedDishes();
            } catch (SQLException ex) {
                Logger.getLogger(Suggested_dishes.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
    }

    private void loadRecommendedDishes() throws SQLException {
        recommendedDishes = service.getRecommendedDishes(user);
        updateDishPanel(recommendedDishes);
    }

    private void updateDishPanel(List<ModelMonAn> dishes) {
        panel.removeAll();
        for (ModelMonAn dish : dishes) {
            CardMonAn card = new CardMonAn(dish, hoaDon);
            panel.add(card);
        }
        panel.revalidate();
        panel.repaint();
    }
    
    private void initMenu() {
        //panel.setLayout(new WrapLayout()); // Use WrapLayout for displaying dish cards
        try {
            recommendedDishes = service.getRecommendedDishes(user);
            panel.removeAll();
            for (ModelMonAn dish : recommendedDishes) {
                CardMonAn card = new CardMonAn(dish, hoaDon); // Pass hoaDon to CardMonAn constructor
                panel.add(card);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Suggested_dishes.class.getName()).log(Level.SEVERE, null, ex);
        }
        panel.revalidate();
        panel.repaint();
    }

    public void searchFood(String txt) {
        SwingUtilities.invokeLater(() -> {
            if (list != null) {  // Kiểm tra list có null không
                panel.removeAll();
                for (ModelMonAn data : list) {
                    if (data.getTitle().toLowerCase().contains(txt.toLowerCase())) {
                        panel.add(new CardMonAn(data, hoaDon));
                    }
                }
                panel.revalidate();
                panel.repaint();
            }
        });
    }

    public void initMenuFoodOrderby(String txt) {
        try {
            list = service.MenuFoodOrder(type, txt);
            panel.removeAll();
            for (ModelMonAn data : list) {
                panel.add(new CardMonAn(data, hoaDon));
            }

        } catch (SQLException ex) {
            Logger.getLogger(Suggested_dishes.class.getName()).log(Level.SEVERE, null, ex);
        }
        panel.repaint();
        panel.revalidate();
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        panel = new javax.swing.JPanel();
        lbTitle = new javax.swing.JLabel();
        txtSearch = new RTDRestaurant.View.Swing.MyTextField();
        orderby = new javax.swing.JComboBox<>();
        jLabel1 = new javax.swing.JLabel();
        cmdShowBill = new RTDRestaurant.View.Swing.Button();
        lbTable = new javax.swing.JLabel();
        txtTableName = new RTDRestaurant.View.Swing.MyTextField();
        jSeparator2 = new javax.swing.JSeparator();

        setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.LINE_AXIS));

        jPanel1.setBackground(new java.awt.Color(247, 247, 247));

        jScrollPane1.setBorder(null);
        jScrollPane1.setHorizontalScrollBarPolicy(javax.swing.ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);

        panel.setBackground(new java.awt.Color(215, 221, 232));
        panel.setAutoscrolls(true);
        panel.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        panel.setLayout(new java.awt.BorderLayout());
        jScrollPane1.setViewportView(panel);

        lbTitle.setFont(new java.awt.Font("Segoe UI", 1, 14)); // NOI18N
        lbTitle.setForeground(new java.awt.Color(108, 91, 123));
        lbTitle.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icons/MenuBar/aries.png"))); // NOI18N
        lbTitle.setText("Các món ăn có thể bạn sẽ thích");
        lbTitle.setIconTextGap(10);
        lbTitle.setInheritsPopupMenu(false);

        txtSearch.setPrefixIcon(new javax.swing.ImageIcon(getClass().getResource("/Icons/loupe (1).png"))); // NOI18N
        txtSearch.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                txtSearchMouseEntered(evt);
            }
        });
        txtSearch.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtSearchActionPerformed(evt);
            }
        });

        orderby.setEditable(true);
        orderby.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        orderby.setForeground(new java.awt.Color(108, 91, 123));
        orderby.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Tên A->Z", "Giá tăng dần", "Giá giảm dần" }));
        orderby.setSelectedIndex(-1);
        orderby.setToolTipText("Sắp xếp");
        orderby.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(164, 145, 145), 2));
        orderby.setFocusable(false);
        orderby.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                orderbyActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(108, 91, 123));
        jLabel1.setText("Sắp xếp theo");

        cmdShowBill.setBackground(new java.awt.Color(108, 91, 123));
        cmdShowBill.setForeground(new java.awt.Color(255, 255, 255));
        cmdShowBill.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icons/clipboard.png"))); // NOI18N
        cmdShowBill.setText("XEM HÓA ĐƠN");
        cmdShowBill.setFocusable(false);
        cmdShowBill.setFont(new java.awt.Font("Segoe UI", 0, 14)); // NOI18N
        cmdShowBill.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdShowBillActionPerformed(evt);
            }
        });

        lbTable.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        lbTable.setForeground(new java.awt.Color(89, 89, 89));
        lbTable.setText("MÃ BÀN CỦA BẠN");

        txtTableName.setEditable(false);
        txtTableName.setHorizontalAlignment(javax.swing.JTextField.CENTER);
        txtTableName.setText("Chưa đặt bàn");
        txtTableName.setFont(new java.awt.Font("sansserif", 0, 18)); // NOI18N

        jSeparator2.setBackground(new java.awt.Color(76, 76, 76));

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(txtSearch, javax.swing.GroupLayout.PREFERRED_SIZE, 400, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jLabel1)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(lbTitle)
                                .addGap(559, 559, 559)))
                        .addComponent(orderby, javax.swing.GroupLayout.PREFERRED_SIZE, 128, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(lbTable)
                        .addGap(38, 38, 38)
                        .addComponent(txtTableName, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(cmdShowBill, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jSeparator2))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(lbTitle)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(cmdShowBill, javax.swing.GroupLayout.PREFERRED_SIZE, 38, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lbTable, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtTableName, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 1, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(orderby)
                    .addComponent(txtSearch, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 542, Short.MAX_VALUE)
                .addContainerGap())
        );

        add(jPanel1);
    }// </editor-fold>//GEN-END:initComponents

    private void txtSearchMouseEntered(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_txtSearchMouseEntered
        searchFood(txtSearch.getText().trim());
    }//GEN-LAST:event_txtSearchMouseEntered

    private void txtSearchActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtSearchActionPerformed
        searchFood(txtSearch.getText().trim());
    }//GEN-LAST:event_txtSearchActionPerformed

    private void orderbyActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_orderbyActionPerformed
        initMenuFoodOrderby((String) orderby.getSelectedItem());
    }//GEN-LAST:event_orderbyActionPerformed

    private void cmdShowBillActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdShowBillActionPerformed
        try {
            hoaDon = service.FindHoaDon(customer);
            obj.showBill(hoaDon);
        } catch (SQLException ex) {
            Logger.getLogger(Suggested_dishes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_cmdShowBillActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private RTDRestaurant.View.Swing.Button cmdShowBill;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSeparator jSeparator2;
    private javax.swing.JLabel lbTable;
    private javax.swing.JLabel lbTitle;
    private javax.swing.JComboBox<String> orderby;
    private javax.swing.JPanel panel;
    private RTDRestaurant.View.Swing.MyTextField txtSearch;
    private RTDRestaurant.View.Swing.MyTextField txtTableName;
    // End of variables declaration//GEN-END:variables
}
