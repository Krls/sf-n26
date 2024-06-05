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
                } else {

                }
            } else {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "type":"error",
                    "message": "An error ocurred trying to get Product information, please ask your admin for help."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})