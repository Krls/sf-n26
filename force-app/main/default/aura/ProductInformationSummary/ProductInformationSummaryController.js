({
    doInit: function (component, event, helper) {
        
        component.set("v.showSpinner", "true");

        component.set('v.columns', [
            {label: 'Description', fieldName: 'commission', type: 'text'},
            {label: 'Value', fieldName: 'value', type: 'text'}
        ]);

        helper.getData(component, event, helper);
        
        component.set("v.showSpinner", "false");
    }
})
