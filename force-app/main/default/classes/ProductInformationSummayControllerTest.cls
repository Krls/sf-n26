@isTest
public class ProductInformationSummayControllerTest {

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
    public static void givenCaseId_whenGetProductInformationIsCall_thenReturnListOfData(){

        Contact newContact = new Contact();
        newContact.LastName = 'Monzonis';
        newContact.Product__c = 'Standard';
        newContact.Home_Country__c = 'DE';
        insert newContact;

        Case newCase = new Case();
        newCase.status = 'New';
        newCase.origin = 'Email';
        newCase.ContactId = newContact.id;
        insert newCase;

        List<ProductInformationSummayController.ProductConfiguration> products = ProductInformationSummayController.getProductInformationByCase(newCase.Id);

        System.assertEquals(1, products.size());
        System.assertEquals('Cost per Calendar Month', products.get(0).commission);
        System.assertEquals('0', products.get(0).value);
    }

    @isTest
    public static void givenCaseId_whenGetProductInformationIsCallWithError_thenReturnException(){

        Contact newContact = new Contact();
        newContact.LastName = 'Monzonis';
        newContact.Product__c = 'Standard';
        newContact.Home_Country__c = 'DE';
        insert newContact;

        Case newCase = new Case();
        newCase.status = 'New';
        newCase.origin = 'Email';
        newCase.Contact = newContact;
        insert newCase;

        try{
            List<ProductInformationSummayController.ProductConfiguration> products = ProductInformationSummayController.getProductInformationByCase(newCase.Id);
        } catch(AuraHandledException ex){
            System.assertEquals('An error occurred while trying to obtain product information.', ex.getMessage());
        }
    }
}