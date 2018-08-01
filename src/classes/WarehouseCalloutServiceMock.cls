@isTest
global class WarehouseCalloutServiceMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://th-superbadge-apex.herokuapp.com/equipment', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"id":"food","quantity":5,"name":"Generator 1000 kW","lifespan":120,"cost":5000,"sku":"100003"},{"replacement":true,"quantity":183,"name":"Cooling Fan","maintenanceperiod":0,"lifespan":0,"cost":300,"sku":"100004"}]');
        res.setStatusCode(200);
        return res;
    }

}