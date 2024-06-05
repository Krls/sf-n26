@isTest
public with sharing class ProductInformationSelectorTest {

    @TestSetup
    static void makeData(){
        Product_Information__c newProductInformation = new Product_Information__c();
        newProductInformation.Product__c = 'Standard';
        newProductInformation.Country__c = 'DE';
        newProductInformation.Commission__c = 'Cost per Calendar Month';
        newProductInformation.value__c = '0';
        insert newProductInformation;
    }

    @isTest
    static void getIntanceTest(){
        ProductInformationSelectorI prodInfoSelector = ProductInformationSelector.getInstance();
        System.assert(prodInfoSelector instanceof ProductInformationSelector);
    }

    @isTest
    static void givenProductAndConutry_whenCallGetProductInformation_thenAListOfProductInformationIsReturned(){

        ProductInformationSelectorI prodInfoSelector = ProductInformationSelector.getInstance();
        List<Product_Information__c> listOfProducts = prodInfoSelector.getProductInformationListByProductAndCountry('Standard','DE');

        System.assertEquals(1, listOfProducts.size());
        System.assertEquals('Cost per Calendar Month', listOfProducts.get(0).Commission__c);

    }
}