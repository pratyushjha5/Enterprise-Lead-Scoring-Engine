@isTest
private class LeadScoringServiceTest {
    
    @testSetup
    static void setupTestData() {
        List<Lead> testLeads = new List<Lead>{
            new Lead(LastName='Stark', Company='Stark Ind', Industry='Technology', AnnualRevenue=5000000, Title='CEO', Status='Open - Not Contacted'),
            new Lead(LastName='Banner', Company='Unknown', Industry='Agriculture', AnnualRevenue=10000, Title='Scientist', Status='Open - Not Contacted')
        };
        insert testLeads;
    }

    @isTest
    static void testScoringAlgorithm() {
        Test.startTest();
        List<Lead> leads = [SELECT LastName, Rating FROM Lead ORDER BY LastName];
        Test.stopTest();
        
        System.assertEquals('Cold', leads[0].Rating, 'Banner should be Cold');
        System.assertEquals('Hot', leads[1].Rating, 'Stark should be Hot based on revenue and title');
    }

    @isTest
    static void testGetHotLeads() {
        Test.startTest();
        List<Lead> hotLeads = LeadScoringService.getHotLeads();
        Test.stopTest();
        
        System.assertEquals(1, hotLeads.size(), 'Should only return one Hot lead');
        System.assertEquals('Stark Ind', hotLeads[0].Company, 'Company should match');
    }
}