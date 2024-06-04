({
    getData : function(component, event, helper) {
        var action = component.get("c.getProductInformationByCase");

        var caseId = component.get("v.recordId");
        action.setParams({
            "caseId": caseId 
        });
        
        action.setCallback(this, function(response){    
            var state = response.getState(); 
            
            if(state==='SUCCESS'){
                var response =  response.getReturnValue();
                if(response != null){
                    component.set("v.data",response);
                }
            }
            if( state == 'ERROR' ){
                //TODO:Show error message
            }
        });
        $A.enqueueAction(action);
    }
})