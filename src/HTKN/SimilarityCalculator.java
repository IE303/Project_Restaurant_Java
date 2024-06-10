package HTKN;

import java.util.Map;
import java.util.Set;
import java.util.HashSet;

public class SimilarityCalculator {
    public static double cosineSimilarity(Map<Integer, Integer> vectorA, Map<Integer, Integer> vectorB) {
        if (vectorA == null || vectorB == null) {
            throw new NullPointerException("Vectors must not be null");
        }

        Set<Integer> commonKeys = new HashSet<>(vectorA.keySet());
        commonKeys.retainAll(vectorB.keySet());

        double dotProduct = 0;
        double normA = 0;
        double normB = 0;

        for (int key : commonKeys) {
            dotProduct += vectorA.get(key) * vectorB.get(key);
        }

        for (int value : vectorA.values()) {
            normA += Math.pow(value, 2);
        }

        for (int value : vectorB.values()) {
            normB += Math.pow(value, 2);
        }

        double similarity = dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
        System.out.println("Similarity: " + similarity);
        return similarity;
    }
}