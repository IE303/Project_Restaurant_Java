package RTDRestaurant.repository;

import RTDRestaurant.Model.ModelRecommendation;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface RepositoryRecommedation extends JpaRepository<ModelRecommendation, String>{
    List<ModelRecommendation> findByUserId(String userId);
    List<ModelRecommendation> findByRestaurantId(String restaurantId);
    void deleteById(String recommendationId);
    
}
