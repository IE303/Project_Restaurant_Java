package HTKN;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import RTDRestaurant.Controller.Connection.DatabaseConnection;

public class DatabaseConnector {
    public static Map<Integer, Map<Integer, Integer>> getCustomerOrders() {
        Map<Integer, Map<Integer, Integer>> customerOrders = new HashMap<>();

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT HoaDon.ID_KH, CTHD.ID_MonAn, CTHD.SoLuong FROM CTHD JOIN HoaDon ON CTHD.ID_HoaDon = HoaDon.ID_HoaDon")) {

            while (rs.next()) {
                int customerId = rs.getInt("ID_KH");
                int dishId = rs.getInt("ID_MonAn");
                int quantity = rs.getInt("SoLuong");

                customerOrders.computeIfAbsent(customerId, k -> new HashMap<>()).put(dishId, quantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customerOrders;
    }
}
