/**
 * ContactSelectorI implementation.
 */
public with sharing class ContactSelector implements ContactSelectorI {

    private static ContactSelectorI instance;

    public static ContactSelectorI getInstance(){
        if(instance == null){
            instance = new ContactSelector();
        }
        return instance;
    }

    public Contact getContactById(Id contactId){
        return [SELECT Product__c, Home_Country__c FROM Contact WHERE id = :contactId];
    }

    public Contact getContactByInternalID(String UUID){
        return [SELECT Product__c, Home_Country__c FROM Contact WHERE UUID__c = :UUID];
    }
}