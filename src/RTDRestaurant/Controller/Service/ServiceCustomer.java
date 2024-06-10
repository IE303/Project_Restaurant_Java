package RTDRestaurant.Controller.Service;

import RTDRestaurant.Controller.Connection.DatabaseConnection;
import RTDRestaurant.Model.ModelCTHD;
import RTDRestaurant.Model.ModelMonAn;
import RTDRestaurant.Model.ModelKhachHang;
import RTDRestaurant.Model.ModelHoaDon;
import RTDRestaurant.Model.ModelVoucher;
import RTDRestaurant.Model.ModelBan;
import RTDRestaurant.Model.ModelNguoiDung;
import HTKN.DatabaseConnector;
import HTKN.RecommendationSystem;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.swing.ImageIcon;

public class ServiceCustomer {

    private Connection con;

    // Connect to Database       
    public ServiceCustomer() {
        con = DatabaseConnection.getInstance().getConnection();
    }

    // Ensure connection is open
    private void ensureConnectionOpen() throws SQLException {
        if (con == null || con.isClosed()) {
            con = DatabaseConnection.getInstance().getConnection();
            if (con == null) {
                throw new RuntimeException("Không thể kết nối đến cơ sở dữ liệu.");
            }
    }

    }
    
    // Close the connection
    private void closeConnection() throws SQLException {
        if (con == null || con.isClosed()) {
            con = DatabaseConnection.getInstance().getConnection();
            if (con == null) {
                throw new RuntimeException("Không thể kết nối đến cơ sở dữ liệu.");
            }
        }
    }
    
    public ModelKhachHang getCustomer(int userId) throws SQLException {
        ensureConnectionOpen();
        String sql = "SELECT * FROM KhachHang WHERE ID_ND = ?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, userId);
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    int idKH = r.getInt("ID_KH");
                    String name = r.getString("TenKH");
                    String dateJoin = r.getString("Ngaythamgia");
                    int sales = r.getInt("Doanhso");
                    int points = r.getInt("Diemtichluy"); // Sử dụng tên cột đúng
                    return new ModelKhachHang(idKH, name, dateJoin, sales, points);
                }
            }
        } finally {
            // Không đóng kết nối ở đây để tránh lỗi "No operations allowed after connection closed"
        }
        return null;
    }

    public List<ModelMonAn> getRecommendedDishes(ModelNguoiDung user) throws SQLException {
        ensureConnectionOpen();
        // Lấy thông tin khách hàng từ ID người dùng
        ModelKhachHang customer = getCustomer(user.getUserID());
        if (customer == null) {
            throw new SQLException("No customer found for user ID: " + user.getUserID());
        }
        int customerId = customer.getID_KH(); // Giả sử getIdKH() là phương thức lấy ID khách hàng

        Map<Integer, Map<Integer, Integer>> customerOrders = DatabaseConnector.getCustomerOrders();
        RecommendationSystem recommendationSystem = new RecommendationSystem(customerOrders);
        List<Integer> recommendedDishIds = recommendationSystem.getDishRecommendations(customerId, 5);

        List<ModelMonAn> recommendedDishes = new ArrayList<>();
        for (int dishId : recommendedDishIds) {
            ModelMonAn dish = getDishById(dishId);
            if (dish != null) {
                recommendedDishes.add(dish);
            }
        }
        return recommendedDishes;
    }

    private ModelMonAn getDishById(int dishId) throws SQLException {
        ensureConnectionOpen();
        String sql = "SELECT ID_MonAn, TenMon, DonGia, Loai FROM MonAn WHERE ID_MonAn = ?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, dishId);
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    int id = r.getInt("ID_MonAn");
                    String name = r.getString("TenMon");
                    int value = r.getInt("DonGia");
                    String type = r.getString("Loai");
                    String imagePath = "/Icons/Food/" + type + "/" + id + ".jpg";
                    ImageIcon imageIcon;
                    try {
                        imageIcon = new ImageIcon(getClass().getResource(imagePath));
                    } catch (Exception e) {
                        imageIcon = new ImageIcon(getClass().getResource("/Icons/Food/Unknown/unknown.jpg"));
                    }
                    return new ModelMonAn(imageIcon, id, name, value, type);
                }
            }
        }
        return null;
    }

    public ArrayList<ModelMonAn> MenuFood(String type, String orderBy) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelMonAn> list = new ArrayList<>();
        String sql = "SELECT ID_MonAn,TenMon,DonGia FROM MonAn WHERE Loai=? AND TrangThai='Dang kinh doanh'";
        switch (orderBy) {
            case "Tên A->Z" -> sql += " ORDER BY TenMon";
            case "Giá tăng dần" -> sql += " ORDER BY DonGia";
            case "Giá giảm dần" -> sql += " ORDER BY DonGia DESC";
        }
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setString(1, type);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    int id = r.getInt("ID_MonAn");
                    String name = r.getString("TenMon");
                    int value = r.getInt("DonGia");
                    ModelMonAn data;
                    if (id < 90) {
                        data = new ModelMonAn(new ImageIcon(getClass().getResource("/Icons/Food/" + type + "/" + id + ".jpg")), id, name, value, type);
                    } else {
                        data = new ModelMonAn(new ImageIcon(getClass().getResource("/Icons/Food/Unknown/unknown.jpg")), id, name, value, type);
                    }
                    list.add(data);
                }
            }
        }
        return list;
    }
    
        public ArrayList<ModelMonAn> MenuFoodOrder(String type, String orderBy) throws SQLException {
        ArrayList<ModelMonAn> list = new ArrayList<>();

        String sql = "SELECT ID_MonAn,TenMon,DonGia FROM MonAn WHERE Loai=? AND TrangThai='Dang kinh doanh'";
        switch (orderBy) {
            case "Tên A->Z" -> {
                sql = "SELECT ID_MonAn,TenMon,DonGia FROM MonAn WHERE Loai=? AND TrangThai='Dang kinh doanh' ORDER BY TenMon";
            }
            case "Giá tăng dần" -> {
                sql = "SELECT ID_MonAn,TenMon,DonGia FROM MonAn WHERE Loai=? AND TrangThai='Dang kinh doanh' ORDER BY DonGia";
            }
            case "Giá giảm dần" -> {
                sql = "SELECT ID_MonAn,TenMon,DonGia FROM MonAn WHERE Loai=? AND TrangThai='Dang kinh doanh' ORDER BY DonGia DESC";
            }
        }
        PreparedStatement p = con.prepareStatement(sql);
        p.setString(1, type);

        ResultSet r = p.executeQuery();
        while (r.next()) {
            int id = r.getInt("ID_MonAn");
            String name = r.getString("TenMon");
            int value = r.getInt("DonGia");
            ModelMonAn data;
            if (id < 90) {
                data = new ModelMonAn(new ImageIcon(getClass().getResource("/Icons/Food/" + type + "/" + id + ".jpg")), id, name, value, type);
            } else {
                data = new ModelMonAn(new ImageIcon(getClass().getResource("/Icons/Food/Unknown/unknown.jpg")), id, name, value, type);
            }
            list.add(data);
        }
        r.close();
        p.close();
        return list;
    }

    public ArrayList<ModelBan> MenuTable(String floor) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelBan> list = new ArrayList<>();
        String sql = "SELECT ID_Ban,TenBan,Trangthai FROM Ban WHERE Vitri=?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setString(1, floor);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    int id = r.getInt("ID_Ban");
                    String name = r.getString("TenBan");
                    String status = r.getString("Trangthai");
                    list.add(new ModelBan(id, name, status));
                }
            }
        }
        return list;
    }

    public ArrayList<ModelBan> MenuTableState(String floor, String state) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelBan> list = new ArrayList<>();
        String sql = "SELECT ID_Ban,TenBan,Trangthai FROM Ban WHERE Vitri=?";
        switch (state) {
            case "Còn trống" -> sql += " AND Trangthai='Con trong'";
            case "Đã đặt trước" -> sql += " AND Trangthai='Da dat truoc'";
            case "Đang dùng bữa" -> sql += " AND Trangthai='Dang dung bua'";
        }
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setString(1, floor);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    int id = r.getInt("ID_Ban");
                    String name = r.getString("TenBan");
                    String status = r.getString("Trangthai");
                    list.add(new ModelBan(id, name, status));
                }
            }
        }
        return list;
    }

    public void reNameCustomer(ModelKhachHang data) throws SQLException {
        ensureConnectionOpen();
        String sql = "UPDATE KhachHang SET TenKH=? WHERE ID_KH=?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setString(1, data.getName());
            p.setInt(2, data.getID_KH());
            p.execute();
        }
    }

    public ArrayList<ModelVoucher> MenuVoucher() throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelVoucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher";
        try (PreparedStatement p = con.prepareStatement(sql);
             ResultSet r = p.executeQuery()) {
            while (r.next()) {
                String code = r.getString("Code_Voucher");
                String desc = r.getString("Mota");
                int percent = r.getInt("Phantram");
                String typeMenu = r.getString("LoaiMA");
                int quantity = r.getInt("SoLuong");
                int point = r.getInt("Diem");
                list.add(new ModelVoucher(code, desc, percent, typeMenu, quantity, point));
            }
        }
        return list;
    }
    

    public ArrayList<ModelVoucher> MenuVoucherbyPoint(String bypoint) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelVoucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher";
        switch (bypoint) {
            case "Dưới 300 xu":
                sql += " WHERE Diem <300";
                break;
            case "Từ 300 đến 500 xu":
                sql += " WHERE Diem BETWEEN 300 AND 501";
                break;
            case "Trên 500 xu":
                sql += " WHERE Diem >500";
                break;
        }
        try (PreparedStatement p = con.prepareStatement(sql);
             ResultSet r = p.executeQuery()) {
            while (r.next()) {
                String code = r.getString("Code_Voucher");
                String desc = r.getString("Mota");
                int percent = r.getInt("Phantram");
                String typeMenu = r.getString("LoaiMA");
                int quantity = r.getInt("SoLuong");
                int point = r.getInt("Diem");
                list.add(new ModelVoucher(code, desc, percent, typeMenu, quantity, point));
            }
        }
        return list;
    }

    public void InsertHoaDon(ModelBan table, ModelKhachHang customer) throws SQLException {
        ensureConnectionOpen();
        int idHD = 0;
        String sqlID = "SELECT MAX(ID_HoaDon) + 1 FROM HoaDon";
        try (PreparedStatement pID = con.prepareStatement(sqlID);
             ResultSet rID = pID.executeQuery()) {
            if (rID.next()) {
                idHD = rID.getInt(1);
            }
        }

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MM-YYYY");
        String sql = "INSERT INTO HoaDon(ID_HoaDon, ID_KH, ID_Ban, NgayHD, TienMonAn, TienGiam, Trangthai) " +
                     "VALUES (?, ?, ?, STR_TO_DATE(?, '%d-%m-%Y'), 0, 0, 'Chua thanh toan')";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, idHD);
            p.setInt(2, customer.getID_KH());
            p.setInt(3, table.getID());
            p.setString(4, simpleDateFormat.format(new Date()));
            p.execute();
        }
    }

    public ModelHoaDon FindHoaDon(ModelKhachHang customer) throws SQLException {
        ensureConnectionOpen();
        String sql = "SELECT ID_HoaDon, ID_KH, ID_Ban, DATE_FORMAT(NgayHD, '%d-%m-%Y') AS Ngay, TienMonAn, Code_Voucher, TienGiam, Tongtien, Trangthai " +
                     "FROM HoaDon WHERE ID_KH = ? AND Trangthai = 'Chua thanh toan'";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, customer.getID_KH());
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    int idHoaDon = r.getInt(1);
                    int idKH = r.getInt(2);
                    int idBan = r.getInt(3);
                    String ngayHD = r.getString(4);
                    int tienMonAn = r.getInt(5);
                    String codeVoucher = r.getString(6);
                    int tienGiam = r.getInt(7);
                    int tongTien = r.getInt(8);
                    String trangThai = r.getString(9);
                    return new ModelHoaDon(idHoaDon, idKH, idBan, ngayHD, tienMonAn, codeVoucher, tienGiam, tongTien, trangThai);
                }
            }
        }
        return null;
    }

    public void InsertCTHD(int ID_HoaDon, int ID_MonAn, int soLuong) throws SQLException {
        ensureConnectionOpen();
        String sqlCheck = "SELECT 1 FROM CTHD WHERE ID_HoaDon=? AND ID_MonAn=?";
        try (PreparedStatement pCheck = con.prepareStatement(sqlCheck)) {
            pCheck.setInt(1, ID_HoaDon);
            pCheck.setInt(2, ID_MonAn);
            try (ResultSet r = pCheck.executeQuery()) {
                if (r.next()) {
                    String sqlUpdate = "UPDATE CTHD SET SoLuong=SoLuong+? WHERE ID_HoaDon=? AND ID_MonAn=?";
                    try (PreparedStatement pUpdate = con.prepareStatement(sqlUpdate)) {
                        pUpdate.setInt(1, soLuong);
                        pUpdate.setInt(2, ID_HoaDon);
                        pUpdate.setInt(3, ID_MonAn);
                        pUpdate.execute();
                    }
                } else {
                    String sqlInsert = "INSERT INTO CTHD(ID_HoaDon,ID_MonAn,SoLuong) VALUES (?,?,?)";
                    try (PreparedStatement pInsert = con.prepareStatement(sqlInsert)) {
                        pInsert.setInt(1, ID_HoaDon);
                        pInsert.setInt(2, ID_MonAn);
                        pInsert.setInt(3, soLuong);
                        pInsert.execute();
                    }
                }
            }
        }
    }

    public void updateThanhTien(int ID_HoaDon) throws SQLException {
        ensureConnectionOpen();
        String sql = "UPDATE CTHD c " +
                     "JOIN MonAn m ON c.ID_MonAn = m.ID_MonAn " +
                     "SET c.Thanhtien = c.SoLuong * m.Dongia " +
                     "WHERE c.ID_HoaDon = ?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_HoaDon);
            p.executeUpdate();
        }
    }

    public void updateTienMonAn(int ID_HoaDon) throws SQLException {
        ensureConnectionOpen();
        String sql = "UPDATE HoaDon h " +
                     "JOIN (SELECT ID_HoaDon, SUM(Thanhtien) AS TongThanhTien FROM CTHD WHERE ID_HoaDon = ? GROUP BY ID_HoaDon) c " +
                     "ON h.ID_HoaDon = c.ID_HoaDon " +
                     "SET h.TienMonAn = c.TongThanhTien " +
                     "WHERE h.ID_HoaDon = ?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_HoaDon);
            p.setInt(2, ID_HoaDon);
            p.executeUpdate();
        }
    }

    public void updateTongTien(int ID_HoaDon) throws SQLException {
        ensureConnectionOpen();
        String sql = "UPDATE HoaDon h " +
                     "SET h.Tongtien = h.TienMonAn - h.TienGiam " +
                     "WHERE h.ID_HoaDon = ?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_HoaDon);
            p.executeUpdate();
        }
    }

    public void setTableOrdingFood(int ID_hoadon) throws SQLException {
        ensureConnectionOpen();
        int idBan = FindIdBanFromIdHoaDon(ID_hoadon);
        String sql = "UPDATE BAN SET TrangThai = 'Dang dung bua' WHERE ID_Ban=?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, idBan);
            p.execute();
        }
    }

    public int FindIdBanFromIdHoaDon(int ID_hoadon) throws SQLException {
        ensureConnectionOpen();
        String sql = "SELECT ID_Ban FROM HoaDon WHERE ID_HoaDon = ?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_hoadon);
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    return r.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public ArrayList<ModelCTHD> getCTHD(int ID_HoaDon) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelCTHD> list = new ArrayList<>();
        String sql = "SELECT ID_HoaDon, CTHD.ID_MonAn, TenMon, SoLuong, Thanhtien FROM CTHD " +
                     "JOIN MonAn ON MonAn.ID_MonAn = CTHD.ID_MonAn WHERE ID_HoaDon=?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_HoaDon);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    int ID_HD = r.getInt(1);
                    int ID_MonAn = r.getInt(2);
                    String tenMonAn = r.getString(3);
                    int soLuong = r.getInt(4);
                    int thanhTien = r.getInt(5);
                    ModelCTHD data = new ModelCTHD(ID_HD, ID_MonAn, tenMonAn, soLuong, thanhTien);
                    list.add(data);
                }
            }
        }
        return list;                
    }                    

    public ArrayList<ModelHoaDon> getListHD(int ID_KH) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelHoaDon> list = new ArrayList<>();
        String sql = "SELECT ID_HoaDon, ID_KH, ID_Ban, DATE_FORMAT(NgayHD, '%d-%m-%Y') AS Ngay, TienMonAn, Code_Voucher, TienGiam, Tongtien, Trangthai FROM HoaDon " +
                     "WHERE ID_KH=? ORDER BY ID_HoaDon";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_KH);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    int idHoaDon = r.getInt(1);
                    int idKH = r.getInt(2);
                    int idBan = r.getInt(3);
                    String ngayHD = r.getString(4);
                    int tienMonAn = r.getInt(5);
                    String codeVoucher = r.getString(6);
                    int tienGiam = r.getInt(7);
                    int tongTien = r.getInt(8);
                    String trangThai = r.getString(9);
                    ModelHoaDon hoadon = new ModelHoaDon(idHoaDon, idKH, idBan, ngayHD, tienMonAn, codeVoucher, tienGiam, tongTien, trangThai);
                    list.add(hoadon);
                }
            }
        }
        return list;
    }

    public ArrayList<ModelHoaDon> getListHDOrder(int ID_KH, String order) throws SQLException {
        ensureConnectionOpen();
        ArrayList<ModelHoaDon> list = new ArrayList<>();
        String sql = "SELECT ID_HoaDon, ID_KH, ID_Ban, DATE_FORMAT(NgayHD, '%d-%m-%Y') AS Ngay, TienMonAn, Code_Voucher, TienGiam, Tongtien, Trangthai FROM HoaDon " +
                     "WHERE ID_KH=? ORDER BY ID_HoaDon";
        switch (order) {
            case "Dưới 1.000.000đ":
                sql = "SELECT ID_HoaDon, ID_KH, ID_Ban, DATE_FORMAT(NgayHD, '%d-%m-%Y') AS Ngay, TienMonAn, Code_Voucher, TienGiam, Tongtien, Trangthai FROM HoaDon " +
                      "WHERE ID_KH=? AND Tongtien <1000000 ORDER BY ID_HoaDon";
                break;
            case "Từ 1 đến 5.000.000đ":
                sql = "SELECT ID_HoaDon, ID_KH, ID_Ban, DATE_FORMAT(NgayHD, '%d-%m-%Y') AS Ngay, TienMonAn, Code_Voucher, TienGiam, Tongtien, Trangthai FROM HoaDon " +
                      "WHERE ID_KH=? AND Tongtien BETWEEN 1000000 AND 5000001 ORDER BY ID_HoaDon";
                break;
            case "Trên 5.000.000đ":
                sql = "SELECT ID_HoaDon, ID_KH, ID_Ban, DATE_FORMAT(NgayHD, '%d-%m-%Y') AS Ngay, TienMonAn, Code_Voucher, TienGiam, Tongtien, Trangthai FROM HoaDon " +
                      "WHERE ID_KH=? AND Tongtien >5000000 ORDER BY ID_HoaDon";
                break;
        }
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setInt(1, ID_KH);
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    int idHoaDon = r.getInt(1);
                    int idKH = r.getInt(2);
                    int idBan = r.getInt(3);
                    String ngayHD = r.getString(4);
                    int tienMonAn = r.getInt(5);
                    String codeVoucher = r.getString(6);
                    int tienGiam = r.getInt(7);
                    int tongTien = r.getInt(8);
                    String trangThai = r.getString(9);
                    ModelHoaDon hoadon = new ModelHoaDon(idHoaDon, idKH, idBan, ngayHD, tienMonAn, codeVoucher, tienGiam, tongTien, trangThai);
                    list.add(hoadon);
                }
            }
        }
        return list;
    }

    public void exchangeVoucher(int ID_HoaDon, String Code_Voucher) throws SQLException {
        ensureConnectionOpen();
        String sql = "UPDATE HoaDon SET Code_Voucher=? WHERE ID_HoaDon=?";
        try (PreparedStatement p = con.prepareStatement(sql)) {
            p.setString(1, Code_Voucher);
            p.setInt(2, ID_HoaDon);
            p.execute();
        }
    }
}