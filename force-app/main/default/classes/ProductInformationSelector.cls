public with sharing class ProductInformationSelector implements ProductInformationSelectorI{

    private static ProductInformationSelectorI instance;

    public static ProductInformationSelectorI getInstance(){
        if(instance == null){
            instance = new ProductInformationSelector();
        }
        return instance;
    }

    public List<Product_Information__c> getProductInformationListByProductAndCountry(String product, String country){
        return [SELECT Commission__c, Value__c 
                    FROM Product_Information__c 
                    WHERE Country__c = :country AND 
                    Product__c =:product];
    }
}