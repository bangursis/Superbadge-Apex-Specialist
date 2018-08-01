trigger MaintenanceRequest on Case (after insert, after update) {
    List<Case> cases = [
        SELECT Vehicle__c, Product__c, Equipment__c, (SELECT Id, Equipment__r.Maintenance_Cycle__c FROM Work_Parts__r)
        FROM Case
        WHERE Status = 'Closed' 
        AND (
            Type='Repair' OR Type='Routine Maintenance'
        )
        AND Id IN :Trigger.newMap.keySet()
    ];

    MaintenanceRequestHelper.createNewCase(cases);
}