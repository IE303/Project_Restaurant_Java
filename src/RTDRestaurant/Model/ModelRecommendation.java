package RTDRestaurant.Model;

public class ModelRecommendation {
    private String recommendationId;
    private String userId;
    private String restaurantId;
    private String content;
    private int rating;

    public ModelRecommendation() {
    }

    public ModelRecommendation(String recommendationId, String userId, String restaurantId, String content, int rating) {
        this.recommendationId = recommendationId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.content = content;
        this.rating = rating;
    }

    public String getRecommendationId() {
        return recommendationId;
    }

    public void setRecommendationId(String recommendationId) {
        this.recommendationId = recommendationId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(String restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }
}
