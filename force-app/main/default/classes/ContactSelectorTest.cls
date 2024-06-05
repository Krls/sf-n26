@isTest
public with sharing class ContactSelectorTest {

    @isTest
    static void getIntanceTest(){
        ContactSelectorI contactSelector = ContactSelector.getInstance();
        System.assert(contactSelector instanceof ContactSelector);
    }

    @isTest
    static void givenUUID_whenCallGetContactByUUID_thenContactIsReturned(){

        Contact newContact = new Contact();
        newContact.LastName = 'Monzonis';
        newContact.Product__c = 'Standard';
        newContact.Home_Country__c = 'DE';
        newContact.UUID__c = 'UWHUDEIhiahiedu';
        insert newContact;

        ContactSelectorI contactSelector = ContactSelector.getInstance();
        Contact currentContact = contactSelector.getContactByInternalID('UWHUDEIhiahiedu');

        System.assertEquals('Standard', currentContact.Product__c);
    }

    @isTest
    static void givenContactId_whenCallGetContactByID_thenContactIsReturned(){

        Contact newContact = new Contact();
        newContact.LastName = 'Monzonis';
        newContact.Product__c = 'Standard';
        newContact.Home_Country__c = 'DE';
        newContact.UUID__c = 'UWHUDEIhiahiedu';
        insert newContact;

        ContactSelectorI contactSelector = ContactSelector.getInstance();
        Contact currentContact = contactSelector.getContactById(newContact.id);

        System.assertEquals('Standard', currentContact.Product__c);
    }
}