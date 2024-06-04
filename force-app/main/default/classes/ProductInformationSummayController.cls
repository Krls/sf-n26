public with sharing class ProductInformationSummayController {
    
    @AuraEnabled
    public static List<ProductConfiguration> getProductInformationByCase(String caseId){
        try {
            List<ProductConfiguration> result = null;

            //TODO: move to selector layer.
            Case currentCase = [SELECT contact.id FROM case WHERE id = :caseId];
            System.debug(currentCase);
            Contact currentContact = [SELECT Product__c, Home_Country__c FROM Contact WHERE id = :currentCase.contact.Id];
            System.debug(currentContact);
            List<Product_Information__c> productInfoList = [SELECT Commission__c, Value__c 
                                                            FROM Product_Information__c 
                                                            WHERE Country__c = :currentContact.Home_Country__c AND 
                                                            Product__c = :currentContact.Product__c];

            if(productInfoList?.size()>0){
                result = new List<ProductConfiguration> ();
                for(Product_Information__c pi : productInfoList){
                    result.add(new ProductConfiguration(pi.Commission__c,  pi.value__c));
                }
            } 
            return result;
        } catch (Exception e) {
            AuraHandledException auraException = new AuraHandledException('An error occurred while trying to obtain product information.');
            auraException.setMessage('An error occurred while trying to obtain product information.');
            throw auraException;
        }
    }

    public class ProductConfiguration{
        @AuraEnabled
        public String commission;
        @AuraEnabled
        public String value;

        public ProductConfiguration (String commission, String value){
            this.commission = commission;
            this.value = value;
        }
    }
}