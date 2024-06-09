package RTDRestaurant.Controller;

import RTDRestaurant.Model.ModelRecommendation;
import RTDRestaurant.Controller.Service.ServiceRecommendation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/recommendations")
public class RecommendationController {

    private final ServiceRecommendation recommendationService;

    @Autowired
    public RecommendationController(ServiceRecommendation recommendationService) {
        this.recommendationService = recommendationService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<List<ModelRecommendation>> getRecommendationsByUserId(@PathVariable("userId") String userId) {
        List<ModelRecommendation> recommendations = recommendationService.getRecommendationsByUserId(userId);
        return new ResponseEntity<>(recommendations, HttpStatus.OK);
    }
}
