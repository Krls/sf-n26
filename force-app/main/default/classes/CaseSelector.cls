/**
 * CaseSelectorI implementation.
 */
public with sharing class CaseSelector implements CaseSelectorI {
    
    private static CaseSelectorI instance;

    public static CaseSelectorI getInstance(){
        if(instance == null){
            instance = new CaseSelector();
        }
        return instance;
    }

    public Case getCaseByStringID(String caseId){
        return [SELECT status, origin, contact.id FROM case WHERE id = :caseId];
    }
}