global class WarehouseSyncSchedule implements Schedulable{

  // global static String scheduleIt() {
  //   WarehouseSyncSchedule wss = new WarehouseSyncSchedule();
  //   return System.schedule('Callout', '0 0 1 * * ?', wss);
  // }

  global void execute(SchedulableContext sc){
    WarehouseCalloutService.runWarehouseEquipmentSync();
  }
}