# Salesforce N26 Test Case project

A little bit of implementation information

## Data Model

In order to store the data related to the product information, I have created the custom object Product_information__c, with it I try that the operations team can maintain the information of the tables in a simple way.

I have assumed that products, countries and commission rates (I made up the name) are data to be created according to business needs, that's why I have created 3 global picklists and I have assumed that they will be maintained by a Salesforce admin/developer.

To avoid duplicate product information I have created a flow that validates on creation.
