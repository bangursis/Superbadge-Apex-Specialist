@isTest
private class WarehouseCalloutServiceTest {
  @isTest static void testCallout() {
    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());

    Test.startTest();
    WarehouseCalloutService.runWarehouseEquipmentSync();
    Test.stopTest();

    System.assertEquals(WarehouseCalloutService.errors.size(), 1);
  }

  @isTest static void testReplacer(){
    String JsonString = WarehouseCalloutService.replacer('replacement maintenanceperiod lifespan cost sku');
    String result = 'Replacement_Part__c Maintenance_Cycle__c Lifespan_Months__c Cost__c Warehouse_SKU__c';

    System.assertEquals(JsonString, result);


  }
}