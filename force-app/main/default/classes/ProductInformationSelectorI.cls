/**
 * Interface for ProductInformation__c selector layer.
 */
public interface ProductInformationSelectorI {

    /**
     * @description Method to get instance of the selector.
     * 
     * @return intance of ProductInformationSelectorI
     */
    ProductInformationSelectorI getInstance();

    /**
     * @description Method to get the product information list related to a product and country.
     * 
     * @param product to apply in the filter.
     * @param country to apply in the filter.
     * 
     * @return List of Product_Information__c
     */
    List<Product_Information__c> getProductInformationListByProductAndCountry(String product, String country);


}