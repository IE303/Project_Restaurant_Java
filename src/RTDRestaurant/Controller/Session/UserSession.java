package RTDRestaurant.Controller.Session;

import RTDRestaurant.Model.ModelNguoiDung;

public class UserSession {
    private static ModelNguoiDung currentUser;

    public static void setCurrentUser(ModelNguoiDung user) {
        currentUser = user;
    }

    public static ModelNguoiDung getCurrentUser() {
        return currentUser;
    }

    public static int getUserID() {
        return currentUser != null ? currentUser.getUserID() : -1;
    }

    public static boolean isLoggedIn() {
        return currentUser != null;
    }

    public static void clearSession() {
        currentUser = null;
    }
}
