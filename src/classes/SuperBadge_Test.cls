@isTest
private class SuperBadge_Test
{
	@testSetup  static void setup() {
		List<Case> cases = new List<Case>();
		List<Product2> products = new List<Product2>();
		List<Work_Part__c> wps = new List<Work_Part__c>();
		insert new Vehicle__c(Name='veh');

		cases.add(new Case(
        	Status = 'New',
        	Type = 'Routine Maintenance'
		));		
		cases.add(new Case(
        	Status = 'New',
        	Type = 'Repair'
		));
		cases.add(new Case(
        	Status = 'New',
        	Type = 'Mechanical'
		));

		insert cases;

		for (Integer i = 0; i < 3; i++) {
		   products.add(new Product2( Name = String.valueOf(i), Maintenance_Cycle__c = i, Replacement_Part__c = true));
		}
		insert products;

		for (Integer i = 0; i < 3; i++) {
		   wps.add(new Work_Part__c( Maintenance_Request__c = cases[0].Id, Equipment__c = products[i].Id));
		}
		insert wps;




	}
	
	@isTest
	static void testBatch()
	{
		List<Case> cases = new List<Case>();

		for (Integer i = 0; i < 300; i++) {
		   cases.add(new Case(
				Status = 'Closed',
				Type = 'Routine Maintenance'
			));	
		}

		Test.startTest();
		insert cases;
		Test.stopTest();

		System.assertNotEquals(cases, null);
		System.assertEquals([SELECT COUNT() FROM Case], 603);
	}

	@isTest
	static void testInsert()
	{
		List<Case> cases = new List<Case>();

		cases.add(new Case(
        	Status = 'Closed',
        	Type = 'Routine Maintenance'
		));		
		cases.add(new Case(
        	Status = 'Closed',
        	Type = 'Repair'
		));
		cases.add(new Case(
        	Status = 'Closed',
        	Type = 'Mechanical'
		));
		Test.startTest();
		insert cases;
		Test.stopTest();

		System.assertNotEquals(cases, null);
		System.assertEquals([SELECT COUNT() FROM Case], 8);
	}

	@isTest
	static void testUpdate()
	{
		List<Case> cases = [SELECT Status, Type FROM Case];
		List<Case> newCases = new List<Case>();
		Test.startTest();
			for (Case req : cases) {
			req.Status = 'Closed';
			newCases.add(req);
			}
			update newCases;
		Test.stopTest();

		System.assertNotEquals(newCases, null);
		System.assertEquals([SELECT COUNT() FROM Case], 5);
	}

	
	
}