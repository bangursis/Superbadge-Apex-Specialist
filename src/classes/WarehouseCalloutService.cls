public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    public static List<Database.Error> errors = new List<Database.Error>();

    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();

        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');
        res = http.send(req);

        List<Product2> products = (List<Product2>)JSON.deserialize(res.getBody(), List<Product2>.Class);

        Database.upsertResult[] svs =  Database.upsert(products, false);

        for (Database.upsertResult sv : svs) {
           if (!sv.isSuccess()) {
              for (Database.Error err : sv.getErrors()) {
                 System.debug(err.getStatusCode() + ': ' + err.getMessage());
				 errors.add(err);
              }
           } else {
              System.debug('Successfully updated ' + sv.getId());
           }
        }
    }
    @TestVisible private static String replacer(String jsonString){
        return jsonString
            .replaceAll('replacement','Replacement_Part__c')
            .replaceAll('maintenanceperiod','Maintenance_Cycle__c')
            .replaceAll('lifespan','Lifespan_Months__c')
            .replaceAll('cost','Cost__c')
            .replaceAll('sku','Warehouse_SKU__c')
            .replaceAll('name','Name')
            .replaceAll('quantity','Current_Inventory__c');
    }
}