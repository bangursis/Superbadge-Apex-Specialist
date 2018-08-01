@isTest
private class TestSchedulable
{
	@isTest
	static void itShould()
	{
		Test.startTest();
			Test.SetMock(HttpCallOutMock.class, new warehouseCalloutServiceMock());
			WarehouseSyncSchedule wss = new WarehouseSyncSchedule();
			String CRON_EXP = '0 0 0 15 3 ? *';
			String jobID = System.schedule('Test the Queue Status', CRON_EXP, wss);
        Test.stopTest();

        CronTrigger cTId = [SELECT State FROM CronTrigger WHERE Id = :jobID];
        System.assertEquals('WAITING', String.valueOf(cTId.State), 'jobID Doesnt Match');
	}
}