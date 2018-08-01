public class MaintenanceRequestHelper {

    public static void createNewCase(List<Case> cases){
        List<Case> newCases = new List<Case>();

        for(Case request : cases){
            Case newCase = new Case();

            newCase.Status = 'New';
            newCase.Type = 'Routine Maintenance';
            newCase.Subject = 'New Maintenance Requests';
            newCase.Vehicle__c = request.Vehicle__c;
            newCase.Equipment__c = request.Equipment__c;
            newCase.Date_Reported__c = date.today();
            newCase.Date_Due__c = date.today() + (Integer) MaintenanceRequestHelper.calculateShortestCycle(request.Work_Parts__r);

            newCases.add(newCase);
        }
        insert newCases;
    }

    private static Decimal calculateShortestCycle (List<Work_Part__c> workParts){
        Decimal result = 0;
        for (Work_Part__c workPart : workParts) {
           if(workPart.Equipment__r.Maintenance_Cycle__c  < result || result == 0)
            result = workPart.Equipment__r.Maintenance_Cycle__c ;
        }

        return result;
    }
    
}