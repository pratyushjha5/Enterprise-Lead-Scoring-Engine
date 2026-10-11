public with sharing class LeadScoringService {
    
    // Calculates a dynamic score and assigns a standard Rating
    public static void calculateScore(List<Lead> leads) {
        for (Lead l : leads) {
            Integer score = 0;
            
            if (String.isNotBlank(l.Industry) && (l.Industry == 'Technology' || l.Industry == 'Finance')) {
                score += 25;
            }
            if (l.AnnualRevenue != null && l.AnnualRevenue >= 1000000) {
                score += 35;
            }
            if (String.isNotBlank(l.Title) && (l.Title.containsIgnoreCase('CEO') || l.Title.containsIgnoreCase('VP'))) {
                score += 40;
            }
            
            // Assign standard Rating field based on algorithmic score
            if (score >= 80) {
                l.Rating = 'Hot';
            } else if (score >= 50) {
                l.Rating = 'Warm';
            } else {
                l.Rating = 'Cold';
            }
        }
    }

    // Fetches top leads for the LWC Dashboard, enforcing user security
    @AuraEnabled(cacheable=true)
    public static List<Lead> getHotLeads() {
        return [SELECT Id, Name, Title, Company, Rating, Status, AnnualRevenue 
                FROM Lead 
                WHERE Rating = 'Hot' AND Status = 'Open - Not Contacted' 
                WITH SECURITY_ENFORCED 
                ORDER BY CreatedDate DESC 
                LIMIT 20];
    }

    // Allows LWC to update Lead Status imperatively
    @AuraEnabled
    public static void updateLeadStatus(Id leadId, String newStatus) {
        try {
            Lead l = new Lead(Id = leadId, Status = newStatus);
            update l;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating Lead: ' + e.getMessage());
        }
    }
}