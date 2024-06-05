@isTest
public with sharing class REST_ContactProductInformationTest {

    private static final String CONTACT_IDENTIFIER = 'UWHUDEIhiahiedu';

    @TestSetup
    static void makeData(){
        Product_Information__c newProductInformation = new Product_Information__c();
        newProductInformation.Product__c = 'Standard';
        newProductInformation.Country__c = 'DE';
        newProductInformation.Commission__c = 'Cost per Calendar Month';
        newProductInformation.value__c = '0';
        insert newProductInformation;

        Contact newContact = new Contact();
        newContact.LastName = 'Monzonis';
        newContact.Product__c = 'Standard';
        newContact.Home_Country__c = 'DE';
        newContact.UUID__c = CONTACT_IDENTIFIER;
        insert newContact;
    }

    @isTest
    public static void givenValidUUID_whenGetProductInformationIsCall_thenReturnProductInformation(){

        RestRequest request = new RestRequest();
        request.requestURI = '/contact/v0/*';
        request.params.put('UUID', CONTACT_IDENTIFIER);
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestResponse response = new RestResponse();
        RestContext.response = response;

        Test.startTest();
        REST_ContactProductInformation.getProductInformation();
        Test.stopTest();

        REST_ContactProductInformation.ProductInformationWrapperList responseBody = (REST_ContactProductInformation.ProductInformationWrapperList) JSON.deserialize(response.responseBody.toString(), REST_ContactProductInformation.ProductInformationWrapperList.class);

        System.assertEquals(CONTACT_IDENTIFIER, responseBody.contactIdentifier);
        System.assertEquals('Cost per Calendar Month', responseBody.productInformationList.get(0).productType);
    }

    @isTest
    public static void givenNonParameter_whenGetProductInformationIsCall_thenReturnError(){
        RestRequest request = new RestRequest();
        request.requestURI = '/contact/v0/*';
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestResponse response = new RestResponse();
        RestContext.response = response;

        Test.startTest();
        REST_ContactProductInformation.getProductInformation();
        Test.stopTest();

        System.assertEquals(400, response.statusCode);
    }

    @isTest
    public static void givenInvalidUUID_whenGetProductInformationIsCall_thenReturnError(){
        RestRequest request = new RestRequest();
        request.requestURI = '/contact/v0/*';
        request.params.put('UUID', 'non-exist');
        request.httpMethod = 'GET';

        RestContext.request = request;
        RestResponse response = new RestResponse();
        RestContext.response = response;

        Test.startTest();
        REST_ContactProductInformation.getProductInformation();
        Test.stopTest();

        System.assertEquals(404, response.statusCode);
    }
}