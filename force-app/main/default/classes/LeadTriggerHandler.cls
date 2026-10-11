public with sharing class LeadTriggerHandler {
    
    public static void handleBeforeInsert(List<Lead> newLeads) {
        LeadScoringService.calculateScore(newLeads);
    }
    
    public static void handleBeforeUpdate(List<Lead> newLeads, Map<Id, Lead> oldLeadsMap) {
        List<Lead> leadsToRescore = new List<Lead>();
        
        // Only recalculate if key scoring fields have changed to optimize CPU time
        for (Lead l : newLeads) {
            Lead oldLead = oldLeadsMap.get(l.Id);
            if (l.Industry != oldLead.Industry || l.AnnualRevenue != oldLead.AnnualRevenue || l.Title != oldLead.Title) {
                leadsToRescore.add(l);
            }
        }
        
        if (!leadsToRescore.isEmpty()) {
            LeadScoringService.calculateScore(leadsToRescore);
        }
    }
}