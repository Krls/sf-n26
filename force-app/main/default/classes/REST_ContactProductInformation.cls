@RestResource(urlMapping='/contact/v0/*')
global without sharing class REST_ContactProductInformation {

    @TestVisible
    private static final String ERROR_MESSAGE = 'An error ocurred to get the contact information';
    @TestVisible
    private static final String ERROR_STATUS = 'Failure';

    @HttpGet
    webservice static void getProductInformation(){

        RestRequest request = RestContext.request;
        String contactIdentifier = request.params.get('UUID');

        RestResponse response = RestContext.response;
        response.addHeader('Content-Type', 'application/json');

        if(contactIdentifier != null &&
            !String.isEmpty(contactIdentifier)){
            try{
                ContactSelectorI contactSelector = ContactSelector.getInstance();
                Contact currentContact = contactSelector.getContactByInternalID(contactIdentifier);
                
                ProductInformationSelectorI proInfSelector = ProductInformationSelector.getInstance();
                List<Product_Information__c> productInfoList = proInfSelector.getProductInformationListByProductAndCountry(currentContact.Product__c, currentContact.Home_Country__c);

                ProductInformationWrapperList productList = generateResponse(contactIdentifier, productInfoList);
                response.statusCode = 200;
                response.responseBody = Blob.valueOf(JSON.serialize(productList));
            } catch (QueryException ex){
                response.statusCode = 404;
                response.responseBody = Blob.valueOf(JSON.serialize(new Error(ERROR_STATUS, ERROR_MESSAGE)));                
            }
        } else {
            response.statusCode = 400;
            response.responseBody = Blob.valueOf(JSON.serialize(new Error(ERROR_STATUS, ERROR_MESSAGE)));
        }
    }

    private static ProductInformationWrapperList generateResponse(String contactIdentifier, List<Product_Information__c> productInfoList ){
        ProductInformationWrapperList result = new ProductInformationWrapperList();
        result.contactIdentifier = contactIdentifier;

        List<ProductInformationWrapper> piWrapperList = new List<ProductInformationWrapper>();
        for(Product_Information__c pic : productInfoList){
            piWrapperList.add(new ProductInformationWrapper(pic.Commission__c, pic.Value__c));
        }
        result.productInformationList = piWrapperList;
        return result;
    }

    public class Error{
        public String status;
        public String message;
        
        public Error(String status, String message){
            this.status = status;
            this.message = message;
        }
    }

    public class ProductInformationWrapperList{
        public String contactIdentifier;
        public List<ProductInformationWrapper> productInformationList;
    }

    public class ProductInformationWrapper{
        public String productType;
        public String value;

        public ProductInformationWrapper(String productType, String value){
            this.productType = productType;
            this.value = value;
        }
    }
}