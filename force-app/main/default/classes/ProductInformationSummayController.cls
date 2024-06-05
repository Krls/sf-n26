public with sharing class ProductInformationSummayController {
    
    @AuraEnabled
    public static List<ProductConfiguration> getProductInformationByCase(String caseId){
        try {
            CaseSelectorI caseSelector = CaseSelector.getInstance();
            Case currentCase = caseSelector.getCaseByStringID(caseId);

            ContactSelectorI contactSelector = ContactSelector.getInstance();
            Contact currentContact = contactSelector.getContactById(currentCase.contact.Id);
            
            ProductInformationSelectorI proInfSelector = ProductInformationSelector.getInstance();
            List<Product_Information__c> productInfoList = proInfSelector.getProductInformationListByProductAndCountry(currentContact.Product__c, currentContact.Home_Country__c);
            
            List<ProductConfiguration> result = null;
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