package HTKN;

import java.util.*;

public class RecommendationSystem {
    private Map<Integer, Map<Integer, Integer>> customerOrders;

    public RecommendationSystem(Map<Integer, Map<Integer, Integer>> customerOrders) {
        this.customerOrders = customerOrders;
    }

    public List<Integer> getDishRecommendations(int customerId, int numRecommendations) {
        Map<Integer, Integer> targetCustomerOrders = customerOrders.get(customerId);
        if (targetCustomerOrders == null) {
            throw new IllegalArgumentException("Customer ID not found");
        }
        
        System.out.println("Processing recommendations for Customer ID: " + customerId);

        Set<Integer> targetCustomerDishes = new HashSet<>(targetCustomerOrders.keySet());
        System.out.println("Target customer dishes: " + targetCustomerDishes);
        
        List<Map.Entry<Integer, Double>> sortedSimilarities = new ArrayList<>();
        for (Map.Entry<Integer, Map<Integer, Integer>> entry : customerOrders.entrySet()) {
            if (entry.getKey() != customerId) {
                double similarity = SimilarityCalculator.cosineSimilarity(targetCustomerOrders, entry.getValue());
                if (similarity > 0) {
                    sortedSimilarities.add(new AbstractMap.SimpleEntry<>(entry.getKey(), similarity));
                }
            }
        }

        // Sắp xếp các khách hàng dựa trên độ tương đồng giảm dần
        sortedSimilarities.sort(Map.Entry.comparingByValue(Comparator.reverseOrder()));

        List<Integer> recommendedDishes = new ArrayList<>();
        for (Map.Entry<Integer, Double> simEntry : sortedSimilarities) {
            if (recommendedDishes.size() >= numRecommendations) break;
            Integer similarCustomerId = simEntry.getKey();
            Map<Integer, Integer> similarCustomerOrders = customerOrders.get(similarCustomerId);
            
            // Thêm dòng in thông tin khách hàng tương tự và đơn hàng của họ
            System.out.println("Similar customer ID: " + similarCustomerId + " Orders: " + similarCustomerOrders);

            List<Integer> potentialDishes = new ArrayList<>();
            for (Integer dishId : similarCustomerOrders.keySet()) {
                if (!targetCustomerDishes.contains(dishId)) {
                    potentialDishes.add(dishId);
                }
            }
            // Sắp xếp các món ăn dựa trên tần suất xuất hiện trong đơn hàng của khách hàng tương tự
            potentialDishes.sort(Comparator.comparingInt(dish -> similarCustomerOrders.get(dish)).reversed());
            for (Integer dish : potentialDishes) {
                if (recommendedDishes.size() < numRecommendations) {
                    recommendedDishes.add(dish);
                    System.out.println("Added dish ID: " + dish);
                } else {
                    break;
                }
            }
        }

        return recommendedDishes;
    }

    public static void main(String[] args) {
        Map<Integer, Map<Integer, Integer>> customerOrders = DatabaseConnector.getCustomerOrders();
        RecommendationSystem recommendationSystem = new RecommendationSystem(customerOrders);
        List<Integer> recommendations = recommendationSystem.getDishRecommendations(1, 5);
        System.out.println("Recommended dishes for customer 1: " + recommendations);
    }
}