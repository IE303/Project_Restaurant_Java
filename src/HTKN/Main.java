package HTKN;

import RTDRestaurant.Controller.Service.ServiceCustomer;
import RTDRestaurant.Model.ModelMonAn;
import RTDRestaurant.Model.ModelNguoiDung;
import RTDRestaurant.Model.ModelKhachHang;
import java.sql.SQLException;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        // Giả sử bạn đã xác thực người dùng và có thông tin người dùng
        ModelNguoiDung loggedInUser = new ModelNguoiDung(1, "user@example.com", "password", "CUSTOMER");

        try {
            ServiceCustomer serviceCustomer = new ServiceCustomer();
            // Lấy thông tin khách hàng từ ID người dùng
            ModelKhachHang customer = serviceCustomer.getCustomer(loggedInUser.getUserID());
            if (customer == null) {
                System.out.println("No customer found for user ID: " + loggedInUser.getUserID());
                return;
            }

            List<ModelMonAn> recommendations = serviceCustomer.getRecommendedDishes(loggedInUser);
            if (recommendations.isEmpty()) {
                System.out.println("No recommendations available for customer " + customer.getID_KH());
            } else {
                System.out.println("Recommended dishes for customer " + customer.getID_KH() + ": " + recommendations);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving recommendations: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
