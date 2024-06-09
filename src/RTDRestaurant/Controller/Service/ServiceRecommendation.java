//add ServiceRecommendation class
package RTDRestaurant.Controller.Service;

import RTDRestaurant.Model.ModelRecommendation;
import RTDRestaurant.Repository.RecommendationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class ServiceRecommendation {
    @Autowired
    private RecommendationRepository recommendationRepository;

    public List<Recommendation> getRecommendationsByUser(String userId) {
        return recommendationRepository.findByUserId(userId);
    }

    public List<Recommendation> getRecommendationsByRestaurant(String restaurantId) {
        return recommendationRepository.findByRestaurantId(restaurantId);
    }

    public void addRecommendation(Recommendation recommendation) {
        recommendationRepository.save(recommendation);
    }

    public void updateRecommendation(Recommendation recommendation) {
        recommendationRepository.save(recommendation);
    }

    public void deleteRecommendation(String recommendationId) {
        recommendationRepository.deleteById(recommendationId);
    }
}